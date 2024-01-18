// ignore_for_file: use_build_context_synchronously
import 'package:animations/animations.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mobile_chaseapp/controller/getprofile_controller.dart';
import 'package:mobile_chaseapp/firebase_cloud_messaging_provider.dart';
import 'package:mobile_chaseapp/local_notification.dart';
import 'package:mobile_chaseapp/model/respon_user.dart';
import 'package:mobile_chaseapp/screen/login_page/login_page.dart';
import 'package:mobile_chaseapp/utils/app_navigator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'component/bottombar.dart';
import 'screen/login_page/pin_page.dart';
import 'screen/piccode/pincode.dart';
import 'utils/key_storage.dart';

class Loadding extends StatefulWidget {
  static const routeName = "Loadding";
  const Loadding({super.key});

  @override
  State<Loadding> createState() => _LoaddingState();
}

class _LoaddingState extends State<Loadding> {
  final ProfileController _profileController = ProfileController();
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), () async {
      RemoteMessage? message = await FirebaseCloudMessagingProvider
          .firebaseMessaging
          .getInitialMessage();

      if (message != null) return;

      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString(KeyStorage.token);
      String? pin = prefs.getString(KeyStorage.pin);
      // bool cfPin = prefs.getBool(KeyStorage.cfPin) ?? false;
      if (token == null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Bottombar(),
          ),
        );
      } else {
        UserModel? userModel =
            await _profileController.fetchProfileData1(token);
        if (userModel == null) {
          prefs.clear();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const Bottombar(),
            ),
          );
        } else {
          // if (pin != null) {
          //   AppNavigator.pushReplacementNamed(
          //     PinCode.routeName,
          //     arguments: const PinCodeArgs(isGotoNotif: false),
          //   );
          // }
          pin == null
              ? Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Pin_page(onBack: false),
                  ),
                )
              : AppNavigator.pushReplacementNamed(
                  PinCode.routeName,
                  arguments: const PinCodeArgs(isGotoNotif: false),
                );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Color(0xFF305553),
            width: width,
            height: height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/image/Armaload.gif',
                  fit: BoxFit.cover,
                  height: height * 0.25.h,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
