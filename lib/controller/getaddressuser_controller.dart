import 'dart:convert';
import 'package:mobile_chaseapp/model/respon_user_req.dart';
import 'package:mobile_chaseapp/utils/key_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/user_service.dart';

class AddressUserController {
  final _userService = UserService();
  UserReq userreq = UserReq();

  Future<UserReq> fetchAddressUser() async {
    UserReq userreq = UserReq();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString(KeyStorage.token) ?? ''; // ดึง Token
    try {
      var response = await _userService.getUserAddress(token);
      if (response.statusCode == 200) {
        userreq = UserReq.fromJson(json.decode(response.body));
      } else {
        // print('getprofile Error');
        userreq = UserReq();
      }
    } catch (e) {
      // print('Error: $e');
      userreq = UserReq();
    }

    return userreq;
  }
}
