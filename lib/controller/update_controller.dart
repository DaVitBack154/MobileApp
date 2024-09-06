import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mobile_chaseapp/model/respon_user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/user_service.dart';
import '../utils/key_storage.dart';

class UpdateController {
  final _userService = UserService();

  UserModel userModel = UserModel();

  TextEditingController idCardController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController phoneNewController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController pinController = TextEditingController();
  TextEditingController sentAddressuser = TextEditingController();
  TextEditingController district = TextEditingController();
  TextEditingController subdistrict = TextEditingController();
  TextEditingController provin = TextEditingController();
  TextEditingController postcode = TextEditingController();

  Future<String> fetchUpdateProfile({
    String? idCard,
    String? phone,
    String? email,
    String? pin,
    String? sentAddressuser,
    String? district,
    String? subdistrict,
    String? provin,
    String? postcode,
    String? statusStar,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    String? uid = prefs.getString(KeyStorage.uid);

    print('UID: $uid');

    try {
      var response = await _userService.updateProfile(
        id: uid!,
        idCard: idCard,
        email: email,
        phone: phone,
        pin: pin,
        sentAddressuser: sentAddressuser,
        district: district,
        subdistrict: subdistrict,
        provin: provin,
        postcode: postcode,
        statusStar: statusStar,
      );
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        userModel = UserModel.fromJson(json);
        return '';
      } else {
        print('Update Error');
        return 'ไม่พบเลขบัตรประชาชนในระบบ กรุณาสมัครสมาชิก';
      }
    } catch (e) {
      print('Error: $e');
      return '';
    }
  }

  Future<bool> fetchGetPhone(String phone) async {
    try {
      var response = await _userService.getPhoneUser(phone);

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
