// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_chaseapp/controller/update_controller.dart';
import 'package:mobile_chaseapp/screen/login_page/component/format_phone.dart';
import 'package:mobile_chaseapp/screen/login_page/login_page.dart';
import 'package:mobile_chaseapp/screen/login_page/phone_page.dart';

import '../../component/debouncer.dart';

class Forget_phone extends StatefulWidget {
  const Forget_phone({super.key});

  @override
  State<Forget_phone> createState() => _Forget_phoneState();
}

class _Forget_phoneState extends State<Forget_phone> {
  UpdateController authController = UpdateController();
  final _formKey = GlobalKey<FormState>();

  final _debouncer = Debouncer(
    delay: const Duration(milliseconds: Duration.millisecondsPerSecond),
  );

  String? validator;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        // FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        body: SingleChildScrollView(
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
                      'เปลี่ยนหมายเลขโทรศัพท์',
                      style: TextStyle(
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Text(
                      'เปลี่ยนหมายเลขโทรศัพท์เพื่อเข้าสู่ระบบ',
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Form(
                key: _formKey,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: authController.phoneController,
                        style: TextStyle(fontSize: 20.sp),
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.phone,
                            size: 25,
                            color: Color.fromARGB(255, 20, 99, 95),
                          ),
                          labelText: 'กรุณากรอกเบอร์โทรศัพท์เดิม',
                          labelStyle: TextStyle(
                            color: Colors.grey.shade700,
                          ),
                          hintText: 'กรุณากรอกเบอร์โทรศัพท์เดิม',
                          hintStyle: const TextStyle(
                            color: Colors.grey,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey
                                  .shade300, // เปลี่ยนสีเป็นสีที่คุณต้องการ
                              width:
                                  1.0, // เปลี่ยนความหนาของเส้นขอบตามที่คุณต้องการ
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey
                                  .shade300, // เปลี่ยนสีเป็นสีที่คุณต้องการ
                              width:
                                  1.0, // เปลี่ยนความหนาของเส้นขอบตามที่คุณต้องการ
                            ),
                          ),
                          errorText: validator,
                          errorStyle: TextStyle(
                            fontSize: 18.sp,
                            color: Colors.red,
                          ),
                        ),
                        cursorColor: Colors.grey.shade400,
                        // inputFormatters: [PhoneFormatter()],
                        keyboardType: TextInputType.phone,
                        onChanged: (value) {},
                        validator: (value) {
                          print(value);
                          if (value == null || value.isEmpty) {
                            return 'กรุณาใส่เบอร์โทรศัพท์เดิม';
                          } else if (value.length < 10) {
                            return 'กรุณาใส่เบอร์โทรศัพท์เดิมให้ครบ';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20.h),
                      TextFormField(
                        controller: authController.phoneNewController,
                        style: TextStyle(fontSize: 20.sp),
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.phone,
                            size: 25,
                            color: Color.fromARGB(255, 20, 99, 95),
                          ),
                          labelText: 'กรุณากรอกเบอร์โทรศัพท์ใหม่',
                          labelStyle: TextStyle(
                            color: Colors.grey.shade700,
                          ),
                          hintText: 'กรุณากรอกเบอร์โทรศัพท์ใหม่',
                          hintStyle: const TextStyle(
                            color: Colors.grey,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey
                                  .shade300, // เปลี่ยนสีเป็นสีที่คุณต้องการ
                              width:
                                  1.0, // เปลี่ยนความหนาของเส้นขอบตามที่คุณต้องการ
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey
                                  .shade300, // เปลี่ยนสีเป็นสีที่คุณต้องการ
                              width:
                                  1.0, // เปลี่ยนความหนาของเส้นขอบตามที่คุณต้องการ
                            ),
                          ),
                          errorStyle: TextStyle(
                            fontSize: 18.sp,
                            color: Colors.red,
                          ),
                        ),
                        cursorColor: Colors.grey.shade400,
                        keyboardType: TextInputType.number,
                        // inputFormatters: [PhoneFormatter()],
                        validator: (value) {
                          print(value);
                          if (value == null || value.isEmpty) {
                            return 'กรุณาใส่เบอร์โทรศัพท์ใหม่';
                          } else if (value.length < 10) {
                            return 'กรุณาใส่เบอร์โทรศัพท์ใหม่ให้ครบ';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 30.h),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            validator = null;

                            if (authController.phoneController.text.length <
                                10) {
                              validator = 'ใส่หมายเลขให้ครบ 10 หลัก';
                            } else {
                              await authController
                                  .fetchGetPhone(
                                      authController.phoneController.text)
                                  .then((value) async {
                                validator =
                                    value ? null : 'ไม่พบเบอร์โทรศัพท์ในระบบ';
                                if (value == true) {
                                  await authController.fetchUpdateProfile(
                                    phone:
                                        authController.phoneNewController.text,
                                  );
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const Phone_page(),
                                    ),
                                  );
                                  print('ถูกต้อง ทำการอัพเดทข้อมูล');
                                  // ID Card ถูกต้อง ทำการอัพเดทข้อมูล
                                  // ...
                                } else {
                                  print(
                                      'ไม่ถูกต้อง แสดงข้อความหรือทำอะไรตามที่คุณต้องการ');
                                  // ID Card ไม่ถูกต้อง แสดงข้อความหรือทำอะไรตามที่คุณต้องการ
                                  // ...
                                }
                                setState(() {});
                              });
                            }
                            setState(() {});
                          }
                        },
                        style: ButtonStyle(
                          fixedSize: MaterialStateProperty.all<Size>(
                            Size(width, 45),
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Color(0xFF103533), // กำหนดสีพื้นหลังของปุ่ม
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  10), // กำหนดรัศมีของเส้นขอบปุ่ม
                            ),
                          ),
                        ),
                        child: Text(
                          'บันทึกข้อมูล',
                          style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
