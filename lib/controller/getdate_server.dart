import 'dart:convert';
import 'package:mobile_chaseapp/model/respon_dateserver.dart';
import '../services/user_service.dart';

class DateServerController {
  final _userService = UserService();
  DateServer dateServer = DateServer();

  Future<DateServer> fetchDateServer() async {
    dateServer = DateServer();
    try {
      var response = await _userService.getDateServer();
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        dateServer = DateServer.fromJson(json);
        //print(dateServer.data.toString());
      } else {
        //print('datesurver Error');
        dateServer = DateServer();
      }
    } catch (e) {
      //print('Error: $e');
      dateServer = DateServer();
    }
    return dateServer;
  }
}
