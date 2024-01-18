import 'dart:convert';
import 'package:mobile_chaseapp/model/respon_companycontract.dart';
import '../services/user_service.dart';

class GetcompanyContract {
  final _userService = UserService();
  CompanyContractModel companycontract = CompanyContractModel();

  Future<CompanyContractModel> fetchGetcompanycontract() async {
    companycontract = CompanyContractModel();
    try {
      var response = await _userService.getCompanyContract();
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        print(json);
        companycontract = CompanyContractModel.fromJson(json);
        //print(GetsaleHome.data.toString());
      } else {
        //print('datesurver Error');
        companycontract = CompanyContractModel();
      }
    } catch (e) {
      //print('Error: $e');
      companycontract = CompanyContractModel();
    }
    return companycontract;
  }
}
