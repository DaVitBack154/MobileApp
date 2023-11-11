import 'dart:convert';
import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:mobile_chaseapp/component/bottombar.dart';
import 'package:mobile_chaseapp/local_notification.dart';
import 'package:mobile_chaseapp/received_notification.dart';
import 'package:mobile_chaseapp/screen/homepage/notify.dart';
import 'package:mobile_chaseapp/screen/piccode/pincode.dart';
import 'package:mobile_chaseapp/utils/app_navigator.dart';
import 'package:mobile_chaseapp/utils/key_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseCloudMessagingProvider {
  FirebaseCloudMessagingProvider._();

  static FirebaseMessaging get firebaseMessaging => FirebaseMessaging.instance;

  static Future<void> init() async {
    await firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: true,
      provisional: false,
      sound: true,
    );

    await firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }

  static Future<String?> get getToken async =>
      await firebaseMessaging.getToken();

  static void onFirebaseMessageReceived({VoidCallback? onListen}) {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      Map<String, dynamic> data = message.data;

      if (onListen != null) {
        onListen();
      } else {
        print('this notification');
        if (notification != null && android != null) {
          LocalNotification.showNotification(
            ReceivedNotification(
              id: notification.hashCode,
              title: notification.title,
              body: notification.body,
              payload: jsonEncode(data),
              imageUrl: android.imageUrl,
            ),
          );
        }
      }
    });
  }

  /// Define a top-level named handler which background/terminated messages will call.
  static Future<void> firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    // If you're going to use other Firebase services in the background, such as Firestore,
    // make sure you call `initializeApp` before using other Firebase services.
    await Firebase.initializeApp();
  }

  /// Get notification setting for iOS
  static Future<NotificationSettings?> getNotificationSettings() async {
    return await firebaseMessaging.getNotificationSettings();
  }

  /// The default behavior on both Android & iOS is to open the application.
  /// If the application is terminated it will be started,
  /// if it is in the background it will be brought to the foreground.
  /// Depending on the content of a notification,
  /// you may wish to handle the users interaction when the application opens.
  ///
  // It is assumed that all messages contain a data field with the key 'type'
  static Future<void> setupInteractedMessage() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage = await firebaseMessaging.getInitialMessage();

    // If the message also contains a data property with a "type" of "product",
    // navigate to a product screen
    if (initialMessage != null) {
      // if (onCallback != null) {
      //   onCallback('Go to notify');
      // }
      _handleMessage(initialMessage);
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  /// Listen to firebase push notification click listener
  static void _handleMessage(RemoteMessage message) {
    // final prefs = await SharedPreferences.getInstance();
    // String? pin = prefs.getString(KeyStorage.pin);

    // print('LINK ${message.data['link']}');
    if (message.data['link'] != null) {
      final String link = message.data['link'];
    }

    AppNavigator.pushNamed(
      PinCode.routeName,
      arguments: const PinCodeArgs(
        isGotoNotif: true,
      ),
    );
  }
}
