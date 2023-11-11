import 'dart:convert';
import 'dart:developer';
import 'package:mobile_chaseapp/model/respon_promotion.dart';
import 'package:mobile_chaseapp/utils/key_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/user_service.dart';

class PromotionController {
  final _userService = UserService();
  UserPromotion userpromotion = UserPromotion();

  Future<UserPromotion> fetchPromotion() async {
    userpromotion = UserPromotion();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString(KeyStorage.token) ?? ''; // ดึง Token

    try {
      var response = await _userService.getPromotion(token);
      if (response.statusCode == 200) {
        
        userpromotion = UserPromotion.fromJson(json.decode(response.body));
        // print(UserNotify.fromJson(json.decode(response.body)).toJson());
      } else {
        // print('getpayment Error');
        userpromotion = UserPromotion();
      }
    } catch (e) {
      log('catch ->$e');
      //print('Error: $e');
      userpromotion = UserPromotion();
    }
    return userpromotion;
  }
}
