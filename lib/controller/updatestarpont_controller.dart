import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mobile_chaseapp/model/respon_user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/user_service.dart';
import '../utils/key_storage.dart';

class UpdateStarController {
  final _userService = UserService();

  UserModel userModel = UserModel();

  TextEditingController statusStarController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  TextEditingController starPointController = TextEditingController();

  Future<String> fetchUpdateStar(
    String statusStar,
    String comment,
    String starPoint,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    String? uid = prefs.getString(KeyStorage.uid);

    print('UID: $uid');

    try {
      var response = await _userService.updateUserStar(
        id: uid!,
        statusStar: statusStar,
        comment: comment,
        starPoint: starPoint,
      );
      if (response?.statusCode == 200) {
        var json = jsonDecode(response!.body);
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
}
