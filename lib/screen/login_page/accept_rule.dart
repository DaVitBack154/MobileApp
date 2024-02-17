// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_chaseapp/screen/login_page/register_page.dart';
import 'package:mobile_chaseapp/utils/my_constant.dart';
import 'package:mobile_chaseapp/utils/responsive_heigth__context.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../config/app_info.dart';

class Accept_rule extends StatefulWidget {
  const Accept_rule({super.key});

  @override
  State<Accept_rule> createState() => _Accept_ruleState();
}

class _Accept_ruleState extends State<Accept_rule> {
  bool? isCheckbox = false;
  String currentYomrub1 = 'ยินยอม';
  String currentYomrub2 = 'ยินยอม';
  String currentYomrub3 = 'ยินยอม';
  String currentYomrub4 = 'ยินยอม';
  String currentYomrub5 = 'ยินยอม';

  Future<void> openlaunchUrl(Uri url) async {
    if (mounted) {
      if (await canLaunchUrl(url)
          .timeout(
        const Duration(seconds: 20),
      )
          .catchError(
        (error) {
          if (kDebugMode) {
            print(
              'error ===>> $error',
            );
          }
          return false;
        },
      )) {
        if (!await launchUrl(url)
            .timeout(
          const Duration(seconds: 20),
        )
            .catchError(
          (error) {
            if (kDebugMode) {
              print(
                'error ===>> $error',
              );
            }
            return false;
          },
        )) {
          if (kDebugMode) {
            print(
              'Could not launch $url',
            );
          }
        }
      } else {
        if (kDebugMode) {
          print(
            'Could not launch $url',
          );
        }
      }
    }
  }

  Future<void> openlaunchUrlAppOther(String url) async {
    if (mounted) {
      // ignore: deprecated_member_use
      if (await canLaunch(url)
          .timeout(
        const Duration(seconds: 20),
      )
          .catchError(
        (error) {
          if (kDebugMode) {
            print(
              'error ===>> $error',
            );
          }
          return false;
        },
      )) {
        // ignore: deprecated_member_use
        if (!await launch(url)
            .timeout(
          const Duration(seconds: 20),
        )
            .catchError(
          (error) {
            if (kDebugMode) {
              print(
                'error ===>> $error',
              );
            }
            return false;
          },
        )) {
          if (kDebugMode) {
            print(
              'Could not launch $url',
            );
          }
        }
      } else {
        if (kDebugMode) {
          print(
            'Could not launch $url',
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final query = MediaQuery.of(context);
    return MediaQuery(
        data: query.copyWith(
          // ignore: deprecated_member_use
          textScaler: TextScaler.linear(query.textScaleFactor.clamp(1.0, 1.0)),
        ),
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'ข้อกำหนดและเงื่อนไข',
              style: TextStyle(
                  fontSize: MyConstant.setMediaQueryWidth(context, 20)),
            ),
            backgroundColor: Color(0xFF103533),
            foregroundColor: Colors.white,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  child: textOne(),
                ),
              ],
            ),
          ),
        )

        // Scaffold(
        //   body: Stack(
        //     children: [
        //       Column(
        //         children: [
        //           Container(
        //             width: double.infinity,
        //             padding:
        //                 EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
        //             height: 100.h + kToolbarHeight,
        //             decoration: const BoxDecoration(
        //               image: DecorationImage(
        //                 image: AssetImage('assets/image/bgpin.jpg'),
        //                 fit: BoxFit.cover,
        //                 alignment: Alignment.topCenter,
        //               ),
        //             ),
        //             child: Row(
        //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //               children: [
        //                 Container(
        //                   decoration: BoxDecoration(
        //                     borderRadius: BorderRadius.circular(15),
        //                     color: Colors.black.withOpacity(.1),
        //                   ),
        //                   child: IconButton(
        //                     icon: const Icon(
        //                       Icons.arrow_back_ios_new_outlined,
        //                       size: 23,
        //                       color: Colors.white,
        //                     ),
        //                     onPressed: () {
        //                       Navigator.pop(context);
        //                     },
        //                   ),
        //                 ),
        //                 Container(
        //                   margin: EdgeInsets.only(
        //                     right: 30.w,
        //                   ),
        //                   child: Text(
        //                     'ข้อกำหนดและเงื่อนไข',
        //                     style: TextStyle(
        //                       fontSize: 25,
        //                       fontWeight: FontWeight.w500,
        //                     ),
        //                   ),
        //                 ),
        //                 SizedBox.shrink(),
        //               ],
        //             ),
        //           ),
        //         ],
        //       ),
        //       Container(
        //         margin: const EdgeInsets.only(top: kToolbarHeight + 70).h,
        //         width: double.infinity,
        //         padding: EdgeInsets.symmetric(horizontal: 15.w),
        //         decoration: BoxDecoration(
        //           color: Color(0xfff395d5d),
        //           borderRadius: BorderRadius.only(
        //             topLeft: Radius.circular(20),
        //             topRight: Radius.circular(20),
        //           ),
        //         ),
        //         child: Container(
        //           child: Column(
        //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: [
        //               Container(
        //                 child: SingleChildScrollView(
        //                   child: Column(
        //                     children: [
        //                       Align(
        //                         alignment: Alignment.center,
        //                         child: Text(
        //                           AppInfo.termsAndConditions,
        //                           style: TextStyle(
        //                             fontWeight: FontWeight.w500,
        //                             color: Colors.white,
        //                             fontSize: 16.sp,
        //                             letterSpacing: 1.2.w,
        //                           ),
        //                         ),
        //                       ),
        //                     ],
        //                   ),
        //                 ),
        //               ),
        //               Row(
        //                 mainAxisAlignment: MainAxisAlignment.start,
        //                 children: [
        //                   Checkbox(
        //                     value: isCheckbox,
        //                     onChanged: (newBool) {
        //                       setState(() {
        //                         isCheckbox = newBool;
        //                       });
        //                     },
        //                     fillColor: MaterialStateColor.resolveWith(
        //                       (states) =>
        //                           isCheckbox! ? Colors.blue : Colors.white,
        //                     ),
        //                     activeColor: Colors
        //                         .blue, // เปลี่ยนเส้น Checkbox เป็นสีฟ้าเมื่อถูกเลือก
        //                     checkColor: Colors.white,
        //                   ),
        //                   Text(
        //                     'ยินยอมข้อมูลส่วนบุคคล',
        //                     style: TextStyle(
        //                       fontSize: 20,
        //                       fontWeight: FontWeight.w400,
        //                       color: Colors.white,
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //               ElevatedButton(
        //                 onPressed: () async {
        //                   if (isCheckbox == true) {
        //                     // เช็กว่า Checkbox ถูกเลือกหรือไม่
        //                     Navigator.push(
        //                       context,
        //                       MaterialPageRoute(
        //                         builder: (context) => RegisterPage(),
        //                       ),
        //                     );
        //                   } else {
        //                     // แสดง SnackBar หรือข้อความเตือนให้ผู้ใช้เลือกยินยอมก่อน
        //                     ScaffoldMessenger.of(context).showSnackBar(
        //                       SnackBar(
        //                         content: Center(
        //                           child: Text(
        //                             'กรุณายินยอมข้อมูลส่วนบุคคลก่อนกดถัดไป',
        //                             style: TextStyle(
        //                                 color: Colors.white), // กำหนดสีข้อความ
        //                           ),
        //                         ),
        //                         backgroundColor:
        //                             Colors.red, // กำหนดสีพื้นหลังของ SnackBar
        //                       ),
        //                     );
        //                   }
        //                 },
        //                 style: ButtonStyle(
        //                   fixedSize: MaterialStateProperty.all<Size>(
        //                     Size(width, 40),
        //                   ),
        //                   backgroundColor: MaterialStateProperty.all<Color>(
        //                     Color.fromARGB(
        //                         255, 236, 237, 237), // กำหนดสีพื้นหลังของปุ่ม
        //                   ),
        //                 ),
        //                 child: Text(
        //                   'ถัดไป',
        //                   style: TextStyle(
        //                     fontSize: 22.sp,
        //                     fontWeight: FontWeight.w500,
        //                     color: Color(0xFF103533),
        //                   ),
        //                 ),
        //               ),
        //             ],
        //           ),
        //         ),
        //       )
        //     ],
        //   ),
        // ),

        );
  }

  Widget textOne() {
    double width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 15.h,
          ),
          Text(
            'ความยินยอม',
            style: TextStyle(
              fontSize: MyConstant.setMediaQueryWidth(context, 30),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 15.h,
            ),
            child: Column(
              children: [
                Text(
                  'ข้าพเจ้าขอแสดงเจตนายินยอมให้บริษัท เชฎฐ์ เอเชีย จำกัด(มหาชน) และ บริษัทในเครือ ซึ่งประกอบด้วยบริษัท รีโซลูชั่นเวย์ จำกัด บริษัท บริหารสินทรัพย์ ซีเอฟ เอเชีย จำกัด และบริษัท คอร์ทส์ เม็กก้าสโตร์ (ประเทศไทย) จำกัด (รวมเรียกว่า “บริษัทฯ”) ในการเก็บรวบรวม ใช้ และเปิดเผยข้อมูลส่วนบุคคลของข้าพเจ้า เพื่อวัตถุประสงค์ดังนี้',
                  style: TextStyle(
                    fontSize: MyConstant.setMediaQueryWidth(context, 23),
                  ),
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  '1. เพื่อแจ้งข้อมูลสิทธิพิเศษ ให้ท่านได้รับสิทธิประโยชน์จากข้อมูลข่าวสารสำคัญ โปรโมชั่น การประชาสัมพันธ์ และการนำเสนอข้อมูลผลิตภัณฑ์หรือบริการ',
                  style: TextStyle(
                    fontSize: MyConstant.setMediaQueryWidth(context, 23),
                  ),
                  textAlign: TextAlign.start,
                ),
                Row(
                  children: [
                    Radio(
                      value: 'ยินยอม',
                      groupValue: currentYomrub1,
                      onChanged: (value) {
                        setState(() {
                          currentYomrub1 = value!;
                        });
                      },
                      activeColor: Colors.teal.shade700,
                    ),
                    Text(
                      "ยินยอม",
                      style: TextStyle(
                          fontSize: MyConstant.setMediaQueryWidth(context, 23),
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Radio(
                      value: 'ไม่ยินยอม',
                      groupValue: currentYomrub1,
                      onChanged: (value) {
                        setState(() {
                          currentYomrub1 = value!;
                        });
                      },
                      activeColor: Colors.teal.shade700,
                    ),
                    Text(
                      "ไม่ยินยอม",
                      style: TextStyle(
                          fontSize: MyConstant.setMediaQueryWidth(context, 23),
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Text(
                  '2. เพื่อใช้สำหรับธุรกิจวิเคราะห์ข้อมูลส่วนบุคคล (Data analytics business)การวิเคราะห์ข้อมูลส่วนบุคคลของท่าน โดยบริษัทฯ เพื่อปรับปรุงและพัฒนาประสิทธิภาพในการให้บริการ',
                  style: TextStyle(
                    fontSize: MyConstant.setMediaQueryWidth(context, 23),
                  ),
                  textAlign: TextAlign.start,
                ),
                Row(
                  children: [
                    Radio(
                      value: "ยินยอม",
                      groupValue: currentYomrub2,
                      onChanged: (value) {
                        setState(() {
                          currentYomrub2 = value!;
                        });
                      },
                      activeColor: Colors.teal.shade700,
                    ),
                    Text(
                      "ยินยอม",
                      style: TextStyle(
                          fontSize: MyConstant.setMediaQueryWidth(context, 23),
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Radio(
                      value: "ไม่ยินยอม",
                      groupValue: currentYomrub2,
                      onChanged: (value) {
                        setState(() {
                          currentYomrub2 = value!;
                        });
                      },
                      activeColor: Colors.teal.shade700,
                    ),
                    Text(
                      "ไม่ยินยอม",
                      style: TextStyle(
                          fontSize: MyConstant.setMediaQueryWidth(context, 23),
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Text(
                  '3. เพื่อใช้สำหรับการยืนยันตัวตน กรณีที่เอกสารระบุตัวตนของท่าน เช่น บัตรประชาชน หนังสือเดินทาง หรือเอกสารอื่นใดที่ออกโดยหน่วยงานราชการซึ่งมีข้อมูลส่วนบุคคลที่มีความอ่อนไหว (Sensitive data) เช่น เชื้อชาติ ศาสนา โดยบริษัทฯ จะไม่นำข้อมูลดังกล่าวไปใช้เพื่อวัตถุประสงค์อื่น และคำนึงถึงความปลอดภัยของข้อมูลท่านเป็นสำคัญ',
                  style: TextStyle(
                    fontSize: MyConstant.setMediaQueryWidth(context, 23),
                  ),
                  textAlign: TextAlign.start,
                ),
                Row(
                  children: [
                    Radio(
                      value: "ยินยอม",
                      groupValue: currentYomrub3,
                      onChanged: (value) {
                        setState(() {
                          currentYomrub3 = value!;
                        });
                      },
                      activeColor: Colors.teal.shade700,
                    ),
                    Text(
                      "ยินยอม",
                      style: TextStyle(
                          fontSize: MyConstant.setMediaQueryWidth(context, 23),
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Radio(
                      value: "ไม่ยินยอม",
                      groupValue: currentYomrub3,
                      onChanged: (value) {
                        setState(() {
                          currentYomrub3 = value!;
                        });
                      },
                      activeColor: Colors.teal.shade700,
                    ),
                    Text(
                      "ไม่ยินยอม",
                      style: TextStyle(
                          fontSize: MyConstant.setMediaQueryWidth(context, 23),
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Text(
                  '4. เพื่อใช้สำหรับการยอมรับเอกสารอิเล็กทรอนิกส์ กรณีนี้จะถือว่าท่านไม่ประสงค์ในการรับบริการจัดส่งเอกสาร เช่น ใบเสร็จรับเงิน ใบกำกับภาษี หรือเอกสารอื่น ๆ ในรูปแบบต้นฉบับเอกสาร (Hard Copy) โดยบริษัทฯ จะจัดส่งเอกสารให้แก่ท่านผ่านทางอีเมลซึ่งแจ้งไว้ในระบบ',
                  style: TextStyle(
                    fontSize: MyConstant.setMediaQueryWidth(context, 23),
                  ),
                  textAlign: TextAlign.start,
                ),
                Row(
                  children: [
                    Radio(
                      value: "ยินยอม",
                      groupValue: currentYomrub4,
                      onChanged: (value) {
                        setState(() {
                          currentYomrub4 = value!;
                        });
                      },
                      activeColor: Colors.teal.shade700,
                    ),
                    Text(
                      "ยินยอม",
                      style: TextStyle(
                          fontSize: MyConstant.setMediaQueryWidth(context, 23),
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Radio(
                      value: "ไม่ยินยอม",
                      groupValue: currentYomrub4,
                      onChanged: (value) {
                        setState(() {
                          currentYomrub4 = value!;
                        });
                      },
                      activeColor: Colors.teal.shade700,
                    ),
                    Text(
                      "ไม่ยินยอม",
                      style: TextStyle(
                          fontSize: MyConstant.setMediaQueryWidth(context, 23),
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Text(
                  '5. เพื่อใช้สำหรับการโอนข้อมูลส่วนบุคลไปต่างประเทศในบางกรณีที่บริษัทฯมีความจำเป็นต้องส่งหรือโอนข้อมูลส่วนบุคคลของท่านไปยังต่างประเทศเพื่อดำเนินการตามวัตถุประสงค์ในการให้บริการแก่ท่าน เช่น เพื่อส่งข้อมูลส่วนบุคคลไปยังระบบคลาวด์ (Cloud) ที่มีแพลตฟอร์มหรือเครื่องแม่ข่าย (Server) อยู่ต่างประเทศ เช่น ประเทศสิงคโปร์ หรือสหรัฐอเมริกา โดยบริษัทฯ ได้ดำเนินการตามหลักเกณฑ์การให้ความคุ้มครองข้อมูลส่วนบุคคลที่ส่งหรือโอนไปยังต่างประเทศที่คณะกรรมการคุ้มครองข้อมูลส่วนบุคคลประกาศกำหนด',
                  style: TextStyle(
                    fontSize: MyConstant.setMediaQueryWidth(context, 23),
                  ),
                  textAlign: TextAlign.start,
                ),
                Row(
                  children: [
                    Radio(
                      value: "ยินยอม",
                      groupValue: currentYomrub5,
                      onChanged: (value) {
                        setState(() {
                          currentYomrub5 = value!;
                        });
                      },
                      activeColor: Colors.teal.shade700,
                    ),
                    Text(
                      "ยินยอม",
                      style: TextStyle(
                          fontSize: MyConstant.setMediaQueryWidth(context, 23),
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Radio(
                      value: "ไม่ยินยอม",
                      groupValue: currentYomrub5,
                      onChanged: (value) {
                        setState(() {
                          currentYomrub5 = value!;
                        });
                      },
                      activeColor: Colors.teal.shade700,
                    ),
                    Text(
                      "ไม่ยินยอม",
                      style: TextStyle(
                          fontSize: MyConstant.setMediaQueryWidth(context, 23),
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  'ข้าพเจ้ายินยอมให้บริษัทฯ เก็บ รวบรวม ใช้ และเปิดเผยข้อมูลส่วนบุคคลของข้าพเจ้าตามวัตถุประสงค์ข้างต้น',
                  style: TextStyle(
                    fontSize: MyConstant.setMediaQueryWidth(context, 23),
                  ),
                  textAlign: TextAlign.start,
                ),
                Text(
                  'ข้าพเจ้าได้อ่านและเข้าใจในรายละเอียดเกี่ยวกับการเก็บ รวบรวม ใช้และเปิดเผยข้อมูลส่วนบุคคลของบริษัทฯตามที่ระบุในนโยบายคุ้มครองข้อมูลส่วนบุคคลรวมถึงประกาศความเป็นส่วนตัวที่เกี่ยวข้องแล้ว รายละเอียดตามที่ปรากฏในเว็บไซต์',
                  style: TextStyle(
                    fontSize: MyConstant.setMediaQueryWidth(context, 23),
                  ),
                  textAlign: TextAlign.justify,
                ),
                InkWell(
                  onTap: () {
                    if (mounted) {
                      openlaunchUrl(
                        Uri.parse(
                            'https://www.chase.co.th/th/corporate-governance/privacy-notice'),
                      ).catchError(
                        (error) {
                          if (kDebugMode) {
                            print(
                              'error ===>> $error',
                            );
                          }
                          return false;
                        },
                      );
                    }
                  },
                  child: Row(
                    children: [
                      Flexible(
                        child: Text(
                          'https://www.chase.co.th/th/corporate-governance/privacy-notice',
                          style: TextStyle(
                            fontSize:
                                MyConstant.setMediaQueryWidth(context, 23),
                            color: Colors.blue.shade800,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  'ทั้งนี้ข้าพเจ้ารับทราบว่าข้าพเจ้ามีสิทธิในการเพิกถอนความยินยอมดังกล่าวได้ตลอดเวลา',
                  style: TextStyle(
                    fontSize: MyConstant.setMediaQueryWidth(context, 23),
                  ),
                  textAlign: TextAlign.justify,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 15.h,
                    horizontal: 10.w,
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: width,
                        height: 30.h,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegisterPage(
                                  yomrub1: currentYomrub1,
                                  yomrub2: currentYomrub2,
                                  yomrub3: currentYomrub3,
                                  yomrub4: currentYomrub4,
                                  yomrub5: currentYomrub5,
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            // fixedSize: Size(double.infinity, 20.h),
                            backgroundColor: const Color(0xFF103533),

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            'ถัดไป',
                            style: TextStyle(
                              fontSize:
                                  MyConstant.setMediaQueryWidth(context, 23),
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
