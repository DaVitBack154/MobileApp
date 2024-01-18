import 'dart:convert';
import 'package:http/http.dart';
import 'package:mobile_chaseapp/model/respon_notify.dart';
import 'package:mobile_chaseapp/model/respon_notipromotion.dart';
import 'package:mobile_chaseapp/utils/key_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/user_service.dart';

class UpdatePaynoti {
  final _userService = UserService();
  UserNotify userNotify = UserNotify();

  Future<UserNotify> fetchUpdatePayNoti({
    String? token,
    String? statusRead,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString(KeyStorage.token) ?? ''; // ดึง Token

    try {
      // ส่งค่า status_read ไปยัง API โดยใช้คีย์ "status_read" ใน requestBody
      Map<String, dynamic> requestBody = {
        "Status_Read": statusRead,
      };

      Response response = await _userService.updateNotifyPay(
        token: token,
        statusRead: statusRead,
        requestBody: requestBody,
      );

      if (response.statusCode == 200) {
        var responseBody = json.decode(response.body);
        var statusReadFromResponse = responseBody["Status_Read"];

        if (statusReadFromResponse != null) {
          var userNotify = UserNotify.fromJson(responseBody);
          return userNotify;
        } else {
          return UserNotify();
        }
      } else {
        return userNotify; // ส่งค่า null เมื่อไม่ได้รับสถานะ 200
      }
    } catch (e) {
      return userNotify; // ส่งค่า null เมื่อเกิดข้อผิดพลาด
    }
  }
}
