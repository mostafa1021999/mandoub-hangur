import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../common/constants/constanat.dart';
import '../shared_preferences.dart';
import 'notification_display_handler.dart';

class SocketService {
  late IO.Socket _socket;

  // Connect and listen to notifications
  void connectAndSubscribe(String userId, String userType) {
    _socket = IO.io(
      'http://notifications.teslm.shop',
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
    } catch (e, stackTrace) {
      debugPrint("Error when showing notification: $e");
      debugPrint("Stack trace: $stackTrace");
    }
  }

  // Disconnect the socket
  void disconnect() {
    _socket.disconnect();
  }
}
