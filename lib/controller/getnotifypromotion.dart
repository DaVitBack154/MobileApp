import 'dart:convert';
import 'dart:developer';
import 'package:mobile_chaseapp/model/respon_notipromotion.dart';
import 'package:mobile_chaseapp/utils/key_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/user_service.dart';

class NotifyPromotionController {
  final _userService = UserService();
  NotiPromotion notipromotion = NotiPromotion();

  Future<NotiPromotion> fetchNotifyPromotion() async {
    // usernotify = UserNotify();
    notipromotion = NotiPromotion();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString(KeyStorage.token) ?? ''; // ดึง Token

    try {
      var response = await _userService.getNotifyPromotion(token);
      if (response.statusCode == 200) {
        notipromotion = NotiPromotion.fromJson(json.decode(response.body));

        // print(UserNotify.fromJson(json.decode(response.body)).toJson());
      } else {
        // print('getpayment Error');
        notipromotion = NotiPromotion();
      }
    } catch (e) {
      log('catch ->$e');
      //print('Error: $e');
      notipromotion = NotiPromotion();
    }
    return notipromotion;
  }
}
