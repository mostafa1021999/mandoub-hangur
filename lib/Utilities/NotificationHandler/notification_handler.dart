import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:untitled2/common/colors/theme_model.dart';
import 'package:untitled2/common/text_style_helper.dart';
import 'package:untitled2/common/translate/app_local.dart';

import '../../common/constants/constanat.dart';
import '../../common/translate/strings.dart';
import '../../cubit/rider_cubit.dart';
import '../../featers/home/cubit/home_cubit.dart';
import '../../featers/order_handle/orders_data_handler.dart';
import '../../main.dart';
import '../shared_preferences.dart';
import 'notification_display_handler.dart';

class SocketService {
  late IO.Socket _socket;

  // Connect and listen to notifications
  void connectAndSubscribe(String userId, String userType) {
    _socket = IO.io(
      kDebugMode
          ? 'http://canary-notifications.teslm.shop'
          : 'http://notifications.teslm.shop',
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .build(),
    );

    // Connect to the server
    _socket.connect();

    // On connection success
    _socket.onConnect((_) {
      debugPrint('Connected to the server');

      String message = json.encode({
        'userId': userId,
        'userType': userType,
        "location": {"type": "Point", "coordinates": SharedPref.getLatLng()}
      });
      debugPrint(">>>>>>>>>>>>${message}");
      // Emit subscription event
      _socket.emit('subscribeToNotifications', message);
    });

    // Listen for subscription confirmation
    _socket.on('notificationSubscribed', (data) {
      if (data['success'] == true) {
        debugPrint('Subscription successful!');
      } else {
        debugPrint('Subscription failed!');
      }
    });

    _socket.onError((error) {
      debugPrint('Socket Error: $error');
    });

    _socket.on('pong', (_) {
      debugPrint('Pong received');
    });

    // Listen for notifications
    _socket.on('notification', (data) {
      debugPrint('Notification received: $data');
      handleIncomingNotification(data);
    });

    // Handle disconnection
    _socket.onDisconnect((_) {
      debugPrint('Disconnected from the server');
    });
  }

  void handleIncomingNotification(Map<String, dynamic> data) {
    try {
      debugPrint("Language::::: $language");
      String notificationsViewerHelperLang = language == 'en' ? 'en' : 'ar';

      String title = data.containsKey('title') && data['title'] is Map
          ? data['title'][notificationsViewerHelperLang] ?? 'Notification'
          : 'Notification';
      debugPrint("Notification title: $title");

      String body = data.containsKey('body') && data['body'] is Map
          ? data['body'][notificationsViewerHelperLang] ??
              'You have a new message'
          : 'You have a new message';
      String sourceID = data['orderId'];
      debugPrint("Notification body: $body");

      NotificationService.showNotification(1, title, body, sourceID,
          durationInSeconds: 60);
      HomeCubit.get(navigatorKey.currentState!.context).getRequestedOrders();
      _showNotificationDialog(title, body, sourceID);
    } catch (e, stackTrace) {
      debugPrint("Error when showing notification: $e");
      debugPrint("Stack trace: $stackTrace");
    }
  }

  ///   ----------------   Show dialog when received notification
  // Function to show dialog on notification
  void _showNotificationDialog(String title, String body, String sourceID) {
    AwesomeDialog(
      context: navigatorKey.currentState!.context,
      animType: AnimType.scale,
      dialogType: DialogType.noHeader,
      autoHide: const Duration(minutes: 1),
      body: Center(
        child: Text(
          body,
          style:
              TextStyleHelper.of(navigatorKey.currentState!.context).medium18,
        ),
      ),
      btnOkText: Strings.acceptOrder.tr(navigatorKey.currentState!.context),
      title: 'This is Ignored',
      desc: 'This is also Ignored',
      btnOkOnPress: () {
        OrdersDataHandler.acceptOrder(orderID: sourceID).then((value) {
          value.fold((l) {}, (r) {
            Fluttertoast.showToast(
                msg: Strings.orderAcceptedSuccessfully
                    .tr(navigatorKey.currentState!.context),
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor:
                    ThemeModel.of(navigatorKey.currentState!.context).primary,
                textColor: Colors.white,
                fontSize: 18.0);
            RiderCubit.get(navigatorKey.currentState!.context)
                .changeNavigator(1);
          });
        });
      },
    ).show();
    // showDialog(
    //   context: navigatorKey.currentState!.context,
    //   barrierDismissible: true,
    //   builder: (BuildContext context) {
    //     return AlertDialog(
    //       title: Text(title,
    //           style:
    //               const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    //       content: Text(body, style: const TextStyle(fontSize: 16)),
    //       actions: [
    //         CustomButtonWidget(
    //           title: "قبول الطلب",
    //           onPressed: () {},
    //         ),
    //       ],
    //     );
    //   },
    // );
  }

  // Disconnect the socket
  void disconnect() {
    _socket.disconnect();
  }
}
