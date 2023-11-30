import 'dart:convert';
import 'package:mobile_chaseapp/model/respon_salehome.dart';
import '../services/user_service.dart';

class GetsaleHomeController {
  final _userService = UserService();
  SaleHome saleHome = SaleHome();

  Future<SaleHome> fetchGetsaleHome() async {
    saleHome = SaleHome();
    try {
      var response = await _userService.getSaleHome();
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        print(json);
        saleHome = SaleHome.fromJson(json);
        //print(GetsaleHome.data.toString());
      } else {
        //print('datesurver Error');
        saleHome = SaleHome();
      }
    } catch (e) {
      //print('Error: $e');
      saleHome = SaleHome();
    }
    return saleHome;
  }

  Future<SaleHome> fetchGetsaleHomeId(String id) async {
    try {
      var response = await _userService.getSaleHomeID(id);

      var json = jsonDecode(response.body);

      return SaleHome.fromJson(json);
    } catch (e) {
      return saleHome;
    }
  }
}
