import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_chaseapp/model/chat_model.dart';
import 'package:mobile_chaseapp/utils/key_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatController extends GetxController {
  RxList<ChatMessage> messages = <ChatMessage>[].obs;
  late IO.Socket socket;
  Rx<ScrollController> scoll = ScrollController().obs;
  Rx<TextEditingController> messageController = TextEditingController().obs;
  Rx<String?> name = Rx<String?>(null);
  Rx<String?> idcard = Rx<String?>(null);
  var WelcomeMessage = true.obs;
  RxList<File> selectedImages = <File>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserProfile().then((_) => connectSocket());
  }

  Future<void> fetchUserProfile() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      name.value = prefs.getString(KeyStorage.name);
      idcard.value = prefs.getString(KeyStorage.idCard);
    } catch (error) {
      print(error);
    }
  }

  void connectSocket() {
    socket = IO.io('http://18.140.121.108:4000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
    });

    socket.onConnect((_) {
      print('Connected to server');
      socket.emit(
          'requestMessages'); // ขอข้อความที่มีอยู่แล้วเมื่อเชื่อมต่อสำเร็จ
    });

    socket.onDisconnect((_) {
      print('Disconnected from server');
    });

    socket.on('initialMessages', (data) {
      try {
        List<dynamic> messageData = data;
        messages.value =
            messageData.map((json) => ChatMessage.fromJson(json)).toList();

        // เพิ่มข้อความต้อนรับใน messages หากไม่มีข้อความนี้
        var welcomeMessage = ChatMessage(
          sender: '',
          receiver: name.value,
          message: 'สวัสดีคุณ ${name.value}',
          type: 'text',
          statusRead: '',
          statusConnect: '',
          idCard: '',
          role: '',
          image: [],
        );

        if (!messages.any((msg) => msg.message == welcomeMessage.message)) {
          messages.insert(0, welcomeMessage);
        }

        print('Initial messages received: ${messages.length}');
      } catch (e) {
        print('Error decoding initial messages: $e');
      }
    });

    socket.on('receiveMessage', (data) {
      print('Data received: $data'); // แสดงข้อมูลที่ได้รับ
      try {
        var message = ChatMessage.fromJson(json.decode(data));
        messages.add(message); // เพิ่มข้อความลงใน list
        print('Message received: ${message.message}'); // แสดงข้อความที่รับ
      } catch (e) {
        print('Error decoding message: $e');
      }
    });

    socket.onConnectError((error) {
      print('Connection Error: $error');
    });

    socket.onConnectTimeout((_) {
      print('Connection Timeout');
    });
  }

  Future<void> sendMessageWithImages() async {
    try {
      List<String> imageUrls = [];

      // อัพโหลดภาพหากมีภาพที่เลือก
      if (selectedImages.isNotEmpty) {
        imageUrls = await uploadImages(selectedImages);
      }

      // สร้างข้อความ
      final message = ChatMessage(
        sender: name.value,
        message: messageController.value.text,
        receiver: 'admin',
        statusRead: 'unread',
        statusConnect: 'N',
        idCard: idcard.value,
        role: 'user',
        image: imageUrls,
      );

      // ส่งข้อความ
      sendMessage(message);

      // เคลียร์ข้อมูล
      messageController.value.clear();
      selectedImages.clear();
    } catch (e) {
      print('Error sending message with images: $e');
    }
  }

  void sendMessage(ChatMessage message) {
    try {
      socket.emit('sendMessage', json.encode(message.toJson()));
      print('Message sent: ${message.message}');
    } catch (e) {
      print('Error sending message: $e');
    }
  }

  Future<List<String>> uploadImages(List<File> imageFiles) async {
    final List<String> imageUrls = [];

    try {
      final request = http.MultipartRequest(
          'POST', Uri.parse('http://18.140.121.108:4000/upload/img'));
      for (var imageFile in imageFiles) {
        request.files
            .add(await http.MultipartFile.fromPath('image', imageFile.path));
      }

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      final responseData = jsonDecode(responseBody);

      print('Response status: ${response.statusCode}');
      print('Response body: $responseBody');

      if (responseData['status'] == true) {
        print('Upload successful: ${responseData['message']}');
        imageUrls
            .addAll(List<String>.from(responseData['data']['selectedImages']));
      } else {
        print('Upload failed: ${responseData['message']}');
      }
    } catch (e) {
      print('Error uploading images: $e');
    }

    return imageUrls;
  }
}
