import 'dart:convert';
import 'dart:developer';
import 'package:mobile_chaseapp/model/respon_notify.dart';
import 'package:mobile_chaseapp/utils/key_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/user_service.dart';

class NotifyController {
  final _userService = UserService();
  UserNotify usernotify = UserNotify();

  Future<UserNotify> fetchNotify() async {
    usernotify = UserNotify();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString(KeyStorage.token) ?? ''; // ดึง Token

    try {
      var response = await _userService.getNotify(token);
      if (response.statusCode == 200) {
        print('response.body -------');
        print(response.body);
        usernotify = UserNotify.fromJson(json.decode(response.body));
        // print(UserNotify.fromJson(json.decode(response.body)).toJson());
      } else {
        // print('getpayment Error');
        usernotify = UserNotify();
      }
    } catch (e) {
      log('catch ->$e');
      //print('Error: $e');
      usernotify = UserNotify();
    }
    return usernotify;
  }
}
