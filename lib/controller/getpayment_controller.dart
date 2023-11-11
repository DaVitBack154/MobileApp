import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/respon_payment.dart';
import '../services/user_service.dart';
import '../utils/key_storage.dart'; // Import the UserAccModel

class PaymentController {
  final _userService = UserService();
  UserPayment userPayment = UserPayment();

  Future<UserPayment> fetchPaymentData() async {
    userPayment = UserPayment();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString(KeyStorage.token) ?? ''; // ดึง Token
    try {
      var response = await _userService.getUserPayment(token);

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        userPayment = UserPayment.fromJson(json);
      } else {
        //print('getpayment Error');
        userPayment = UserPayment();
      }
    } catch (e) {
      //print('Error: $e');
      userPayment = UserPayment();
    }
    return userPayment;
  }
}
