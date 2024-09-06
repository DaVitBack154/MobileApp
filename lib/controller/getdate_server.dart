import 'dart:convert';
import 'package:mobile_chaseapp/model/respon_dateserver.dart';
import '../services/user_service.dart';

class DateServerController {
  final _userService = UserService();
  DateServer dateServer = DateServer();

  Future<DateServer> fetchDateServer() async {
    try {
      var response = await _userService.getDateServer();
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        dateServer = DateServer.fromJson(json); // อัปเดตตัวแปรใน controller
        print('Fetched date data: ${dateServer.data}');
      } else {
        print(
            'Error: Failed to fetch date server, status code: ${response.statusCode}');
        dateServer = DateServer(); // รีเซ็ตเมื่อเกิดข้อผิดพลาด
      }
    } catch (e) {
      print('Error: $e');
      dateServer = DateServer(); // รีเซ็ตเมื่อเกิดข้อผิดพลาด
    }
    return dateServer; // คืนค่ากลับ
  }
}
