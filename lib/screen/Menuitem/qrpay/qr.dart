import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:mobile_chaseapp/component/bottombar.dart';
import 'package:mobile_chaseapp/utils/my_constant.dart';
import 'package:mobile_chaseapp/utils/permission/permission_handler.dart';
import 'package:mobile_chaseapp/utils/responsive_heigth__context.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class QRPayment extends StatefulWidget {
  const QRPayment({
    super.key,
    required this.amount,
    required this.customerId,
    required this.psersonalId,
    required this.taxId,
  });

  final String amount;
  final String customerId;
  final String psersonalId;
  final String taxId;

  @override
  State<QRPayment> createState() => _QRPaymentState();
}

class _QRPaymentState extends State<QRPayment> {
  // final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //     FlutterLocalNotificationsPlugin();

  ScreenshotController screenshotController = ScreenshotController();
  String paymentData = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    //ทำ gent qr code
    String data = "|${widget.taxId}"
        "00"
        "\n${widget.customerId}\n${widget.psersonalId}\n${widget.amount}"
        "00";
    //ทำ gent qr code
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // backgroundColor: const Color(0xFF395D5D),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Container(
              height: 380.h + kToolbarHeight,
              decoration: const BoxDecoration(
                color: Color(0xFF395D5D),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 50.h,
                      left: 30.w,
                    ),
                    child: bar(),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Container(
                    width: MyConstant.setMediaQueryWidth(context, 210),
                    height: MyConstant.setMediaQueryWidth(context, 210),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Screenshot(
                          controller: screenshotController,
                          child: Container(
                            color: Colors.white,
                            child: QrImageView(
                              data: data,
                              version: QrVersions.auto,
                              dataModuleStyle: const QrDataModuleStyle(
                                color: Colors.black,
                                dataModuleShape: QrDataModuleShape.square,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      // await Permission.photos.request();
                      final isGranted =
                          await PermissionHandler.requestStoragePermission();

                      if (isGranted) {
                        final isSave = await _captureAndSaveScreen();

                        if (isSave) {
                          // ignore: use_build_context_synchronously
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: SizedBox(
                                  height: MyConstant.setMediaQueryWidth(
                                      context, 340),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/image/success.png',
                                        height: 50.h,
                                        fit: BoxFit.cover,
                                      ),
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      Text(
                                        "สำเร็จ",
                                        style: TextStyle(
                                          fontSize: 30.sp,
                                          color: Color(0xFF103533),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Text(
                                        "บันทึกรูปภาพสำเร็จ",
                                        style: TextStyle(
                                          fontSize: 19.sp,
                                          color: Colors.grey.shade500,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      Center(
                                        child: TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Color(0xFF103533),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(8),
                                              child: Icon(
                                                Icons.close,
                                                size: 20.h,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // actions: [
                                //   Navigator.of(context).pop();
                                // ],
                              );
                            },
                          );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(
                        220.w,
                        MyConstant.setMediaQueryWidth(context, 40),
                      ),
                      backgroundColor: Color.fromARGB(13, 255, 255, 255),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'บันทึกคิวอาร์โค้ด',
                      style: TextStyle(
                          fontSize: 19.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    'ยอดชำระจะมีผลภายใน 2 วันทำการ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  SizedBox(
                    height: 15.h,
                  ),
                  Text(
                    'ขั้นตอนการชำระเงิน',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '• กดปุ่มบันทึก QR Code',
                          style: TextStyle(
                            fontSize: 19.sp,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          '• QR Code จะถูกบันทึกที่คลังรูปภาพ',
                          style: TextStyle(
                            fontSize: 19.sp,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          '• นำ QR Code แสกนจ่ายได้ทุกแอพธนาคาร',
                          style: TextStyle(
                            fontSize: 19.sp,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 30,
              ).h,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Bottombar(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(
                    width * 0.8,
                    MyConstant.setMediaQueryWidth(context, 40),
                  ),
                  backgroundColor: const Color(0xFF103533),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'กลับสู่หน้าหลัก',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: MyConstant.setMediaQueryWidth(context, 25),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget bar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 38.w,
          height: 35.h,
          decoration: const BoxDecoration(
            color: Color(0x0DFFFFFF),
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              size: MyConstant.setMediaQueryWidth(context, 23),
              color: Colors.white,
            ),
          ),
        ),
        Text(
          'QR Code ชำระเงิน',
          style: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
        SizedBox(
          width: 80.w,
        )
      ],
    );
  }

  Future<bool> _captureAndSaveScreen() async {
    final capturedImage = await screenshotController.capture();

    if (capturedImage != null) {
      final isSave = await _saveImageToGallery(capturedImage);
      return isSave;
      // _showNotification();
    } else {
      print('Failed to capture image.');
      return false;
    }
  }

  Future<bool> _saveImageToGallery(Uint8List imageBytes) async {
    final result = await ImageGallerySaver.saveImage(imageBytes);

    if (result['isSuccess']) {
      print('Image saved to gallery.');
      return true;
    } else {
      return false;
      print('Failed to save image: ${result['error']}');
    }
  }
}
