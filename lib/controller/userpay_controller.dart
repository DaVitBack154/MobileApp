import 'dart:convert';
import 'package:mobile_chaseapp/model/respon_payuser.dart';
import 'package:mobile_chaseapp/services/user_service.dart';

class UserPayController {
  final _userService = UserService();

  Future<Payuser?> createUserPay({
    required String customerId,
    required String idCard,
    required String name,
    required String surname,
    required String company,
    required String status,
  }) async {
    try {
      var response = await _userService.createPayUser(
        customerId: customerId,
        name: name,
        surname: surname,
        idCard: idCard,
        company: company,
        status: status,
      );

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        Payuser payuser = Payuser.fromJson(json);
        print('Payuser: $payuser');
        return payuser;
      } else {
        print('User request error');
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
}
