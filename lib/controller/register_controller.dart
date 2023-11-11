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
  TextEditingController deviceController = TextEditingController();

  Future<String> fetchRegisterUser({
    required String gentname,
    required String name,
    required String surname,
    required String idCard,
    required String email,
    required String phone,
    String? device,
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
      );

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);

        userModel = UserModel.fromJson(json);

        await prefs.setString(KeyStorage.token, userModel.token!);
        await prefs.setString(KeyStorage.uid, userModel.user!.id!);
        await prefs.setString(KeyStorage.name, userModel.user!.name!);
        await prefs.setString(KeyStorage.surname, userModel.user!.surname!);
        await prefs.setString(KeyStorage.email, userModel.user!.email!);
        await prefs.setString(KeyStorage.idCard, userModel.user!.idCard!);
        await prefs.setString(
            KeyStorage.typeCustomer, userModel.user!.typeCustomer!);
        // await prefs.setString(KeyStorage.device, userModel.user!.device!);

        print('TOKEN: ${userModel.token}');

        return '';
      } else {
        print('login Error');
        userModel = UserModel();
        return 'เกิดข้อผิดพลาดในระบบ';
      }
    } catch (e) {
      print('Error: $e'); // แสดงข้อความผิดพลาดในกรณีเกิด Exception
      userModel = UserModel();
      return 'เกิดข้อผิดพลาดในระบบ';
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
