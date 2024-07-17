import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mobile_chaseapp/utils/key_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/default_model.dart';
import '../model/respon_user.dart';
import '../services/user_service.dart';

class RegisterController {
  final _userService = UserService();

  UserModel userModel = UserModel();
  TextEditingController gentnameController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController idCardController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController pinController = TextEditingController();
  // TextEditingController platformController = TextEditingController();

  TextEditingController deviceController = TextEditingController();
  // TextEditingController yomrub1Controller = TextEditingController();
  // TextEditingController yomrub2Controller = TextEditingController();
  // TextEditingController yomrub3Controller = TextEditingController();

  Future<String> fetchRegisterUser({
    required String gentname,
    required String name,
    required String surname,
    required String idCard,
    required String email,
    required String phone,
    required String yomrub1,
    required String yomrub2,
    required String yomrub3,
    required String yomrub4,
    required String yomrub5,
    String? device,
    String? platform,
    String? pin,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    try {
      print('firebaseToken $device');
      var response = await _userService.registerUser(
        gentName: gentname,
        name: name,
        surName: surname,
        idCard: idCard,
        email: email,
        phone: phone,
        pin: pin,
        device: device,
        platform: platform,
        yomrub1: yomrub1,
        yomrub2: yomrub2,
        yomrub3: yomrub3,
        yomrub4: yomrub4,
        yomrub5: yomrub5,
      );

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        // print('TOKENBB: ${json}');
        userModel = UserModel.fromJson(json);

        print('object-------');
        print('TOKENBB: ${userModel.token.toString()}');
        await prefs.setString(KeyStorage.token, userModel.token!);
        await prefs.setString(KeyStorage.uid, userModel.user!.id!);
        await prefs.setString(KeyStorage.name, userModel.user!.name!);
        await prefs.setString(KeyStorage.surname, userModel.user!.surname!);
        await prefs.setString(KeyStorage.email, userModel.user!.email!);
        await prefs.setString(KeyStorage.idCard, userModel.user!.idCard!);
        await prefs.setString(
            KeyStorage.typeCustomer, userModel.user!.typeCustomer!);
        await prefs.setString(
            KeyStorage.statusStar, userModel.user!.statusStar!);
        // if (userModel.user!.ciType != null) {
        //   await prefs.setString(KeyStorage.ciType, userModel.user!.ciType!);
        // }

        return '';
      } else {
        print('login Error');
        userModel = UserModel();
        return '';
      }
    } catch (e) {
      print('Error: $e'); // แสดงข้อความผิดพลาดในกรณีเกิด Exception
      userModel = UserModel();
      return '';
    }
  }

  Future<DefaultModel> fetchGetIdCard(String idCard) async {
    try {
      var response = await _userService.getIdCardUser(idCard);

      var json = jsonDecode(response.body);

      return DefaultModel.fromJson(json);
    } catch (e) {
      return DefaultModel(
        status: false,
        message: 'Server Filed',
      );
    }
  }
}
