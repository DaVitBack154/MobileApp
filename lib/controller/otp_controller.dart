import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mobile_chaseapp/model/respon_otp.dart';
import 'package:mobile_chaseapp/services/user_service.dart';

class CreateOTPController {
  final _userService = UserService();

  OtpModel otpModel = OtpModel();

  TextEditingController phoneOtpController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  Future<String> createPhoneOTP({
    required String phone,
    String? otp,
  }) async {
    //final prefs = await SharedPreferences.getInstance();

    try {
      var response = await _userService.createPhoneOTP(
        phone: phone,
        otp: otp,
      );
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        // print(json);
        otpModel = OtpModel.fromJson(json);
        //save this token in shared preferences and make user logged in and navigate
        // print('Test: ${otpModel}');

        return '';
      } else {
        print('userreq Error');
        otpModel = OtpModel();
        return 'กรุณากรอกข้อมูลที่อยู่ให้ถูกต้อง';
      }
    } catch (e) {
      print('Error: $e'); // แสดงข้อความผิดพลาดในกรณีเกิด Exception
      otpModel = OtpModel();
      return 'เกิดข้อผิดพลาดในระบบ';
    }
  }

  Future<String> getOTP({
    required String phone,
    String? otp,
  }) async {
    //final prefs = await SharedPreferences.getInstance();

    try {
      var response = await _userService.postOTP(
        phone: phone,
        otp: otp!,
      );
      print(response.statusCode);
      print(jsonDecode(response.body));
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);

        otpModel = OtpModel.fromJson(json);

        //save this token in shared preferences and make user logged in and navigate
        print('Test: ${otpModel}');
        if (otpModel.status == true) {
          return 'true';
        } else {
          return 'false';
        }
      } else {
        print('userreq Error');
        otpModel = OtpModel();
        return 'กรุณากรอกข้อมูลที่อยู่ให้ถูกต้อง';
      }
    } catch (e) {
      print('Error: $e'); // แสดงข้อความผิดพลาดในกรณีเกิด Exception
      otpModel = OtpModel();
      return 'เกิดข้อผิดพลาดในระบบ';
    }
  }
}
