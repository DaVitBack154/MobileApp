import 'dart:async';
import 'dart:io';
import 'package:grouped_list/grouped_list.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:intl/intl.dart';
import 'package:mobile_chaseapp/screen/chat/formatdate_chat.dart';
import 'package:mobile_chaseapp/utils/dowloadimage.dart';
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
  final ImagePicker _picker = ImagePicker();

  List filteredMessages = [];

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
        statusRead: 'SU',
        role: 'user',
        statusConnect: 'N',
        idCard: chatController.idcard.value,
        image: imageUrls,
      );
      chatController.sendMessage(message);
    }
  }

  Future<bool> onWillPop() async {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery.withClampedTextScaling(
      minScaleFactor: 1,
      maxScaleFactor: 1,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: PopScope(
          onPopInvoked: (didPop) async => await onWillPop().catchError(
            (error) {
              if (kDebugMode) {
                print(
                  'error ===>> onWillPop: $error',
                );
              }
              return false;
            },
          ),
          child: Stack(
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
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Get.back(
                          result: true); // ส่งค่า true กลับไปยังหน้า Profile
                    },
                  ),
                ),
                body: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Expanded(
                        child: Obx(
                          () {
                            if (chatController.messages.isEmpty) {
                              // Future.delayed(
                              //   Duration(seconds: 2),
                              //   () {
                              //     if (!sadsa) {
                              //       chatController.sendWelcomeMessage();
                              //       sadsa = true;
                              //     }
                              //   },
                              // );
                            }

                            filteredMessages = chatController.messages;
                            //     chatController.messages.where((message) {
                            //   return message.idCard == chatController.idcard.value;
                            // }).toList();

                            // print('dsdsds${filteredMessages}');
                            // for (var message in filteredMessages) {
                            //   print('Message: ${message.createdAt}');
                            // }
                            // filteredMessages =
                            //    chatController.messages.reversed.toList();

                            // return ListView.builder(
                            //   reverse: true,
                            //   itemCount: filteredMessages.length,
                            //   itemBuilder: (context, index) {
                            //     var element = filteredMessages[index];
                            //     return chatList(element, index);
                            //   },
                            // );

                            return GroupedListView<dynamic, String>(
                              // shrinkWrap: true,
                              reverse: true,
                              floatingHeader: true,
                              order: GroupedListOrder.DESC,
                              itemComparator: (element1, element2) {
                                DateTime dateTimeA =
                                    DateTime.parse(element1.createdAt);
                                DateTime dateTimeB =
                                    DateTime.parse(element2.createdAt);

                                return dateTimeA.compareTo(dateTimeB);
                              },
                              elements: filteredMessages,
                              groupBy: (element) {
                                return element.createdAt
                                    .toString()
                                    .substring(0, 10);
                                // ตรวจสอบว่าค่า createdAt เป็น null หรือไม่
                                if (element.createdAt != null) {
                                  DateTime dateTime =
                                      DateTime.parse(element.createdAt);
                                  return DateFormat("yyyy-MM-dd")
                                      .format(dateTime);
                                } else {
                                  // ถ้า createdAt เป็น null ส่งค่าที่กำหนดกลับไปแทน
                                  return "Unknown Date"; // ต้องเป็น String
                                }
                              },
                              padding: const EdgeInsets.only(top: 16),
                              itemBuilder: (context, element) {
                                int index = filteredMessages.indexOf(element);
                                return chatList(element, index);
                              },
                              groupHeaderBuilder: (element) {
                                if (element.createdAt != null) {
                                  DateTime dateTime =
                                      DateTime.parse(element.createdAt);
                                  String dateFormat =
                                      DateFormat("yyyy-MM-dd").format(dateTime);
                                  String formattedDate =
                                      ChatDateFormatter.formatDate(dateFormat);
                                  return Center(
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                        vertical: 14.h,
                                      ),
                                      child: Text(
                                        formattedDate,
                                        style: TextStyle(
                                          fontSize:
                                              MyConstant.setMediaQueryWidth(
                                            context,
                                            22,
                                          ),
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF103533),
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  return Center(
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                        vertical: 14.h,
                                      ),
                                      child: Text(
                                        "Unknown Date",
                                        style: TextStyle(
                                          fontSize:
                                              MyConstant.setMediaQueryWidth(
                                            context,
                                            22,
                                          ),
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF103533),
                                        ),
                                      ),
                                    ),
                                  );
                                }
                              },
                              groupSeparatorBuilder: (String groupValue) {
                                if (groupValue.isNotEmpty) {
                                  String formattedDate =
                                      ChatDateFormatter.formatDate(groupValue);
                                  return Center(
                                    child: Text(formattedDate),
                                  );
                                } else {
                                  return const Center(
                                    child: SizedBox.shrink(),
                                  );
                                }
                              },
                            );
                          },
                        ),
                      ),
                      //ในส่วนแป้นพิม ส่งข้่อความ
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 20,
                          left: 10,
                          right: 10,
                          bottom: 20,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Row(
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.image,
                                  size: 25,
                                  color: Color.fromARGB(255, 29, 105, 101),
                                ),
                                onPressed: _pickImages,
                              ),
                              Expanded(
                                child: Container(
                                  constraints:
                                      const BoxConstraints(maxHeight: 150),
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
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.send,
                                  color: Color.fromARGB(255, 29, 105, 101),
                                ),
                                onPressed: () {
                                  if (chatController
                                      .messageController.value.text
                                      .trim()
                                      .isEmpty) {
                                    return;
                                  }
                                  var message = ChatMessage(
                                    sender: chatController.name.value,
                                    message: chatController
                                        .messageController.value.text,
                                    receiver: 'admin',
                                    type: 'text',
                                    statusRead: 'SU',
                                    statusConnect: 'N',
                                    idCard: chatController.idcard.value,
                                    role: 'user',
                                    statusEnd: 'N',
                                  );
                                  if (kDebugMode) {
                                    print(
                                        'Sending message: ${message.message}');
                                  }
                                  chatController.sendMessage(message);
                                  // chatController.updateStatusRead();
                                  // chatController.setMessageV2();
                                  chatController.messageController.value
                                      .clear();
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
          ),
        ),
      ),
    );
  }

  Widget chatList(ChatMessage message, int index) {
    return Column(
      crossAxisAlignment: message.role == 'user' &&
              message.idCard == chatController.idcard.value
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        if (message.role != 'user')
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
            ? Column(
                children: [
                  Column(
                    crossAxisAlignment: message.role == 'user' &&
                            message.idCard == chatController.idcard.value
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          top: 10,
                          // bottom: index == filteredMessages.length - 1 ? 30 : 5,
                          left: message.role == 'user' ? 80 : 15,
                          right: message.role == 'user' ? 15 : 80,
                          bottom: 5,
                        ),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: message.role == 'user'
                              ? Color(0xFF0084FF)
                              : Colors.grey[200],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Text(
                              message.message ?? '',
                              style: TextStyle(
                                fontSize: MyConstant.setMediaQueryWidth(
                                  context,
                                  20,
                                ),
                                color: message.role == 'user'
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 20.w,
                        ),
                        child: Row(
                          mainAxisAlignment: message.role == 'user' &&
                                  message.idCard == chatController.idcard.value
                              ? MainAxisAlignment.end
                              : MainAxisAlignment.start,
                          children: [
                            if (message.statusRead == 'RU' ||
                                message.statusRead == 'RA')
                              Text('อ่านแล้ว')
                            else if (message.statusRead == 'SU' ||
                                message.statusRead == 'SA')
                              SizedBox.shrink(),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              message.createdAt != null
                                  ? DateFormat('HH:mm:ss').format(
                                      DateTime.parse(message.createdAt!).add(
                                        const Duration(hours: 7),
                                      ),
                                    )
                                  : 'Invalid Date',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              )
            : message.image != null && message.image!.isNotEmpty
                ? Container(
                    margin: EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                      left: message.role == 'user' ? 80 : 15,
                      right: message.role == 'user' ? 15 : 80,
                    ),
                    child: Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      alignment: WrapAlignment.center,
                      children: [
                        ...message.image!.map((fileUrl) {
                          String fileName = path.basename(fileUrl);
                          bool isImage = ['jpg', 'jpeg', 'png', 'gif']
                              .contains(fileUrl.split('.').last);
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
                                            child: PhotoView(
                                              imageProvider:
                                                  NetworkImage(fileUrl),
                                            ),
                                          ),
                                          Positioned(
                                            top: 20,
                                            right: 10,
                                            child: Row(
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      10,
                                                    ),
                                                    color: Colors.grey.shade300
                                                        .withOpacity(.2),
                                                  ),
                                                  child: IconButton(
                                                    icon: const Icon(
                                                      Icons.download,
                                                      color: Colors.white,
                                                      size: 30,
                                                    ),
                                                    onPressed: () async {
                                                      await dowloadImage(
                                                          fileUrl);
                                                      // Get.dialog(widget)
                                                      showDialog(
                                                        // ignore: use_build_context_synchronously
                                                        context: context,
                                                        builder: (context) {
                                                          return AlertDialog(
                                                            content: SizedBox(
                                                              height: MyConstant
                                                                  .setMediaQueryWidth(
                                                                      context,
                                                                      340),
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Image.asset(
                                                                    'assets/image/success.png',
                                                                    height:
                                                                        50.h,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                  SizedBox(
                                                                    height:
                                                                        20.h,
                                                                  ),
                                                                  Text(
                                                                    "สำเร็จ",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          30.sp,
                                                                      color: Color(
                                                                          0xFF103533),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height:
                                                                        10.h,
                                                                  ),
                                                                  Text(
                                                                    "บันทึกรูปภาพสำเร็จ",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          19.sp,
                                                                      color: Colors
                                                                          .grey
                                                                          .shade500,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height:
                                                                        20.h,
                                                                  ),
                                                                  Center(
                                                                    child:
                                                                        TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              Color(0xFF103533),
                                                                          borderRadius:
                                                                              BorderRadius.circular(5),
                                                                        ),
                                                                        child:
                                                                            Padding(
                                                                          padding: const EdgeInsets
                                                                              .all(
                                                                              8),
                                                                          child:
                                                                              Icon(
                                                                            Icons.close,
                                                                            size:
                                                                                20.h,
                                                                            color:
                                                                                Colors.white,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    },
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                IconButton(
                                                  icon: const Icon(
                                                    Icons.close,
                                                    color: Colors.white,
                                                    size: 40,
                                                  ),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              },
                              child: Column(
                                crossAxisAlignment: message.role == 'user' &&
                                        message.idCard ==
                                            chatController.idcard.value
                                    ? CrossAxisAlignment.end
                                    : CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: MyConstant.setMediaQueryWidth(
                                        context, 150),
                                    height: MyConstant.setMediaQueryHeight(
                                        context, 120),
                                    clipBehavior: Clip.hardEdge,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey.shade300,
                                          width: 1.0),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Image.network(
                                      fileUrl,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              const Icon(Icons.error,
                                                  color: Colors.red),
                                    ),
                                  ),
                                  Align(
                                    alignment: message.role == 'user' &&
                                            message.idCard ==
                                                chatController.idcard.value
                                        ? Alignment.centerRight
                                        : Alignment.centerLeft,
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                        horizontal: 8.w,
                                      ),
                                      child: Row(
                                        mainAxisAlignment: message.role ==
                                                    'user' &&
                                                message.idCard ==
                                                    chatController.idcard.value
                                            ? MainAxisAlignment.end
                                            : MainAxisAlignment.start,
                                        children: [
                                          if (message.statusRead == 'RU' ||
                                              message.statusRead == 'RA')
                                            Text('อ่านแล้ว')
                                          else if (message.statusRead == 'SU' ||
                                              message.statusRead == 'SA')
                                            SizedBox.shrink(),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            message.createdAt != null
                                                ? DateFormat('HH:mm:ss').format(
                                                    DateTime.parse(
                                                            message.createdAt!)
                                                        .add(
                                                      const Duration(hours: 7),
                                                    ),
                                                  )
                                                : 'Invalid Date',
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                          return InkWell(
                            onTap: () async {
                              if (await canLaunch(fileUrl)) {
                                await launch(fileUrl);
                              } else {
                                throw 'Could not launch $fileUrl';
                              }
                            },
                            child: Column(
                              crossAxisAlignment: message.role == 'user' &&
                                      message.idCard ==
                                          chatController.idcard.value
                                  ? CrossAxisAlignment.end
                                  : CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey.shade300,
                                        width: 1.0),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.picture_as_pdf,
                                          color: Colors.red),
                                      SizedBox(width: 8),
                                      Text(fileName),
                                    ],
                                  ),
                                ),
                                Align(
                                  alignment: message.role == 'user' &&
                                          message.idCard ==
                                              chatController.idcard.value
                                      ? Alignment.centerRight
                                      : Alignment.centerLeft,
                                  child: Container(
                                    margin: EdgeInsets.symmetric(
                                      horizontal: 8.w,
                                    ),
                                    child: Row(
                                      mainAxisAlignment: message.role ==
                                                  'user' &&
                                              message.idCard ==
                                                  chatController.idcard.value
                                          ? MainAxisAlignment.end
                                          : MainAxisAlignment.start,
                                      children: [
                                        if (message.statusRead == 'RU' ||
                                            message.statusRead == 'RA')
                                          Text('อ่านแล้ว')
                                        else if (message.statusRead == 'SU' ||
                                            message.statusRead == 'SA')
                                          SizedBox.shrink(),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          message.createdAt != null
                                              ? DateFormat('HH:mm').format(
                                                  DateTime.parse(
                                                          message.createdAt!)
                                                      .add(
                                                    const Duration(hours: 7),
                                                  ),
                                                )
                                              : 'Invalid Date',
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList()
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
      ],
    );
  }
}
