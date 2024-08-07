import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobile_chaseapp/app_router.dart';
// import 'package:mobile_chaseapp/firebase_options.dart';
import 'package:mobile_chaseapp/firebase_cloud_messaging_provider.dart';
import 'package:mobile_chaseapp/local_notification.dart';
import 'package:mobile_chaseapp/utils/app_navigator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseCloudMessagingProvider.init();
  LocalNotification.init();
  FirebaseCloudMessagingProvider.onFirebaseMessageReceived();
  FirebaseCloudMessagingProvider.setupInteractedMessage();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, child) {
        SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
        return GetMaterialApp(
          title: 'Chase Mobile',
          navigatorKey: AppNavigator.navigatorKey,
          initialRoute: AppRouter.initialRouterName,
          onGenerateRoute: AppRouter.router,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: 'FC Iconic',
          ),
          builder: (context, child) {
            return AnnotatedRegion<SystemUiOverlayStyle>(
              value: const SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
              ),
              child: child ?? const SizedBox.shrink(),
            );
          },
        );
      },
    );
  }
}
