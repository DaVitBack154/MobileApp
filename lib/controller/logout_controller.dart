import 'dart:convert';
import 'package:http/http.dart';
import 'package:mobile_chaseapp/model/respon_user.dart';
import 'package:mobile_chaseapp/utils/key_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/user_service.dart';

class LogoutController {
  final _userService = UserService();

  UserModel userModel = UserModel();

  Future<String> logout({
    String? token,
    String? device,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString(KeyStorage.token) ?? ''; // ดึง Token

    try {
      Response response = await _userService.logout(
        token,
        device,
      );

      if (response.statusCode == 200) {
        var responseBody = json.decode(response.body);
        return responseBody;
      } else {
        return ''; // ส่งค่า null เมื่อไม่ได้รับสถานะ 200
      }
    } catch (e) {
      return ''; // ส่งค่า null เมื่อเกิดข้อผิดพลาด
    }
  }
}
