// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_chaseapp/component/bottombar.dart';
import 'package:mobile_chaseapp/firebase_cloud_messaging_provider.dart';
import 'package:mobile_chaseapp/screen/login_page/accept_rule.dart';
import 'package:mobile_chaseapp/screen/login_page/phone_page.dart';
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
  //Future<String?> firebaseToken = FirebaseCloudMessagingProvider.getToken;

  String? errorTextIdCard;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        // FocusManager.instance.primaryFocus?.unfocus();
      },
      child: WillPopScope(
        child: Scaffold(
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 150.h + kToolbarHeight,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 30,
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.arrow_back,
                                      size: 25,
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
                                const Text(
                                  'ยินดีต้อนรับ',
                                  style: TextStyle(
                                    fontSize: 32,
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
                          const Text(
                            'ลงชื่อเข้าใช้บัญชีของคุณ',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
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
                                fontSize: 20.sp,
                                //color: hintColor,
                                fontWeight: FontWeight.w400,
                              ),
                              controller: authController.id_cardController,
                              width: width,
                              autoFocus: false,
                              maxLength: 13,
                              prefixIcon: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20.w,
                                ),
                                child: const Icon(
                                  Icons.credit_card_outlined,
                                  size: 25,
                                  color: Color(0xFF395D5D),
                                ),
                              ),
                              contentPadding: const EdgeInsets.all(20),
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
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          content: SizedBox(
                                            height: 180.h,
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
                                                  "ไม่พบเลขบัตรประชาชนในระบบ กรุณาสมัครสมาชิกเพื่อเข้าสู่ระบบ",
                                                  style: TextStyle(
                                                    fontSize: 19.sp,
                                                    color: Colors.grey.shade500,
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
                                                      decoration: BoxDecoration(
                                                        color: Colors.red,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                      child: Icon(
                                                        Icons.close,
                                                        size: 30.h,
                                                        color: Colors.white,
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
                                  }

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const Phone_page(),
                                    ),
                                  );
                                  // return;
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
                                padding: const EdgeInsets.all(15),
                                child: Text(
                                  'เข้าสู่ระบบ',
                                  style: TextStyle(
                                    fontSize: 23.sp,
                                    fontWeight: FontWeight.w500,
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
                                padding: const EdgeInsets.all(15),
                                child: Text(
                                  'ลงทะเบียน',
                                  style: TextStyle(
                                    fontSize: 23.sp,
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
    );
  }
}
