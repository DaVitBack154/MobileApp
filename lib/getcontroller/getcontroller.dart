import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_chaseapp/model/chat_model.dart';
import 'package:mobile_chaseapp/utils/key_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'dart:convert';

class ChatController extends GetxController {
  RxList<ChatMessage> messages = <ChatMessage>[].obs;
  late IO.Socket socket;
  Rx<ScrollController> sadsad = ScrollController().obs;
  Rx<TextEditingController> messageController = TextEditingController().obs;
  Rx<String?> name = Rx<String?>(null);
  Rx<String?> idcard = Rx<String?>(null);

  @override
  void onInit() {
    super.onInit();
    connectSocket();
    fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      name.value = prefs.getString(KeyStorage.name);

      idcard.value = prefs.getString(KeyStorage.idCard);
    } catch (error) {
      print(error);
    }

    return;
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
        // รับข้อมูลเป็น List<dynamic> ตรงๆ
        List<dynamic> messageData = data;
        messages.value =
            messageData.map((json) => ChatMessage.fromJson(json)).toList();
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

  void sendMessage(ChatMessage message) {
    try {
      socket.emit('sendMessage', json.encode(message.toJson()));
      print('Message sent: ${message.message}');
    } catch (e) {
      print('Error sending message: $e');
    }
  }
}
