// ignore_for_file: use_build_context_synchronously

// import 'package:flutter/cupertino.dart';
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
      bool cfPin = prefs.getBool(KeyStorage.cfPin) ?? false;
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
          pin == null || !cfPin
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

  Future<bool> confirmAllrowNotificationDialog(
      BuildContext context, String title, String? message) async {
    final formkey = GlobalKey<FormState>();

    Future<bool> onWillPop() async {
      return false;
    }

    final query = MediaQuery.of(context);

    bool status = await showModal(
      configuration: const FadeScaleTransitionConfiguration(
        transitionDuration: Duration(milliseconds: 300),
        reverseTransitionDuration: Duration(milliseconds: 150),
        barrierDismissible: false,
      ),
      context: context,
      builder: (context) => MediaQuery(
        data: query.copyWith(
          textScaleFactor: query.textScaleFactor.clamp(1.0, 1.0),
        ),
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(
            FocusNode(),
          ),
          behavior: HitTestBehavior.opaque,
          child: LayoutBuilder(
            builder: (context, constraints) => WillPopScope(
              onWillPop: () => onWillPop().catchError(
                (error) {
                  if (kDebugMode) {
                    print(
                      'error ===>> $error',
                    );
                  }
                  return false;
                },
              ),
              child: Scaffold(
                // backgroundColor: MyConstant.clear,
                body: Form(
                  key: formkey,
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Dialog(
                            shape: RoundedRectangleBorder(
                                // borderRadius:
                                //     MyConstant.borderRadiusCircularSet30(
                                //         constraints),
                                ),
                            child: Container(
                              constraints: BoxConstraints(
                                  // minHeight: MyConstant.setConstraintsMaxHeight(
                                  //     constraints, 320),
                                  minHeight: 320.h),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  //   SizedBox(
                                  //     height: MyConstant.setConstraintsMaxHeight(
                                  //         constraints, 160),
                                  //     width: double.infinity,
                                  //     child: ClipRRect(
                                  //       borderRadius: BorderRadius.only(
                                  //         topLeft: MyConstant.radiusCircularSet30(
                                  //             constraints),
                                  //         topRight:
                                  //             MyConstant.radiusCircularSet30(
                                  //                 constraints),
                                  //       ),
                                  //       child: SizedBox.fromSize(
                                  //         child:
                                  //             ShowImage(path: MyConstant.confirm),
                                  //       ),
                                  //     ),
                                  //   ),
                                  //   Container(
                                  //     padding: EdgeInsets.only(
                                  //       top: MyConstant.setConstraintsMaxHeight(
                                  //           constraints,
                                  //           message != null ? 20 : 30),
                                  //       bottom:
                                  //           MyConstant.setConstraintsMaxHeight(
                                  //               constraints, 15),
                                  //     ),
                                  //     constraints: BoxConstraints(
                                  //       minHeight: MyConstant
                                  //               .setConstraintsMaxHeight(
                                  //                   constraints, 320) -
                                  //           MyConstant.setConstraintsMaxHeight(
                                  //               constraints, 160),
                                  //     ),
                                  //     child: Column(
                                  //       mainAxisAlignment:
                                  //           MainAxisAlignment.center,
                                  //       children: [
                                  //         Padding(
                                  //           padding: EdgeInsets.only(
                                  //             left: MyConstant
                                  //                 .setConstraintsMaxWidth(
                                  //                     constraints, 8),
                                  //             right: MyConstant
                                  //                 .setConstraintsMaxWidth(
                                  //                     constraints, 8),
                                  //           ),
                                  //           child: Row(
                                  //             mainAxisAlignment:
                                  //                 MainAxisAlignment.center,
                                  //             children: [
                                  //               Column(
                                  //                 mainAxisAlignment:
                                  //                     MainAxisAlignment.center,
                                  //                 children: [
                                  //                   Container(
                                  //                     constraints: BoxConstraints(
                                  //                       maxWidth: MyConstant
                                  //                           .setConstraintsMaxWidthRowText(
                                  //                               constraints, 275),
                                  //                     ),
                                  //                     child:
                                  //                         ShowTitleNormalCenter(
                                  //                       title: title,
                                  //                       style: MyConstant()
                                  //                           .h3StyleDark(
                                  //                               constraints),
                                  //                     ),
                                  //                   ),
                                  //                   if (message != null) ...[
                                  //                     Container(
                                  //                       constraints:
                                  //                           BoxConstraints(
                                  //                         maxWidth: MyConstant
                                  //                             .setConstraintsMaxWidthRowText(
                                  //                                 constraints,
                                  //                                 275),
                                  //                       ),
                                  //                       child:
                                  //                           ShowTitleNormalCenter(
                                  //                         title: message,
                                  //                         style: MyConstant()
                                  //                             .h3_5StyleDark(
                                  //                                 constraints),
                                  //                       ),
                                  //                     ),
                                  //                   ] else ...[
                                  //                     const SizedBox(),
                                  //                   ],
                                  //                 ],
                                  //               ),
                                  //             ],
                                  //           ),
                                  //         ),
                                  //         if (message != null) ...[
                                  //           Container(
                                  //             margin: EdgeInsets.only(
                                  //               top: MyConstant
                                  //                   .setConstraintsMaxHeight(
                                  //                       constraints, 25),
                                  //             ),
                                  //             child: Row(
                                  //               mainAxisAlignment:
                                  //                   MainAxisAlignment.center,
                                  //               children: [
                                  //                 ElevatedButton(
                                  //                   style: MyConstant()
                                  //                       .myButtonStylePrimary10(
                                  //                           constraints),
                                  //                   onPressed: () {
                                  //                     Navigator.of(context)
                                  //                         .pop(true);
                                  //                   },
                                  //                   child: ShowTitleMaxLines1(
                                  //                     title: 'ยืนยัน',
                                  //                     style: MyConstant()
                                  //                         .h4StyleWhile(
                                  //                             constraints),
                                  //                   ),
                                  //                 ),
                                  //                 Container(
                                  //                   margin: EdgeInsets.only(
                                  //                     left: MyConstant
                                  //                         .setConstraintsMaxWidth(
                                  //                             constraints, 30),
                                  //                   ),
                                  //                   child: ElevatedButton(
                                  //                     style: MyConstant()
                                  //                         .myButtonStyleRed10(
                                  //                             constraints),
                                  //                     onPressed: () {
                                  //                       Navigator.of(context)
                                  //                           .pop(false);
                                  //                     },
                                  //                     child: ShowTitleMaxLines1(
                                  //                       title: 'ไม่',
                                  //                       style: MyConstant()
                                  //                           .h4StyleWhile(
                                  //                               constraints),
                                  //                     ),
                                  //                   ),
                                  //                 ),
                                  //               ],
                                  //             ),
                                  //           ),
                                  //         ] else ...[
                                  //           Container(
                                  //             margin: EdgeInsets.only(
                                  //               top: MyConstant
                                  //                   .setConstraintsMaxHeight(
                                  //                       constraints, 40),
                                  //             ),
                                  //             child: Row(
                                  //               mainAxisAlignment:
                                  //                   MainAxisAlignment.center,
                                  //               children: [
                                  //                 ElevatedButton(
                                  //                   style: MyConstant()
                                  //                       .myButtonStylePrimary10(
                                  //                           constraints),
                                  //                   onPressed: () {
                                  //                     Navigator.of(context)
                                  //                         .pop(true);
                                  //                   },
                                  //                   child: ShowTitleMaxLines1(
                                  //                     title: 'ยืนยัน',
                                  //                     style: MyConstant()
                                  //                         .h4StyleWhile(
                                  //                             constraints),
                                  //                   ),
                                  //                 ),
                                  //                 Container(
                                  //                   margin: EdgeInsets.only(
                                  //                     left: MyConstant
                                  //                         .setConstraintsMaxWidth(
                                  //                             constraints, 30),
                                  //                   ),
                                  //                   child: ElevatedButton(
                                  //                     style: MyConstant()
                                  //                         .myButtonStyleRed10(
                                  //                             constraints),
                                  //                     onPressed: () {
                                  //                       Navigator.of(context)
                                  //                           .pop(false);
                                  //                     },
                                  //                     child: ShowTitleMaxLines1(
                                  //                       title: 'ไม่',
                                  //                       style: MyConstant()
                                  //                           .h4StyleWhile(
                                  //                               constraints),
                                  //                     ),
                                  //                   ),
                                  //                 ),
                                  //               ],
                                  //             ),
                                  //           ),
                                  //         ],
                                  //       ],
                                  //     ),
                                  //   ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ).catchError(
      (error) {
        if (kDebugMode) {
          print(
            'error ===>> $error',
          );
        }
      },
    );

    return status;
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
