import 'dart:io';
import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';
import 'package:live_football_score/core/app_route.dart';

class NotificationServices {
  // Initialize Firebase Messaging instance
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  // Initialize Flutter Local Notifications Plugin instance
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  ///------Request notification permissions from the user------///
  void requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    // Handle permission results
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint("Permission granted.");
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      debugPrint("Provisional permission granted.");
    } else {
      debugPrint("Permission denied.");
    }
  }

  ///------Initialize Firebase and listen for foreground messages------///
  void firebaseInit(BuildContext context) {
    FirebaseMessaging.onMessage.listen(
      (message) {
        // Print notification details to console
        debugPrint(message.notification!.title.toString());
        debugPrint(message.notification!.body.toString());
        debugPrint(message.data['type']);

        // Show notification on Android if the app is in foreground
        if (Platform.isAndroid) {
          if (context.mounted) {
            initLocalNotifications(context, message); // Initialize local notifications
          }
          showNotification(message); // Show the notification
        }
      },
    );
  }

  ///------Initialize local notifications for Android and iOS------///
  void initLocalNotifications(BuildContext context, RemoteMessage message) async {
    var androidInitializationSettings = const AndroidInitializationSettings("@mipmap/ic_launcher");
    var iosInitializationSettings = const DarwinInitializationSettings();

    var initializationSettings = InitializationSettings(
      android: androidInitializationSettings, // Android initialization settings
      iOS: iosInitializationSettings, // iOS initialization settings
    );

    // Handle notification response when the app is in background or terminated
    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (payload) {
        handleMessage(context, message); // Navigate to the appropriate screen
      },
    );
  }

  ///------Show the notification when received in the foreground------///
  Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
      Random.secure().nextInt(100000).toString(), // Randomly generate a channel ID
      "High importance notifications", // Channel name
      importance: Importance.max, // Importance level for notifications
    );

    // Configure Android notification settings
    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      channel.id.toString(),
      channel.name.toString(),
      channelDescription: 'Your channel description',
      importance: Importance.high,
      priority: Priority.high,
      ticker: 'ticker',
    );

    // Configure iOS notification settings
    DarwinNotificationDetails iosNotificationDetails = const DarwinNotificationDetails(
      presentAlert: true, // Display an alert
      presentBadge: true, // Update the badge number
      presentSound: true, // Play a sound
    );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails, // Notification details for Android
      iOS: iosNotificationDetails, // Notification details for iOS
    );

    // Show the notification
    Future.delayed(
      Duration.zero,
      () {
        _flutterLocalNotificationsPlugin.show(
          0, // Notification ID
          message.notification!.title.toString(), // Notification title
          message.notification!.body.toString(), // Notification body
          notificationDetails, // Notification details
        );
      },
    );
  }

  ///------Handle notification interactions when the app is launched or brought to foreground------///
  Future<void> setupInteractMessage(BuildContext context) async {
    // Handle notifications when the app is terminated
    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      if (context.mounted) {
        handleMessage(context, initialMessage); // Navigate to the appropriate screen
      }
    }

    // Handle notifications when the app is in background and brought to foreground
    FirebaseMessaging.onMessageOpenedApp.listen(
      (event) {
        if (context.mounted) {
          handleMessage(context, event); // Navigate to the appropriate screen
        }
      },
    );
  }

  ///------Navigate to a specific screen based on the notification's data payload------///
  void handleMessage(BuildContext context, RemoteMessage message) {
    if (message.data['type'] == 'message') {
      context.pushNamed(AppRoute.notificationScreen); // Navigate to the notification screen
    }
  }

  ///------Get the device's FCM token------///
  Future<String> getDeviceToken() async {
    String? token = await messaging.getToken();
    return token!;
  }

  ///------Listen for FCM token refresh and handle it------///
  void isTokenRefresh() async {
    messaging.onTokenRefresh.listen((event) {
      event.toString(); // Log the refreshed token
      debugPrint("Token refresh");
    });
  }
}
