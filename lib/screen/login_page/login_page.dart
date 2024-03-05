import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_chaseapp/component/bottombar.dart';
import 'package:mobile_chaseapp/controller/otp_controller.dart';
import 'package:mobile_chaseapp/firebase_cloud_messaging_provider.dart';
import 'package:mobile_chaseapp/screen/login_page/accept_rule.dart';
import 'package:mobile_chaseapp/screen/login_page/phone_page.dart';
import 'package:mobile_chaseapp/screen/login_page/pin_page.dart';
import 'package:mobile_chaseapp/screen/piccode/pincode.dart';
import 'package:mobile_chaseapp/utils/key_storage.dart';
import 'package:mobile_chaseapp/utils/my_constant.dart';
import 'package:mobile_chaseapp/utils/responsive_heigth__context.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../component/textfield.dart';
import '../../controller/login_controller.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  LoginController authController = LoginController();
  final _formKey = GlobalKey<FormState>();
  String? errorTextIdCard;

  final CreateOTPController createotpController = CreateOTPController();

  // Future setOTP() async {
  //   String sub = '';
  //   sub = '66' + sub.substring(1);
  //   await createotpController.createPhoneOTP(phone: sub);
  // }
  Future<void> openlaunchUrl(Uri url) async {
    if (mounted) {
      if (await canLaunchUrl(url)
          .timeout(
        const Duration(seconds: 20),
      )
          .catchError(
        (error) {
          if (kDebugMode) {
            print(
              'error ===>> $error',
            );
          }
          return false;
        },
      )) {
        if (!await launchUrl(url)
            .timeout(
          const Duration(seconds: 20),
        )
            .catchError(
          (error) {
            if (kDebugMode) {
              print(
                'error ===>> $error',
              );
            }
            return false;
          },
        )) {
          if (kDebugMode) {
            print(
              'Could not launch $url',
            );
          }
        }
      } else {
        if (kDebugMode) {
          print(
            'Could not launch $url',
          );
        }
      }
    }
  }

  Future<void> openlaunchUrlAppOther(String url) async {
    if (mounted) {
      // ignore: deprecated_member_use
      if (await canLaunch(url)
          .timeout(
        const Duration(seconds: 20),
      )
          .catchError(
        (error) {
          if (kDebugMode) {
            print(
              'error ===>> $error',
            );
          }
          return false;
        },
      )) {
        // ignore: deprecated_member_use
        if (!await launch(url)
            .timeout(
          const Duration(seconds: 20),
        )
            .catchError(
          (error) {
            if (kDebugMode) {
              print(
                'error ===>> $error',
              );
            }
            return false;
          },
        )) {
          if (kDebugMode) {
            print(
              'Could not launch $url',
            );
          }
        }
      } else {
        if (kDebugMode) {
          print(
            'Could not launch $url',
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final query = MediaQuery.of(context);
    return MediaQuery(
      data: query.copyWith(
        // ignore: deprecated_member_use
        textScaler: TextScaler.linear(query.textScaleFactor.clamp(1.0, 1.0)),
      ),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        // ignore: deprecated_member_use
        child: WillPopScope(
          child: Scaffold(
            body: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 140.h + kToolbarHeight,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/image/bglogin.png'),
                            fit: BoxFit.cover,
                            alignment: Alignment.center,
                          ),
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(20),
                          ),
                        ),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 70,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 30,
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.arrow_back,
                                        size: MyConstant.setMediaQueryWidth(
                                            context, 25),
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const Bottombar(),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  Text(
                                    'ยินดีต้อนรับ',
                                    style: TextStyle(
                                      fontSize: MyConstant.setMediaQueryWidth(
                                          context, 32),
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 30,
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              'ลงชื่อเข้าใช้บัญชีของคุณ',
                              style: TextStyle(
                                fontSize:
                                    MyConstant.setMediaQueryWidth(context, 22),
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 15.h,
                                  child: Image.asset(
                                    'assets/image/icon_a.png',
                                    fit: BoxFit.cover,
                                    height: 15.h,
                                  ),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Text(
                                  'by Chase Asia PCL',
                                  style: TextStyle(
                                    fontSize: MyConstant.setMediaQueryWidth(
                                        context, 20),
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      // formแล้ว
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 20.h,
                                horizontal: 20.w,
                              ),
                              child: textField(
                                'หมายเลขบัตรประชาชน',
                                hintStyle: TextStyle(
                                  fontSize: MyConstant.setMediaQueryWidth(
                                      context, 25),
                                  //color: hintColor,
                                  fontWeight: FontWeight.w400,
                                ),
                                controller: authController.id_cardController,
                                width: width,
                                autoFocus: false,
                                maxLength: 13,
                                fontSize: 25,
                                prefixIcon: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 20.w,
                                  ),
                                  child: Icon(
                                    Icons.credit_card_outlined,
                                    size: MyConstant.setMediaQueryWidth(
                                        context, 25),
                                    color: Color(0xFF395D5D),
                                  ),
                                ),
                                contentPadding: const EdgeInsets.all(10).h,
                                errorText: errorTextIdCard,
                                onChanged: (value) {
                                  setState(() {
                                    if (value.isEmpty) {
                                      errorTextIdCard = 'กรุณากรอกบัตรประชาชน';
                                    } else if (value.length < 13) {
                                      errorTextIdCard =
                                          'กรุณากรอกบัตรประชาชนให้ครบ';
                                    } else {
                                      errorTextIdCard = null;
                                    }
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),

                      //ปุ่ม login
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 20.w,
                                vertical: 20.h,
                              ),
                              child: ElevatedButton(
                                onPressed: () async {
                                  final firebaseToken =
                                      await FirebaseCloudMessagingProvider
                                          .getToken;
                                  if (_formKey.currentState!.validate()) {
                                    authController.deviceController.text =
                                        firebaseToken!;
                                    String result =
                                        await authController.fetchLogin(
                                      authController.id_cardController.text,
                                      authController.deviceController.text,
                                    );

                                    if (result.isNotEmpty) {
                                      // ignore: use_build_context_synchronously
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            content: SizedBox(
                                              height:
                                                  MyConstant.setMediaQueryWidth(
                                                      context, 300),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                    'assets/image/danger.png',
                                                    height: 50.h,
                                                    fit: BoxFit.cover,
                                                  ),
                                                  SizedBox(
                                                    height: 20.h,
                                                  ),
                                                  Text(
                                                    "ไม่พบเลขบัตรประชาชนในระบบ กรุณาลงทะเบียนเพื่อเข้าสู่ระบบ",
                                                    style: TextStyle(
                                                      fontSize: 21.sp,
                                                      color:
                                                          Colors.grey.shade600,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 20.h,
                                                  ),
                                                  Center(
                                                    child: TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                        authController
                                                            .id_cardController
                                                            .clear();
                                                      },
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.red,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(24),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Icon(
                                                            Icons.close,
                                                            size: 20.h,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            // actions: [

                                            // ],
                                          );
                                        },
                                      );

                                      return;
                                    } else {
                                      // ignore: use_build_context_synchronously
                                      // setOTP();
                                      if (authController
                                              .id_cardController.text ==
                                          '0000000000001') {
                                        final prefs = await SharedPreferences
                                            .getInstance();
                                        await prefs.setString(
                                            KeyStorage.pin, '111111');
                                        // ignore: use_build_context_synchronously
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const PinCode(),
                                          ),
                                        );
                                      } else {
                                        // ignore: use_build_context_synchronously
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const Phone_page(
                                                    newphone: null),
                                          ),
                                        );
                                      }
                                    }
                                  }
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                    const Color(
                                        0xFF103533), // กำหนดสีพื้นหลังของปุ่ม
                                  ),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        10,
                                      ), // กำหนดรัศมีของเส้นขอบปุ่ม
                                    ),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5).h,
                                  child: Text(
                                    'เข้าสู่ระบบ',
                                    style: TextStyle(
                                      fontSize: MyConstant.setMediaQueryWidth(
                                          context, 25),
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(
                        height: 10.h,
                      ),
                      //เส้นกั้น
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 20,
                          right: 20,
                        ).w,
                        child: Container(
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Color.fromARGB(255, 217, 217, 217),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      // register
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 20.w,
                                vertical: 20.h,
                              ),
                              child: ElevatedButton(
                                onPressed: () async {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const Accept_rule(),
                                    ),
                                  );
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                    const Color(
                                        0xFFe2e7e7), // กำหนดสีพื้นหลังของปุ่ม
                                  ),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          10), // กำหนดรัศมีของเส้นขอบปุ่ม
                                    ),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5).h,
                                  child: Text(
                                    'ลงทะเบียน',
                                    style: TextStyle(
                                      fontSize: MyConstant.setMediaQueryWidth(
                                          context, 25),
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFF103533),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25.w),
                        child: Row(
                          children: [
                            Text(
                              Localizations.localeOf(context).languageCode ==
                                      'th'
                                  ? 'เงื่อนไขและความปลอดภัย'
                                  : 'Conditions and safety',
                              style: TextStyle(
                                fontSize:
                                    MyConstant.setMediaQueryWidth(context, 19),
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          if (mounted) {
                            openlaunchUrl(
                              Uri.parse(
                                  'https://www.chase.co.th/th/corporate-governance/privacy-notice'),
                            ).catchError(
                              (error) {
                                if (kDebugMode) {
                                  print(
                                    'error ===>> $error',
                                  );
                                }
                                return false;
                              },
                            );
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.only(left: 25.w),
                          child: Row(
                            children: [
                              Flexible(
                                child: Text(
                                  'https://www.chase.co.th/th/corporate-governance/privacy-notice',
                                  style: TextStyle(
                                    fontSize: MyConstant.setMediaQueryWidth(
                                        context, 19),
                                    color: Colors.blue.shade800,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25.w),
                        child: Row(
                          children: [
                            Text(
                              Localizations.localeOf(context).languageCode ==
                                      'th'
                                  ? 'พัฒนาโดย : บริษัท เชฎฐ์ เอเชีย จำกัด (มหาชน)'
                                  : 'Developed by : Chase Asia PCL',
                              style: TextStyle(
                                fontSize:
                                    MyConstant.setMediaQueryWidth(context, 19),
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          onWillPop: () async {
            return false;
          },
        ),
      ),
    );
  }
}
