import 'dart:convert';
//import 'package:flutter/material.dart';
import 'package:mobile_chaseapp/utils/key_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/respon_accuser.dart';
import '../services/user_service.dart'; // Import the UserAccModel

class AccController {
  final _userService = UserService();
  UserAccModel userAccModel = UserAccModel();

  Future<UserAccModel> fetchAccData() async {
    userAccModel = UserAccModel(); // clean

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString(KeyStorage.token) ?? ''; // ดึง Token

    try {
      var response = await _userService.getAccData(token);
      //print(response);
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        print('object --->');
        print(json);
        userAccModel = UserAccModel.fromJson(json);
        //print('userAccModel=>' + '$userAccModel');
        // debugPrint(userAccModel+'gfgfg');
      } else {
        //print('getacc Error');
        userAccModel = UserAccModel();
      }
    } catch (e) {
      //print('Error: $e');
      userAccModel = UserAccModel();
    }
    return userAccModel;
  }
}
