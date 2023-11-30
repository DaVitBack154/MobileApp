import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_chaseapp/screen/login_page/pin_page.dart';
import 'package:mobile_chaseapp/screen/login_page/verify_forgetphone.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../controller/getprofile_controller.dart';
import '../../utils/key_storage.dart';
import '../piccode/pincode.dart';

class Phone_page extends StatefulWidget {
  const Phone_page({
    Key? key,
  }) : super(key: key);

  @override
  State<Phone_page> createState() => _Phone_pageState();
}

class _Phone_pageState extends State<Phone_page> {
  String phoneNumber = '';
  int countdown = 30; // เวลานับถอยหลังเริ่มต้นที่ 30 วินาที
  late Timer countdownTimer;
  // String forget = 'forgetpin';

  TextEditingController _pinController = TextEditingController();

  Future<void> fetchProfileData() async {
    try {
      ProfileController profileController = ProfileController();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token'); // ดึง Token
      if (token != null) {
        // ตรวจสอบว่า Token ไม่เป็น null ก่อนใช้งาน
        var profileData = await profileController.fetchProfileData(token);
        // var profilePin = await profileController.fetchProfileData(pin!);
        setState(() {
          phoneNumber = profileData.user!.phone ?? '';
        });
      }
    } catch (error) {
      // Handle error if fetching profile data fails
    }
  }

  //ฟังชั่นนับถอยหลังตอนลอคอิน
  void startCountdown() {
    setState(() {
      countdown = 30; // เริ่มนับถอยหลัง 30 วินาที
    });

    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdown > 0) {
        setState(() {
          countdown--; // ลดเวลานับถอยหลังลงทีละ 1 วินาที
        });
      } else {
        // เมื่อนับถอยหลังครบ 0 ก็ยกเลิกการนับเวลา
        countdownTimer.cancel();
      }
    });
  }

  //ฟังชั่นยกเลิกการทำงาน
  @override
  void dispose() {
    countdownTimer.cancel(); // ยกเลิกการทำงานของ countdownTimer ใน dispose()
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    fetchProfileData(); // Fetch profile data when widget is initialized
    startCountdown(); // เรียกใช้งานฟังก์ชันเมื่อหน้าถูกโหลด
  }

  @override
  Widget build(BuildContext context) {
    final defaulPinTheme = PinTheme(
      width: 50.w,
      height: 50.h,
      textStyle: TextStyle(fontSize: 22.sp, color: Colors.black),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.transparent),
      ),
    );
    double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        // FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 130.h + kToolbarHeight,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/image/bglogin.png'),
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
                      ),
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'ยืนยัน OTP',
                          style: TextStyle(
                            fontSize: 32.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Text(
                          'ยืนยัน OTP เพื่อเข้าสู่ระบบ',
                          style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 25.h,
                      horizontal: 15.w,
                    ),
                    child: Column(
                      children: [
                        Text(
                          'OTP จะถูกส่งไปยังหมายเลข',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey.shade500,
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Container(
                          width: width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.shade200,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  phoneNumber.replaceAllMapped(
                                      RegExp(r'(\d{3})(\d{3})(\d+)'),
                                      (Match m) => "${m[1]}-${m[2]}-${m[3]}"),
                                  style: TextStyle(
                                    fontSize: 23.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          Text(
                            'ขอ OTP ใหม่อีกครั้ง',
                            style: TextStyle(
                              fontSize: 17.sp,
                              color: Colors.grey.shade500,
                            ),
                          ),
                          SizedBox(
                            width: 8.w,
                          ),
                          countdown > 0
                              ? Text(
                                  '${countdown.toString()} วินาที',
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    color: Colors.red,
                                  ),
                                )
                              : GestureDetector(
                                  onTap: () {
                                    if (countdown == 0) {
                                      startCountdown(); // เริ่มนับถอยหลังเมื่อกด "ขอ OTP ใหม่อีกครั้ง"
                                      // ตรวจสอบว่ากำลังนับถอยหลังหรือไม่ก่อนที่จะรับ OTP ใหม่
                                      // แล้วค่อยเรียกฟังก์ชันส่ง OTP ใหม่
                                    }
                                  },
                                  child: Text(
                                    'กดที่นี่เพื่อขอ OTP ใหม่',
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      color: const Color(
                                        // ignore: use_full_hex_values_for_flutter_colors
                                        0xfff395d5d,
                                      ),
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                        ],
                      ),
                      InkWell(
                        child: Text(
                          'เปลี่ยนเบอร์มือถือ',
                          style: TextStyle(
                            fontSize: 17.sp,
                            color: Colors.grey.shade500,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Forget_phone(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Pinput(
                    length: 6,
                    controller: _pinController,
                    defaultPinTheme: defaulPinTheme.copyWith(
                      decoration: defaulPinTheme.decoration!.copyWith(
                        color: const Color(
                          0xFFF395D5D,
                        ), // เปลี่ยนสีพื้นหลังของช่องกรอก PIN
                      ),
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 25.sp, // เปลี่ยนสีตัวอักษรภายในช่องกรอก PIN
                      ),
                    ),
                    focusedPinTheme: defaulPinTheme.copyWith(
                      decoration: defaulPinTheme.decoration!.copyWith(
                        border: Border.all(
                          color: Color(0xFFF395D5D),
                        ),
                        color: const Color(
                          0xFFF395D5D,
                        ),
                      ),
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 25.sp, // เปลี่ยนสีตัวอักษรภายในช่องกรอก PIN
                      ),
                    ),
                    onCompleted: (pin) async {
                      if (pin == "111111") {
                        // แทนค่าเป้าหมายของ OTP ด้วยค่าที่ถูกต้อง

                        //ดึงข้อมูล Pin จาก store มาเชค
                        final prefs = await SharedPreferences.getInstance();
                        String pinold = prefs.getString(KeyStorage.pin) ?? '';

                        if (pinold.isNotEmpty) {
                          // ignore: use_build_context_synchronously
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PinCode(
                                args: PinCodeArgs(isGotoNotif: false),
                              ),
                            ),
                          );
                        } else {
                          // ignore: use_build_context_synchronously
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Pin_page(onBack: false),
                            ),
                          );
                        }
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Container(
                                height: 180.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                                      "รหัส OTP ไม่ถูกต้องกรุณากรอกใหม่อีกครั้ง",
                                      style: TextStyle(
                                        fontSize: 19.sp,
                                        color: Colors.grey.shade500,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    Center(
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          _pinController.clear();
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(5),
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
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
