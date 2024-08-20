// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:mobile_chaseapp/model/chat_model.dart';
// import 'dart:convert';
// import 'package:mobile_chaseapp/utils/key_storage.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class ChanelUserController extends GetxController {
//   var isLoading = false.obs;

//   Rx<String?> name = Rx<String?>(null);
//   Rx<String?> surname = Rx<String?>(null);
//   Rx<String?> idcard = Rx<String?>(null);
//   Rx<String?> chanel = Rx<String?>(null);

//   @override
//   void onInit() {
//     super.onInit();
//     getDataUser();
//   }

//   Future<void> getDataUser() async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       uid.value = prefs.getString(KeyStorage.uid);
//       name.value = prefs.getString(KeyStorage.name);
//       surname.value = prefs.getString(KeyStorage.surname);
//       idcard.value = prefs.getString(KeyStorage.idCard);
//     } catch (error) {
//       print(error);
//     }
//   }

//   Future<bool> createUser(ChatMessage user) async {
//     isLoading(true);
//     final url = 'http://18.140.121.108:4000/postmessage';
//     final headers = {'Content-Type': 'application/json'};
//     final body = json.encode(
//       ChatMessage(
//         sender: '',
//         receiver: name.value,
//         message: 'สวัสดีคุณ ${name.value}',
//         type: 'text',
//         statusRead: '',
//         statusConnect: '',
//         idCard: '',
//         role: '',
//       ).toJson(),
//     );

//     // Print the data being sent
//     print('Sending data to server: $body');

//     try {
//       final response =
//           await http.post(Uri.parse(url), headers: headers, body: body);
//       final responseBody = json.decode(response.body);

//       if (response.statusCode == 200) {
//         print('User created successfully: ${response.body}');
//         return true;
//       } else {
//         print('Failed to create user: ${response.body}');
//         if (responseBody['message']?.contains('duplicate user') == true) {
//           print('Duplicate user: ${responseBody['message']}');
//         }
//         return false;
//       }
//     } catch (e) {
//       print('Error: $e');
//       return false;
//     } finally {
//       isLoading(false);
//     }
//   }
// }
