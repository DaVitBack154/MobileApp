// import 'dart:convert';

// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// Future<void> handleBg(RemoteMessage message) async {
//   print(message.notification?.title);
//   print(message.notification?.body);
//   print(message.data);
// }

// late AndroidNotificationChannel channel;
// late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
// bool isFlutterLocalNotificationsInitialized = false;

// class FirebaseApi {
//   // create
//   final _firebaseMessage = FirebaseMessaging.instance;

//   handleMessage(RemoteMessage? message) {
//     if (message == null) {
//       return;
//     }
//     print('title:${message.notification?.title}');
//   }

//   void initLocalNotification() async {
//     final InitializationSettings initializationSettings =
//         InitializationSettings(
//       android: AndroidInitializationSettings("@drawable/ic_launcher"),
//     );

//     await flutterLocalNotificationsPlugin.initialize(
//       initializationSettings,
//       onDidReceiveNotificationResponse:
//           (NotificationResponse notificationResponse) {
//         print('res ${notificationResponse.payload}');
//       },
//     );
//   }

//   Future<void> setupFlutterNotifications() async {
//     if (isFlutterLocalNotificationsInitialized) {
//       return;
//     }
//     channel = const AndroidNotificationChannel(
//       'message', // id
//       'title', // title
//       description:
//           'This channel is used for important notifications.', // description
//       importance: Importance.high,
//     );

//     flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

//     /// Create an Android Notification Channel.
//     ///
//     /// We use this channel in the `AndroidManifest.xml` file to override the
//     /// default FCM channel to enable heads up notifications.
//     await flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//             AndroidFlutterLocalNotificationsPlugin>()
//         ?.createNotificationChannel(channel);

//     /// Update the iOS foreground notification presentation options to allow
//     /// heads up notifications.
//     await FirebaseMessaging.instance
//         .setForegroundNotificationPresentationOptions(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//     isFlutterLocalNotificationsInitialized = true;
//   }

//   initPushNotification() {
//     _firebaseMessage.getInitialMessage().then(handleMessage);
//     FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
//     FirebaseMessaging.onBackgroundMessage(handleBg);
//     FirebaseMessaging.onMessage.listen(showFlutterNotification);
//   }

//   void showFlutterNotification(RemoteMessage message) {
//     RemoteNotification? notification = message.notification;
//     AndroidNotification? android = message.notification?.android;
//     if (notification != null && android != null && !kIsWeb) {
//       flutterLocalNotificationsPlugin.show(
//         notification.hashCode,
//         notification.title,
//         notification.body,
//         payload: jsonEncode(message.toMap()),
//         NotificationDetails(
//           android: AndroidNotificationDetails(
//             channel.id,
//             channel.name,
//             channelDescription: channel.description,
//             icon: android.smallIcon,
//           ),
//         ),
//       );
//     }
//   }

//   initNotification() async {
//     await _firebaseMessage.requestPermission();
//     final fcmToken = await _firebaseMessage.getToken();
//     print('Token: ${fcmToken}');
//     await setupFlutterNotifications();
//     initLocalNotification();
//     initPushNotification();
//   }
// }
