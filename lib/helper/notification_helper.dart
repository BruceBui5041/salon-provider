import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:salon_provider/common/Utils.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:salon_provider/config/injection_config.dart';
import 'package:salon_provider/providers/app_pages_provider/notification_provider.dart';

class NotificationHelper {
  static final NotificationHelper _instance = NotificationHelper._internal();
  factory NotificationHelper() => _instance;
  NotificationHelper._internal();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    // Request permission for notifications
    await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    // Initialize local notifications
    const initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const initializationSettingsIOS = DarwinInitializationSettings();
    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    await _localNotifications.initialize(initializationSettings);

    // Handle background messages
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

    // Handle notification tap when app is in background
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessageOpenedApp);
  }

  Future<void> _handleForegroundMessage(RemoteMessage message) async {
    getIt.get<NotificationProvider>().pushMessage(message);
    log('Message received in foreground: ${message.toString()}');
    await _showNotification(message);
  }

  Future<void> _handleMessageOpenedApp(RemoteMessage message) async {
    log('Message opened app: ${message.messageId}');
    // Handle navigation or other actions when notification is tapped
  }

  Future<void> _showNotification(RemoteMessage message) async {
    final androidDetails = AndroidNotificationDetails(
      'default_channel',
      'Default Channel',
      channelDescription: 'Default notification channel',
      importance: Importance.max,
      priority: Priority.high,
    );

    final iosDetails = const DarwinNotificationDetails();

    final details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _localNotifications.show(
      message.hashCode,
      message.notification?.title ?? 'New Message',
      message.notification?.body ?? '',
      details,
      payload: message.data.toString(),
    );
  }

  Future<String?> getToken({Function(String)? onSuccess}) async {
    try {
      var token = await _firebaseMessaging.getToken();
      if (onSuccess != null) {
        onSuccess(token ?? '');
      }
      return token;
    } catch (e) {
      log('Error getting token: $e');
      return null;
    }
  }

  Future<String?> generateDeviceToken({Function(String)? onSuccess}) async {
    try {
      // Get the current token
      String? token = await _firebaseMessaging.getToken();

      // Listen for token refresh
      _firebaseMessaging.onTokenRefresh.listen((newToken) {
        token = newToken;
        Utils.debug('FCM Token refreshed: $newToken');
        // Here you can send the new token to your backend server
        if (onSuccess != null) {
          onSuccess(newToken);
        }
      });

      return token;
    } catch (e) {
      log('Error generating device token: $e');
      return null;
    }
  }
}

// This needs to be a top-level function
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  log('Handling background message: ${message.messageId}');
  // Initialize Firebase if needed
  // await Firebase.initializeApp();
}
