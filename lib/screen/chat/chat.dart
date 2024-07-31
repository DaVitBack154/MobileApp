import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_chaseapp/getcontroller/getcontroller.dart';
import 'package:mobile_chaseapp/model/chat_model.dart';
import 'package:mobile_chaseapp/utils/my_constant.dart';
import 'package:photo_view/photo_view.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final ChatController chatController = Get.put(ChatController());
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _pickImages() async {
    final pickedFiles = await _picker.pickMultiImage();
    if (pickedFiles.isNotEmpty) {
      final List<File> imageFiles =
          pickedFiles.map((file) => File(file.path)).toList();

      // อัปโหลดภาพและรับ URL
      final imageUrls = await chatController.uploadImages(imageFiles);

      // ส่งข้อความพร้อมกับ URL ของภาพ
      var message = ChatMessage(
        sender: chatController.name.value,
        message: '',
        receiver: 'admin',
        type: 'file',
        statusRead: 'N',
        statusConnect: 'N',
        idCard: chatController.idcard.value,
        image: imageUrls,
      );
      chatController.sendMessage(message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: Text(
              'ติดต่อพนักงาน',
              style: TextStyle(
                fontSize: MyConstant.setMediaQueryWidth(context, 27),
              ),
            ),
            foregroundColor: Colors.white,
            backgroundColor: const Color(0xFF103533),
          ),
          body: Container(
            color: Colors.white,
            // padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: Column(
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
                            message.receiver == chatController.name.value)
                        .toList();

                    ScrollController scrollslide = chatController.scoll.value;

                    Future.delayed(
                      const Duration(milliseconds: 100),
                      () {
                        scrollslide.animateTo(
                          scrollslide.position.maxScrollExtent,
                          duration: const Duration(milliseconds: 1000),
                          curve: Curves.fastOutSlowIn,
                        );
                      },
                    );

                    return ListView.builder(
                      controller: scrollslide,
                      itemCount: filteredMessages.length,
                      itemBuilder: (context, index) {
                        var message = filteredMessages[index];

                        // ใช้ Align เพื่อจัดตำแหน่งข้อความ
                        return Align(
                          alignment: message.sender == chatController.name.value
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment:
                                message.sender == chatController.name.value
                                    ? CrossAxisAlignment.end
                                    : CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              if (message.sender != chatController.name.value)
                                Container(
                                  margin: EdgeInsets.symmetric(
                                    horizontal: 12.w,
                                  ),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.grey.shade200,
                                    radius: 22,
                                    child: Image.asset(
                                      'assets/image/icon_a.png',
                                      fit: BoxFit.cover,
                                      height: 18.h,
                                    ),
                                  ),
                                ),
                              message.type == 'text'
                                  ? Container(
                                      margin: EdgeInsets.only(
                                        top: 10,
                                        bottom: 5,
                                        left: message.sender ==
                                                chatController.name.value
                                            ? 80
                                            : 15,
                                        right: message.sender ==
                                                chatController.name.value
                                            ? 15
                                            : 80,
                                      ),
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: message.sender ==
                                                chatController.name.value
                                            ? Color(0xFF0084FF)
                                            : Colors.grey[200],
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        children: [
                                          Text(
                                            message.message ?? '',
                                            style: TextStyle(
                                              fontSize:
                                                  MyConstant.setMediaQueryWidth(
                                                context,
                                                20,
                                              ),
                                              color: message.sender ==
                                                      chatController.name.value
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : message.image != null &&
                                          message.image!.isNotEmpty
                                      ? Container(
                                          margin: EdgeInsets.only(
                                            top: 10,
                                            bottom: 5,
                                            left: message.sender ==
                                                    chatController.name.value
                                                ? 80
                                                : 15,
                                            right: message.sender ==
                                                    chatController.name.value
                                                ? 15
                                                : 80,
                                          ),
                                          child: Wrap(
                                            spacing: 8.0,
                                            runSpacing: 8.0,
                                            alignment: WrapAlignment.center,
                                            children: message.image!.map(
                                              (imageUrl) {
                                                return InkWell(
                                                  onTap: () async {
                                                    if (mounted) {
                                                      await showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return Stack(
                                                            children: [
                                                              Positioned.fill(
                                                                child:
                                                                    PhotoView(
                                                                  imageProvider:
                                                                      NetworkImage(
                                                                          imageUrl),
                                                                ),
                                                              ),
                                                              Positioned(
                                                                top: 20,
                                                                right: 10,
                                                                child:
                                                                    IconButton(
                                                                  icon:
                                                                      const Icon(
                                                                    Icons.close,
                                                                    color: Colors
                                                                        .white,
                                                                    size: 40,
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                ),
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      );
                                                    }
                                                  },
                                                  child: Container(
                                                    width: MyConstant
                                                        .setMediaQueryWidth(
                                                      context,
                                                      140,
                                                    ),
                                                    height: MyConstant
                                                        .setMediaQueryHeight(
                                                      context,
                                                      130,
                                                    ),
                                                    clipBehavior: Clip.hardEdge,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors
                                                              .grey.shade300,
                                                          width: 1.0),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: Image.network(
                                                      imageUrl,
                                                      fit: BoxFit.cover,
                                                      errorBuilder: (context,
                                                              error,
                                                              stackTrace) =>
                                                          const Icon(
                                                              Icons.error,
                                                              color:
                                                                  Colors.red),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ).toList(),
                                          ),
                                        )
                                      : const SizedBox.shrink(),
                            ],
                          ),
                        );
                      },
                    );
                  }),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 0,
                    left: 10,
                    right: 10,
                    bottom: 35,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(24)),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.image,
                            color: Color.fromARGB(255, 29, 105, 101),
                            size: 25,
                          ),
                          onPressed: _pickImages,
                        ),
                        Expanded(
                          child: Container(
                            constraints: const BoxConstraints(maxHeight: 150),
                            child: TextFormField(
                              maxLines: null,
                              keyboardType: TextInputType.multiline,
                              controller:
                                  chatController.messageController.value,
                              decoration: const InputDecoration(
                                hintText: 'กรุณาพิมพ์ข้อความ',
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none),
                              ),
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.send,
                            color: Color.fromARGB(255, 29, 105, 101),
                          ),
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
                              statusRead: 'N',
                              statusConnect: 'N',
                              idCard: chatController.idcard.value,
                              role: 'user',
                              image: [],
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
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
