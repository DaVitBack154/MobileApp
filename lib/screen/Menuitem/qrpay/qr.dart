import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:mobile_chaseapp/component/bottombar.dart';
import 'package:mobile_chaseapp/controller/userpay_controller.dart';
import 'package:mobile_chaseapp/model/respon_payuser.dart';
import 'package:mobile_chaseapp/utils/my_constant.dart';
import 'package:mobile_chaseapp/utils/permission/permission_handler.dart';
import 'package:mobile_chaseapp/utils/responsive_heigth__context.dart';
import 'package:mobile_chaseapp/utils/responsive_width__context.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';

class QRPayment extends StatefulWidget {
  const QRPayment({
    super.key,
    required this.amount,
    required this.customerId,
    required this.psersonalId,
    required this.taxId,
    //เพิ่มสาม
    required this.tCustomerName,
    required this.tCustomerSurname,
    required this.companyId,
  });

  final String amount;
  final String customerId;
  final String psersonalId;
  final String taxId;
  final String tCustomerName;
  final String tCustomerSurname;
  final String companyId;

  @override
  State<QRPayment> createState() => _QRPaymentState();
}

class _QRPaymentState extends State<QRPayment> {
  ScreenshotController screenshotController = ScreenshotController();
  String paymentData = "";
  UserPayController userPayController = UserPayController();

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
    return MediaQuery.withClampedTextScaling(
      minScaleFactor: 1,
      maxScaleFactor: 1,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          // backgroundColor: const Color(0xFF395D5D),
          body: Screenshot(
            controller: screenshotController,
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  Container(
                    height: ResponsiveWidthContext.isTablet(context) ||
                            ResponsiveWidthContext.isTablet11(context) ||
                            ResponsiveWidthContext.isTabletMini(context)
                        ? 435.h + kToolbarHeight
                        : ResponsiveWidthContext.isMobileFoldVertical(context)
                            ? 405.h + kToolbarHeight
                            : 405.h + kToolbarHeight,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/image/bg.png'),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: ResponsiveWidthContext.isTablet(context) ||
                                    ResponsiveWidthContext.isTablet11(context)
                                ? 20.h
                                : ResponsiveWidthContext.isMobileFoldVertical(
                                        context)
                                    ? 34.h
                                    : 50.h,
                            left: 20.w,
                          ),
                          child: bar(),
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 32.w,
                          ),
                          child: Container(
                            width: width,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromRGBO(
                                      0, 0, 0, 0.20), // สีของเงา (RGBA)
                                  offset: Offset(
                                      0, 1), // การเยื้องเงาในแนวแกน X และ Y
                                  blurRadius: 4, // ความคมของเงา
                                ),
                              ],
                            ),
                            child: Center(
                              child: Column(
                                children: [
                                  widget.companyId == 'CFAA'
                                      ? Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Text(
                                            'CF Asia Asset Management Co., Ltd.',
                                            style: TextStyle(
                                              fontSize:
                                                  MyConstant.setMediaQueryWidth(
                                                      context, 22),
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF103533),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        )
                                      : widget.companyId == 'RWAY'
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10),
                                              child: Text(
                                                'Resolution Way Co., Ltd.',
                                                style: TextStyle(
                                                  fontSize: MyConstant
                                                      .setMediaQueryWidth(
                                                          context, 22),
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xFF103533),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            )
                                          : Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10),
                                              child: Text(
                                                'Courts Megastore (Thailand) Co., Ltd.',
                                                style: TextStyle(
                                                  fontSize: MyConstant
                                                      .setMediaQueryWidth(
                                                          context, 22),
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xFF103533),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                    ),
                                    child: Container(
                                      child: const DottedLine(
                                        direction: Axis.horizontal,
                                        lineLength:
                                            double.infinity, // ความยาวของเส้น
                                        lineThickness: 2.0, // ความหนาของเส้น
                                        dashLength: 4.0, // ความยาวของแต่ละจุด
                                        dashColor: Color.fromARGB(
                                            255, 246, 165, 3), // สีของเส้น
                                        dashGapLength:
                                            5.0, // ช่องว่างระหว่างจุด
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  SizedBox(
                                    width: MyConstant.setMediaQueryWidth(
                                        context, 200),
                                    child: QrImageView(
                                      data: data,
                                      version: QrVersions.auto,
                                      dataModuleStyle: const QrDataModuleStyle(
                                        color: Colors.black,
                                        dataModuleShape:
                                            QrDataModuleShape.square,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'เลขที่สัญญา : ',
                                        style: TextStyle(
                                          fontSize:
                                              MyConstant.setMediaQueryWidth(
                                                  context, 22),
                                          fontWeight: FontWeight.normal,
                                          color: Color(0xFF5C5C5C),
                                          //color: Colors.grey.shade600,
                                        ),
                                      ),
                                      Text(
                                        widget.customerId,
                                        style: TextStyle(
                                          fontSize:
                                              MyConstant.setMediaQueryWidth(
                                                  context, 20),
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'ชื่อ-นามสกุล : ',
                                        style: TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          fontSize:
                                              MyConstant.setMediaQueryWidth(
                                                  context, 22),
                                          fontWeight: FontWeight.normal,

                                          color: Color(0xFF5C5C5C),
                                          //color: Colors.grey.shade600,
                                        ),
                                      ),
                                      Text(
                                        widget.tCustomerName,
                                        style: TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          fontSize:
                                              MyConstant.setMediaQueryWidth(
                                                  context, 20),
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      Text(
                                        widget.tCustomerSurname,
                                        style: TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          fontSize:
                                              MyConstant.setMediaQueryWidth(
                                                  context, 20),
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            // ตรงส่วนนี้ call api เพื่อส่งไปยังเว็บแอดมิน
                            Payuser? payuser =
                                await userPayController.createUserPay(
                              customerId: widget.customerId,
                              idCard: widget.psersonalId,
                              name: widget.tCustomerName,
                              surname: widget.tCustomerSurname,
                              company: widget.companyId,
                              status: 'บันทึกคิวอาร์โคด',
                            );

                            if (payuser != null && payuser.data != null) {
                              Data data = payuser.data;
                              // แสดงข้อมูลที่ต้องการจาก data
                              print(
                                  'บันทึกข้อมูลผู้ใช้สำเร็จ: ${data.name} ${data.surname}');
                            } else {
                              print('กรุณากรอกข้อมูลที่อยู่ให้ถูกต้อง');
                            }

                            final isGranted = await PermissionHandler
                                .requestStoragePermission();

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
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(8),
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
                              240.w,
                              20.h,
                            ),
                            backgroundColor: Color.fromARGB(255, 19, 96, 92),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            'บันทึกคิวอาร์โค้ด',
                            style: TextStyle(
                                fontSize:
                                    MyConstant.setMediaQueryWidth(context, 22),
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          'ยอดชำระจะมีผลภายใน 2 วันทำการ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize:
                                MyConstant.setMediaQueryWidth(context, 22),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          'ขั้นตอนการชำระเงิน',
                          style: TextStyle(
                            fontSize:
                                MyConstant.setMediaQueryWidth(context, 24),
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
                                  fontSize: 20.sp,
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                '• QR Code จะถูกบันทึกที่คลังรูปภาพ',
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                '• นำ QR Code สแกนจ่ายได้ทุกแอพธนาคาร',
                                style: TextStyle(
                                  fontSize: 20.sp,
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
                    padding: EdgeInsets.only(
                        bottom:
                            ResponsiveWidthContext.isMobileFoldVertical(context)
                                ? 15
                                : 30),
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
          ),
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
          width: 60.w,
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
