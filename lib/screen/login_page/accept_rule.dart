// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_chaseapp/screen/login_page/register_page.dart';
import '../../config/app_info.dart';

class Accept_rule extends StatefulWidget {
  const Accept_rule({super.key});

  @override
  State<Accept_rule> createState() => _Accept_ruleState();
}

class _Accept_ruleState extends State<Accept_rule> {
  bool? isCheckbox = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
                height: 100.h + kToolbarHeight,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/image/bgpin.jpg'),
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.black.withOpacity(.1),
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios_new_outlined,
                          size: 25,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    Container(
                      child: Text(
                        'ข้อกำหนดและเงื่อนไข',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                // SizedBox(
                //   height: 15,
                // ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: kToolbarHeight + 80).h,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            decoration: BoxDecoration(
              color: Color(0xfff395d5d),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 30.h,
                ),
                Container(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      AppInfo.termsAndConditions,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontSize: 19.sp,
                        letterSpacing: 1.3.w,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    children: [
                      Checkbox(
                        value: isCheckbox,
                        onChanged: (newBool) {
                          setState(() {
                            isCheckbox = newBool;
                          });
                        },
                        fillColor: MaterialStateColor.resolveWith(
                          (states) => isCheckbox! ? Colors.blue : Colors.white,
                        ),
                        activeColor: Colors
                            .blue, // เปลี่ยนเส้น Checkbox เป็นสีฟ้าเมื่อถูกเลือก
                        checkColor: Colors.white,
                      ),
                      Text(
                        'ยินยอมข้อมูลส่วนบุคคล',
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (isCheckbox == true) {
                      // เช็กว่า Checkbox ถูกเลือกหรือไม่
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterPage(),
                        ),
                      );
                    } else {
                      // แสดง SnackBar หรือข้อความเตือนให้ผู้ใช้เลือกยินยอมก่อน
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Center(
                            child: Text(
                              'กรุณายินยอมข้อมูลส่วนบุคคลก่อนกดถัดไป',
                              style: TextStyle(
                                  color: Colors.white), // กำหนดสีข้อความ
                            ),
                          ),
                          backgroundColor:
                              Colors.red, // กำหนดสีพื้นหลังของ SnackBar
                        ),
                      );
                    }
                  },
                  style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all<Size>(
                      Size(width, 50),
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromARGB(
                          255, 236, 237, 237), // กำหนดสีพื้นหลังของปุ่ม
                    ),
                  ),
                  child: Text(
                    'ถัดไป',
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF103533),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
