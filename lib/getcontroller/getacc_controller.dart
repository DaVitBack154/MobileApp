import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_chaseapp/utils/key_storage.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerController extends GetxController {
  Rx<String?> idcard = Rx<String?>(null);
  Rx<String?> typeCustomer = Rx<String?>(null);

  @override
  void onInit() {
    super.onInit();
    // fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      idcard.value = prefs.getString(KeyStorage.idCard);

      // ถ้า idCard ไม่ใช่ null ให้เรียก fetchtypeCustomer เพื่อดึงข้อมูลประเภทลูกค้า
      if (idcard.value != null) {
        fetchtypeCustomer(idcard.value!);
      }
    } catch (error) {
      print(error);
      Get.snackbar('Error', 'Failed to load user profile');
    }
  }

  void fetchtypeCustomer(String idcard) async {
    try {
      final response = await http.get(Uri.parse(
          'http://18.140.121.108:5500/get_typecustomer?id_card=$idcard'));

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        // อัปเดตค่า typeCustomer ด้วยข้อมูลที่ได้รับจาก API
        typeCustomer.value = jsonData['type_customer'];
      } else {
        Get.snackbar('Error', 'Failed to fetch customer type');
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong');
    }
  }
}
