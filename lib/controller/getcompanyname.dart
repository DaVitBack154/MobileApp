import 'dart:convert';
import 'package:mobile_chaseapp/model/respon_companyname.dart';
import '../services/user_service.dart';

class GetCompanyname {
  final _userService = UserService();
  CompanyModel companyname = CompanyModel();

  Future<CompanyModel> fetchGetcompanyname() async {
    companyname = CompanyModel();
    try {
      var response = await _userService.getCompanyname();
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        print(json);
        companyname = CompanyModel.fromJson(json);
        //print(GetsaleHome.data.toString());
      } else {
        //print('datesurver Error');
        companyname = CompanyModel();
      }
    } catch (e) {
      //print('Error: $e');
      companyname = CompanyModel();
    }
    return companyname;
  }
}
