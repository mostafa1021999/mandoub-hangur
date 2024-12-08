import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../featers/order_handle/orders_data_handler.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void initialize(Function(String?) onNotificationTap) {
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    );

    _notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) async {
        if (notificationResponse.payload != null) {
          onNotificationTap(notificationResponse.payload);
        }

        // Check for action ID
        if (notificationResponse.actionId == 'confirmOrder') {
          // Handle the action button tap
          OrdersDataHandler.acceptOrder(orderID: notificationResponse.payload!);
          print('Confirm Action button pressed!');
          // Add your action handling logic here
        }
      },
    );
  }

  static Future<void> showNotification(
    int id,
    String title,
    String body,
    String sourceID, {
    int? durationInSeconds,
  }) async {
    NotificationDetails notificationDetails = const NotificationDetails(
      android: AndroidNotificationDetails('main_channel', 'Main Channel',
          importance: Importance.max,
          priority: Priority.high,
          colorized: true,
          icon: '@mipmap/ic_launcher',
          sound: RawResourceAndroidNotificationSound(
              'notification_sound'), // Custom sound
          actions: <AndroidNotificationAction>[
            AndroidNotificationAction('confirmOrder', 'Confirm',
                showsUserInterface: true),
          ]),
      iOS: DarwinNotificationDetails(),
    );

    await _notificationsPlugin.show(
      id,
      title,
      body,
      notificationDetails,
      payload: sourceID,
    );
    // If a duration is provided, cancel the notification after that duration
    if (durationInSeconds != null) {
      Future.delayed(Duration(seconds: durationInSeconds), () async {
        await _notificationsPlugin.cancel(id);
      });
    }
  }
}
