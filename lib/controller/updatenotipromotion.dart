import 'dart:convert';
import 'package:http/http.dart';
import 'package:mobile_chaseapp/model/respon_notipromotion.dart';
import 'package:mobile_chaseapp/utils/key_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/user_service.dart';

class UpdateNotiPromotion {
  final _userService = UserService();
  NotiPromotion notipromotion = NotiPromotion();

  Future<NotiPromotion> fetchUpdateNotiPromotion({
    String? token,
    String? statusRead,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString(KeyStorage.token) ?? ''; // ดึง Token

    try {
      // ส่งค่า status_read ไปยัง API โดยใช้คีย์ "status_read" ใน requestBody
      Map<String, dynamic> requestBody = {
        "status_read": statusRead,
      };

      Response response = await _userService.updateNotifyPromotion(
        token: token,
        statusRead: statusRead,
        requestBody: requestBody,
      );

      if (response.statusCode == 200) {
        var responseBody = json.decode(response.body);
        var statusReadFromResponse = responseBody["status_read"];

        if (statusReadFromResponse != null) {
          var notipromotion = NotiPromotion.fromJson(responseBody);
          return notipromotion;
        } else {
          return NotiPromotion();
        }
      } else {
        return notipromotion; // ส่งค่า null เมื่อไม่ได้รับสถานะ 200
      }
    } catch (e) {
      return notipromotion; // ส่งค่า null เมื่อเกิดข้อผิดพลาด
    }
  }
}
