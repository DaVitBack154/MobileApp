import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_chaseapp/controller/getdate_server.dart';
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
  Rx<String?> role = Rx<String?>(null);
  Rx<String?> idcard = Rx<String?>(null);
  Rx<String?> statusRead = Rx<String?>(null);
  RxList<File> selectedImages = <File>[].obs;
  var isOutOfWorkingHours = false.obs;
  Rx<DateTime?> lastSentDate = Rx<DateTime?>(null);
  // var currentStatusEnd = ''.obs;
  var lastStatusEnd = ''.obs;

  final DateServerController dateController = DateServerController();
  var dateServer = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserProfile().then((_) => connectSocket());
    // loadData();
  }

  // Future<void> loadData() async {
  //   await Future.delayed(Duration(seconds: 1));
  //   loading.value = false;
  // }

  // void refreshData() async {
  //   loading.value = true;
  //   await loadData();
  // }

  Future<void> fetchUserProfile() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      name.value = prefs.getString(KeyStorage.name);
      idcard.value = prefs.getString(KeyStorage.idCard);
      final dateString = prefs.getString(KeyStorage.lastSentDate);
      if (dateString != null) {
        lastSentDate.value = DateTime.parse(dateString);
      } else {
        lastSentDate.value = null;
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> saveLastSentDate(DateTime date) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(KeyStorage.lastSentDate, date.toIso8601String());
  }

  void connectSocket() {
    socket = IO.io('http://18.140.121.108:4000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
    });

    socket.onConnect((_) {
      print('Connected to server');
      socket.emit('requestMessages');
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

        var welcomeMessage01 = ChatMessage(
          sender: '',
          receiver: name.value,
          message: 'สวัสดีคุณ ${name.value}',
          type: 'text',
          statusRead: '',
          statusConnect: '',
          idCard: '',
          role: 'user',
        );

        if (!messages.any((msg) => msg.message == welcomeMessage01.message)) {
          messages.insert(0, welcomeMessage01);
        }

        print('Initial messages receiveddddddddd: ${messages.length}');
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

    // ฟังเหตุการณ์ Timeout จากเซิร์ฟเวอร์
    socket.on('outOfWorkingHours', (data) {
      isOutOfWorkingHours.value =
          data == 'หมดเวลาทำการ'; // ตรวจสอบข้อความที่ได้รับ
      print('Received outOfWorkingHours signal: $data');

      // ส่งข้อความถ้าเป็นช่วงหมดเวลาทำการ
      sendMessageWithTimeoutCheck();
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
        statusRead: 'SU',
        statusConnect: 'N',
        idCard: idcard.value,
        role: 'user',
        image: imageUrls,
      );

      // ส่งข้อความ
      await sendMessage(message);

      // เคลียร์ข้อมูล
      messageController.value.clear();
      selectedImages.clear();
    } catch (e) {
      print('Error sending message with images: $e');
    }
  }

  Future<void> sendMessage(ChatMessage message) async {
    try {
      // ส่งข้อความผ่าน socket
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

  void updateStatusRead() {
    if (idcard.value != null) {
      try {
        // ส่งข้อมูล id_card ไปยังเซิร์ฟเวอร์
        socket.emit('read-user', json.encode({'CardID': idcard.value}));
        print('Status read updated for id_card: ${idcard.value}');
      } catch (e) {
        print('Error updating status read: $e');
      }
    } else {
      print('No id_card available');
    }
  }

  Future<String> getCurrentStatusEnd() async {
    if (idcard.value == null) return '';

    final url =
        'http://18.140.121.108:4000/getstatusend?id_card=${idcard.value}';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // ตรวจสอบว่ามีรายการใน results หรือไม่
        if (data['results'].isNotEmpty) {
          // ตรวจสอบค่าของ status_end จากข้อมูลที่ได้รับ
          return data['results'][0]['status_end'] ?? '';
        } else {
          // ไม่พบรายการ
          return '';
        }
      } else {
        print('Failed to load status end: ${response.statusCode}');
        return '';
      }
    } catch (e) {
      print('Error checking status end: $e');
      return '';
    }
  }

  Future<bool> handleSendWelcomeMessage() async {
    String currentStatusEnd = await getCurrentStatusEnd();

    if (currentStatusEnd == 'Y' && lastStatusEnd.value != 'Y') {
      sendWelcomeMessage();
      lastStatusEnd.value = 'Y'; // อัปเดตสถานะล่าสุดหลังจากส่งข้อความ
      return true; // ส่งข้อความต้อนรับแล้ว
    } else if (currentStatusEnd == 'N') {
      lastStatusEnd.value = 'N'; // อัปเดตสถานะล่าสุดหากไม่เป็น 'Y'
    } else {
      lastStatusEnd.value = currentStatusEnd;
    }
    return false; // ไม่ได้ส่งข้อความ
  }

  void sendWelcomeMessage() {
    // สร้างข้อความต้อนรับ
    var welcomeMessage = ChatMessage(
      sender: 'auto',
      receiver: name.value,
      message: 'สวัสดีคุณ ${name.value} เก็บลง data',
      type: 'text',
      statusRead: 'RU',
      statusConnect: 'Y',
      idCard: idcard.value,
      role: 'admin',
    );

    // ตรวจสอบว่าข้อความต้อนรับนี้ยังไม่มีอยู่ในแชท
    // ส่งข้อความต้อนรับทุกครั้ง
    messages.insert(0, welcomeMessage);
    sendMessage(welcomeMessage);
  }

  Future<void> sendMessageWithTimeoutCheck() async {
    try {
      print('isOutOfWorkingHours.value: ${isOutOfWorkingHours.value}');

      if (isOutOfWorkingHours.value) {
        var today = DateTime.now();
        var todayDate =
            DateTime(today.year, today.month, today.day); // เก็บวันที่ปัจจุบัน

        // ดึงวันที่ล่าสุดจาก SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        final dateString = prefs.getString(KeyStorage.lastSentDate);
        lastSentDate.value =
            dateString != null ? DateTime.parse(dateString) : null;

        // ตรวจสอบว่าต้องส่งข้อความใหม่หรือไม่
        if (lastSentDate.value == null || lastSentDate.value != todayDate) {
          var outTime = ChatMessage(
            sender: name.value,
            receiver: name.value,
            message: 'หมดเวลาทำการแล้ว',
            type: 'text',
            statusRead: 'RU',
            statusConnect: 'Y',
            idCard: idcard.value,
            role: 'admin',
          );

          // if (!messages.any((msg) => msg.message == outTime.message)) {
          //   messages.insert(0, outTime);
          //   // ส่งข้อความ

          // }

          await sendMessage(outTime);

          // บันทึกวันที่ที่ส่งข้อความไปแล้ว
          await prefs.setString(
              KeyStorage.lastSentDate, todayDate.toIso8601String());
          print('Message sent and date updated to: $todayDate');
        }
      } else {
        print('Not out of working hours');
      }
    } catch (e) {
      print('Error in sendMessageWithTimeoutCheck: $e');
    }
  }

  void triggerTimeoutEvent() {
    print('Triggering Timeout event');
    socket.emit('Timeout');
  }
}

  // void clearData() {
  //   statusRead.value = null;
  // }
