import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_chaseapp/model/respon_user.dart';
import 'package:mobile_chaseapp/utils/key_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/user_service.dart';

class LoginController {
  final _userService = UserService();

  UserModel userModel = UserModel();

  TextEditingController id_cardController = TextEditingController();
  TextEditingController deviceController = TextEditingController();

  Future<String> fetchLogin(
    String idCard,
    String? device,
  ) async {
    final prefs = await SharedPreferences.getInstance();

    try {
      var response = await _userService.loginUser(idCard, device);

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);

        userModel = UserModel.fromJson(json);
        // debugPrint('TOKEN: ${userModel.token}');
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
        await prefs.setString(KeyStorage.ciType, userModel.user!.ciType!);
        print('TOKEN: ${userModel.token}');
        return '';
      } else {
        print('Login Error');

        return 'ไม่พบเลขบัตรประชาชนในระบบ กรุณาสมัครสมาชิก';
      }
    } catch (e) {
      print('Error: $e');
      return 'ไม่พบ user ในระบบ';
    }
  }
}
