import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_chaseapp/getcontroller/getcontroller.dart';
import 'package:mobile_chaseapp/model/chat_model.dart';
import 'package:mobile_chaseapp/utils/key_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final ChatController chatController = Get.put(ChatController());

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Expanded(
                child: Container(
              decoration: const BoxDecoration(color: Colors.yellow),
            )),
            Expanded(
                child: Container(
              decoration: const BoxDecoration(color: Colors.white),
            )),
          ],
        ),
        SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Chat'),
              backgroundColor: Colors.amber,
            ),
            body: Column(
              children: [
                Expanded(
                  child: Obx(() {
                    if (chatController.messages.isEmpty) {
                      return const Center(child: Text('No messages yet'));
                    }
                    // กรองข้อความที่แสดง
                    var filteredMessages = chatController.messages
                        .where((message) =>
                            message.sender == chatController.name.value ||
                            message.sender == 'admin')
                        .toList();

                    ScrollController dsjasdlas = chatController.sadsad.value;
                    Future.delayed(
                      const Duration(milliseconds: 100),
                      () {
                        dsjasdlas.animateTo(dsjasdlas.position.maxScrollExtent,
                            duration: const Duration(milliseconds: 1000),
                            curve: Curves.fastOutSlowIn);
                      },
                    );
                    return ListView.builder(
                      controller: dsjasdlas,
                      itemCount: filteredMessages.length,
                      itemBuilder: (context, index) {
                        var message = filteredMessages[index];

                        // ใช้ Align เพื่อจัดตำแหน่งข้อความ
                        return Align(
                          alignment: message.sender == chatController.name.value
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Container(
                            margin: EdgeInsets.only(
                              top: 10,
                              bottom: 10,
                              left: message.sender == chatController.name.value
                                  ? 80
                                  : 15,
                              right: message.sender == chatController.name.value
                                  ? 15
                                  : 80,
                            ),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: message.sender == chatController.name.value
                                  ? Colors.blue[200]
                                  : Colors.grey[300],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment:
                                  message.sender == chatController.name.value
                                      ? CrossAxisAlignment.end
                                      : CrossAxisAlignment.start,
                              children: [
                                Text(
                                  message.sender ?? '',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 5),
                                Text(message.message ?? ''),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          constraints: const BoxConstraints(maxHeight: 150),
                          child: TextFormField(
                            maxLines: null,
                            keyboardType: TextInputType.multiline,
                            controller: chatController.messageController.value,
                            decoration: const InputDecoration(
                              hintText: 'Type a message',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: () {
                          if (chatController.messageController.value.text
                              .trim()
                              .isEmpty) {
                            return;
                          }
                          var message = ChatMessage(
                            sender: chatController.name.value,
                            message:
                                chatController.messageController.value.text,
                            receiver: 'admin',
                            type: 'text',
                            statusRead: 'unread',
                            statusConnect: 'N',
                            idCard: chatController.idcard.value,
                            images: [],
                          );
                          if (kDebugMode) {
                            print('Sending message: ${message.message}');
                          } // เพิ่ม print ที่นี่
                          chatController.sendMessage(message);
                          chatController.messageController.value.clear();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
