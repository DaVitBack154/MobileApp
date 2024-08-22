import 'dart:async';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_chaseapp/getcontroller/getcontroller.dart';
import 'package:mobile_chaseapp/model/chat_model.dart';
import 'package:mobile_chaseapp/utils/my_constant.dart';
import 'package:photo_view/photo_view.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final ChatController chatController = Get.find<ChatController>();
  // final DateServerController dateController = DateServerController();
  final ImagePicker _picker = ImagePicker();
  // var dateServer = '';
  // Timer? timer1;
  List? filteredMessages;
  // bool langtime = false;
  // bool sendmessageUser = false;

  @override
  void initState() {
    super.initState();
    // timer1 = Timer.periodic(
    //   const Duration(seconds: 1),
    //   (timer1) {
    //     if (mounted) {
    //       dateController.fetchDateServer().then(
    //         (value) {
    //           dateServer = dateController.dateServer.data.toString();
    //           // print(dateServer);
    //           DateTime timelangmai = DateTime.parse(dateServer);
    //           if (timelangmai.isAfter(
    //             mounted
    //                 ? DateTime(timelangmai.year, timelangmai.month,
    //                         timelangmai.day, 20, 00, 0)
    //                     .subtract(
    //                     const Duration(seconds: 1),
    //                   )
    //                 : DateTime(timelangmai.year, timelangmai.month,
    //                     timelangmai.day, 20, 00, 0),
    //           )) {
    //             langtime = true;
    //             if (langtime) {
    //               if (!sendmessageUser) {
    //                 sendmessageUser = true;
    //                 //sendmessageUser ถ้าเป็น true คือส่ง 1  ครั้ง แต่ถ้าเป็น false ไม่ส่ง
    //                 //langtime ถ้าเป็น false ไม่ทำอะไร ถ้าเป็น trueเอาตัว sendmessageUser มาใช้
    //                 //sendข้อความนอกเวลา
    //                 var message = ChatMessage(
    //                   sender: '',
    //                   receiver: chatController.name.value,
    //                   message: 'หมดเวลา',
    //                   type: 'text',
    //                   statusRead: 'N',
    //                   statusConnect: 'N',
    //                   role: 'admin',
    //                   idCard: chatController.idcard.value,
    //                 );
    //                 chatController.sendMessage(message);
    //               }
    //             }
    //           }
    //         },
    //       );
    //       //date out
    //     }
    //   },
    // );
  }

  @override
  void dispose() {
    super.dispose();
    // if (timer1 != null) {
    //   timer1!.cancel();
    //   timer1 = null;
    // }
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
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Get.back(result: true); // ส่งค่า true กลับไปยังหน้า Profile
              },
            ),
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
                    filteredMessages = chatController.messages
                        .where((message) =>
                            message.sender == chatController.name.value ||
                            message.idCard == chatController.idcard.value ||
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
                        // update controller
                      },
                    );

                    return ListView.builder(
                      controller: scrollslide,
                      itemCount: filteredMessages!.length,
                      itemBuilder: (context, index) {
                        ChatMessage message = filteredMessages![index];

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
                                            children: [
                                              ...message.image!.map((fileUrl) {
                                                String fileName =
                                                    path.basename(fileUrl);
                                                bool isImage = [
                                                  'jpg',
                                                  'jpeg',
                                                  'png',
                                                  'gif'
                                                ].contains(
                                                    fileUrl.split('.').last);
                                                if (isImage) {
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
                                                                            fileUrl),
                                                                  ),
                                                                ),
                                                                Positioned(
                                                                  top: 20,
                                                                  right: 10,
                                                                  child:
                                                                      IconButton(
                                                                    icon:
                                                                        const Icon(
                                                                      Icons
                                                                          .close,
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
                                                              context, 140),
                                                      height: MyConstant
                                                          .setMediaQueryHeight(
                                                              context, 130),
                                                      clipBehavior:
                                                          Clip.hardEdge,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Colors
                                                                .grey.shade300,
                                                            width: 1.0),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: Image.network(
                                                        fileUrl,
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
                                                }
                                                return InkWell(
                                                  onTap: () async {
                                                    if (await canLaunch(
                                                        fileUrl)) {
                                                      await launch(fileUrl);
                                                    } else {
                                                      throw 'Could not launch $fileUrl';
                                                    }
                                                  },
                                                  child: Container(
                                                    padding: EdgeInsets.all(8),
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors
                                                              .grey.shade300,
                                                          width: 1.0),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Icon(
                                                            Icons
                                                                .picture_as_pdf,
                                                            color: Colors.red),
                                                        SizedBox(width: 8),
                                                        Text(fileName),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }).toList()
                                            ],
                                            // children: message.image!.map(
                                            //   (fileUrl) {
                                            //     bool isImage = fileUrl
                                            //             .toLowerCase()
                                            //             .endsWith('.jpg') ||
                                            //         fileUrl
                                            //             .toLowerCase()
                                            //             .endsWith('.jpeg') ||
                                            //         fileUrl
                                            //             .toLowerCase()
                                            //             .endsWith('.png') ||
                                            //         fileUrl
                                            //             .toLowerCase()
                                            //             .endsWith('.gif');
                                            // // ['.jpg',].contains(fileUrl
                                            // //             .toLowerCase());
                                            //     String fileName =
                                            //         path.basename(fileUrl);

                                            //     return isImage
                                            //         ? InkWell(
                                            //             onTap: () async {
                                            //               if (mounted) {
                                            //                 await showDialog(
                                            //                   context: context,
                                            //                   builder:
                                            //                       (context) {
                                            //                     return Stack(
                                            //                       children: [
                                            //                         Positioned
                                            //                             .fill(
                                            //                           child:
                                            //                               PhotoView(
                                            //                             imageProvider:
                                            //                                 NetworkImage(fileUrl),
                                            //                           ),
                                            //                         ),
                                            //                         Positioned(
                                            //                           top: 20,
                                            //                           right: 10,
                                            //                           child:
                                            //                               IconButton(
                                            //                             icon:
                                            //                                 const Icon(
                                            //                               Icons
                                            //                                   .close,
                                            //                               color:
                                            //                                   Colors.white,
                                            //                               size:
                                            //                                   40,
                                            //                             ),
                                            //                             onPressed:
                                            //                                 () {
                                            //                               Navigator.of(context)
                                            //                                   .pop();
                                            //                             },
                                            //                           ),
                                            //                         ),
                                            //                       ],
                                            //                     );
                                            //                   },
                                            //                 );
                                            //               }
                                            //             },
                                            //             child: Container(
                                            //               width: MyConstant
                                            //                   .setMediaQueryWidth(
                                            //                       context, 140),
                                            //               height: MyConstant
                                            //                   .setMediaQueryHeight(
                                            //                       context, 130),
                                            //               clipBehavior:
                                            //                   Clip.hardEdge,
                                            //               decoration:
                                            //                   BoxDecoration(
                                            //                 border: Border.all(
                                            //                     color: Colors
                                            //                         .grey
                                            //                         .shade300,
                                            //                     width: 1.0),
                                            //                 borderRadius:
                                            //                     BorderRadius
                                            //                         .circular(
                                            //                             10),
                                            //               ),
                                            //               child: Image.network(
                                            //                 fileUrl,
                                            //                 fit: BoxFit.cover,
                                            //                 errorBuilder: (context,
                                            //                         error,
                                            //                         stackTrace) =>
                                            //                     const Icon(
                                            //                         Icons.error,
                                            //                         color: Colors
                                            //                             .red),
                                            //               ),
                                            //             ),
                                            //           )

                                            //         :
                                            //         InkWell(
                                            //             onTap: () async {
                                            //               if (await canLaunch(
                                            //                   fileUrl)) {
                                            //                 await launch(
                                            //                     fileUrl);
                                            //               } else {
                                            //                 throw 'Could not launch $fileUrl';
                                            //               }
                                            //             },
                                            //             child: Container(
                                            //               padding:
                                            //                   EdgeInsets.all(8),
                                            //               decoration:
                                            //                   BoxDecoration(
                                            //                 border: Border.all(
                                            //                     color: Colors
                                            //                         .grey
                                            //                         .shade300,
                                            //                     width: 1.0),
                                            //                 borderRadius:
                                            //                     BorderRadius
                                            //                         .circular(
                                            //                             10),
                                            //               ),
                                            //               child: Row(
                                            //                 mainAxisSize:
                                            //                     MainAxisSize
                                            //                         .min,
                                            //                 children: [
                                            //                   Icon(
                                            //                       Icons
                                            //                           .picture_as_pdf,
                                            //                       color: Colors
                                            //                           .red),
                                            //                   SizedBox(
                                            //                       width: 8),
                                            //                   Text(fileName),
                                            //                 ],
                                            //               ),
                                            //             ),
                                            //           );

                                            //   },
                                            // ).toList(),
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
                              statusRead: 'SU',
                              statusConnect: 'N',
                              //เงื่อนไขกดปุ่ม update ถ้า user == ru  admin == ra

                              //ถ้า แอดมินเชื่อมแล้ว connect  == N  connect  == Y
                              //เงื่อนไขแอดมินเป็น Y จะมีข้อความบอกว่าแอดมินพร้อมบริการ

                              //status read

                              //admin === sa  แอดมินส่ง  ฝั่งของโมบายตัวนับจำนวนข้อความที่ยังไม่ได้อ่าน
                              //user === su  userส่ง  ฝั่งของเว็บตัวนับจำนวนข้อความที่ยังไม่ได้อ่าน
                              //admin === ra  แอดมินอ่าน
                              //user === ru   userอ่าน ค่าแรก
                              //ทำ api เชคสเตตัสเป็น a เพื่อนับข้อความ
                              idCard: chatController.idcard.value,
                              role: 'user',
                            );
                            if (kDebugMode) {
                              print('Sending message: ${message.message}');
                            } // เพิ่ม print ที่นี่
                            chatController.sendMessage(message);
                            chatController.messageController.value.clear();
                            // sendmessageUser = false;
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
