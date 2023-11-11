import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mobile_chaseapp/model/respon_user_req.dart';
import 'package:mobile_chaseapp/services/user_service.dart';
//import 'package:shared_preferences/shared_preferences.dart';

class UserReqController {
  final _userService = UserService();

  UserReq userreq = UserReq();

  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController idCardController = TextEditingController();
  TextEditingController noContractController = TextEditingController();
  TextEditingController listReqController = TextEditingController();
  TextEditingController receiveNoController = TextEditingController();
  TextEditingController sentEmailuserController = TextEditingController();
  TextEditingController sentAddressuserController = TextEditingController();
  TextEditingController provinController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController subdistrictController = TextEditingController();
  TextEditingController postcodeController = TextEditingController();
  TextEditingController otherController = TextEditingController();

  Future<String> fetchUserReq({
    required String name,
    required String surname,
    required String idCard,
    required String noContract,
    required String listReq,
    required String receiveNo,
    String? sentEmailuser,
    String? sentAddressuser,
    String? provin,
    String? district,
    String? subdistrict,
    String? postcode,
    String? other,
  }) async {
    //final prefs = await SharedPreferences.getInstance();

    try {
      var response = await _userService.createUserReq(
        name: name,
        surName: surname,
        idCard: idCard,
        noContract: noContract,
        listReq: listReq,
        receiveNo: receiveNo,
        sentEmailuser: sentEmailuser,
        sentAddressuser: sentAddressuser,
        provin: provin,
        district: district,
        subdistrict: subdistrict,
        postcode: postcode,
        other: other,
      );

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        userreq = UserReq.fromJson(json);
        //save this token in shared preferences and make user logged in and navigate
        print('Test: ${userreq}');

        return '';
      } else {
        print('userreq Error');
        userreq = UserReq();
        return 'กรุณากรอกข้อมูลที่อยู่ให้ถูกต้อง';
      }
    } catch (e) {
      print('Error: $e'); // แสดงข้อความผิดพลาดในกรณีเกิด Exception
      userreq = UserReq();
      return 'เกิดข้อผิดพลาดในระบบ';
    }
  }
}
