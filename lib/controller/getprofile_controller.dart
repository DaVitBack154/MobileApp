import 'dart:convert';
import '../model/respon_user.dart';
import '../services/user_service.dart';

class ProfileController {
  final _userService = UserService();

  UserModel userModel = UserModel();
  UserModel? userModel1;

  Future<UserModel> fetchProfileData(String token) async {
    try {
      var response = await _userService.getProfileUser(token);
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        userModel = UserModel.fromJson(json);
      } else {
        print('getprofile Error');
        userModel = UserModel();
      }
    } catch (e) {
      print('Error: $e');
      userModel = UserModel();
    }

    return userModel;
  }

  Future<UserModel?> fetchProfileData1(String token) async {
    try {
      var response = await _userService.getProfileUser(token);
      print(response.statusCode);
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        userModel1 = UserModel.fromJson(json);
      } else {
        print('getprofile Error');
        userModel1 = null;
      }
    } catch (e) {
      print('Error: $e');
      userModel1 = null;
    }

    return userModel1;
  }
}
