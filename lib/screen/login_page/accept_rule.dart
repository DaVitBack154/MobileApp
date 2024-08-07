// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_chaseapp/screen/login_page/register_page.dart';
import 'package:mobile_chaseapp/utils/my_constant.dart';
// import 'package:mobile_chaseapp/utils/responsive_heigth__context.dart';
import 'package:url_launcher/url_launcher.dart';
// import '../../config/app_info.dart';

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

  // Future<void> openlaunchUrl(Uri url) async {
  //   if (mounted) {
  //     if (await canLaunchUrl(url)
  //         .timeout(
  //       const Duration(seconds: 20),
  //     )
  //         .catchError(
  //       (error) {
  //         if (kDebugMode) {
  //           print(
  //             'error ===>> $error',
  //           );
  //         }
  //         return false;
  //       },
  //     )) {
  //       if (!await launchUrl(url)
  //           .timeout(
  //         const Duration(seconds: 20),
  //       )
  //           .catchError(
  //         (error) {
  //           if (kDebugMode) {
  //             print(
  //               'error ===>> $error',
  //             );
  //           }
  //           return false;
  //         },
  //       )) {
  //         if (kDebugMode) {
  //           print(
  //             'Could not launch $url',
  //           );
  //         }
  //       }
  //     } else {
  //       if (kDebugMode) {
  //         print(
  //           'Could not launch $url',
  //         );
  //       }
  //     }
  //   }
  // }

  // Future<void> openlaunchUrlAppOther(String url) async {
  //   if (mounted) {
  //     // ignore: deprecated_member_use
  //     if (await canLaunch(url)
  //         .timeout(
  //       const Duration(seconds: 20),
  //     )
  //         .catchError(
  //       (error) {
  //         if (kDebugMode) {
  //           print(
  //             'error ===>> $error',
  //           );
  //         }
  //         return false;
  //       },
  //     )) {
  //       // ignore: deprecated_member_use
  //       if (!await launch(url)
  //           .timeout(
  //         const Duration(seconds: 20),
  //       )
  //           .catchError(
  //         (error) {
  //           if (kDebugMode) {
  //             print(
  //               'error ===>> $error',
  //             );
  //           }
  //           return false;
  //         },
  //       )) {
  //         if (kDebugMode) {
  //           print(
  //             'Could not launch $url',
  //           );
  //         }
  //       }
  //     } else {
  //       if (kDebugMode) {
  //         print(
  //           'Could not launch $url',
  //         );
  //       }
  //     }
  //   }
  // }

  Future<void> openlaunchUrl(String url) async {
    try {
      bool canLaunchUrlResult = await canLaunch(url);
      if (canLaunchUrlResult) {
        await launch(url, forceSafariVC: false, forceWebView: false);
      } else {
        throw 'Could not launch $url';
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error launching URL: $error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery.withClampedTextScaling(
        minScaleFactor: 1,
        maxScaleFactor: 1,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                'ข้อกำหนดและเงื่อนไข',
                style: TextStyle(
                    fontSize: MyConstant.setMediaQueryWidth(context, 23)),
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
          ),
        ));
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
          Text(
            Localizations.localeOf(context).languageCode == 'th'
                ? 'บริษัท เชฎฐ์ เอเชีย จำกัด (มหาชน)'
                : 'Chase Asia PCL',
            style: TextStyle(
              fontSize: 20.sp,
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
                    fontSize: MyConstant.setMediaQueryWidth(context, 22),
                  ),
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  '1. เพื่อแจ้งข้อมูลสิทธิพิเศษ ให้ท่านได้รับสิทธิประโยชน์จากข้อมูลข่าวสารสำคัญ โปรโมชั่น การประชาสัมพันธ์ และการนำเสนอข้อมูลผลิตภัณฑ์หรือบริการ',
                  style: TextStyle(
                    fontSize: MyConstant.setMediaQueryWidth(context, 22),
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
                          fontSize: MyConstant.setMediaQueryWidth(context, 22),
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
                          fontSize: MyConstant.setMediaQueryWidth(context, 22),
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Text(
                  '2. เพื่อใช้สำหรับธุรกิจวิเคราะห์ข้อมูลส่วนบุคคล (Data analytics business)การวิเคราะห์ข้อมูลส่วนบุคคลของท่าน โดยบริษัทฯ เพื่อปรับปรุงและพัฒนาประสิทธิภาพในการให้บริการ',
                  style: TextStyle(
                    fontSize: MyConstant.setMediaQueryWidth(context, 22),
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
                          fontSize: MyConstant.setMediaQueryWidth(context, 22),
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
                          fontSize: MyConstant.setMediaQueryWidth(context, 22),
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Text(
                  '3. เพื่อใช้สำหรับการยืนยันตัวตน กรณีที่เอกสารระบุตัวตนของท่าน เช่น บัตรประชาชน หนังสือเดินทาง หรือเอกสารอื่นใดที่ออกโดยหน่วยงานราชการซึ่งมีข้อมูลส่วนบุคคลที่มีความอ่อนไหว (Sensitive data) เช่น เชื้อชาติ ศาสนา โดยบริษัทฯ จะไม่นำข้อมูลดังกล่าวไปใช้เพื่อวัตถุประสงค์อื่น และคำนึงถึงความปลอดภัยของข้อมูลท่านเป็นสำคัญ',
                  style: TextStyle(
                    fontSize: MyConstant.setMediaQueryWidth(context, 22),
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
                          fontSize: MyConstant.setMediaQueryWidth(context, 22),
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
                          fontSize: MyConstant.setMediaQueryWidth(context, 22),
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                if (currentYomrub3 == "ไม่ยินยอม")
                  Padding(
                    padding: EdgeInsets.only(top: 3.h, bottom: 10.h),
                    child: Text(
                      'โปรด “ยินยอม” ให้บริษัทฯ ใช้ข้อมูลดังกล่าวหากบริษัทฯ ไม่ได้รับความยินยอมจากท่าน บริษัทฯ จะไม่สามารถให้บริการแก่ท่านได้ เนื่องจากบริษัทฯ มีความจำเป็นต้องใช้ข้อมูลดังกล่าวในการพิสูจน์และยืนยันตัวตนก่อนการลงทะเบียนเข้าใช้งาน',
                      style: TextStyle(
                          fontSize: MyConstant.setMediaQueryWidth(context, 19),
                          color: Colors.red),
                    ),
                  ),
                Text(
                  '4. เพื่อใช้สำหรับการยอมรับเอกสารอิเล็กทรอนิกส์ กรณีนี้จะถือว่าท่านไม่ประสงค์ในการรับบริการจัดส่งเอกสาร เช่น ใบเสร็จรับเงิน ใบกำกับภาษี หรือเอกสารอื่น ๆ ในรูปแบบต้นฉบับเอกสาร (Hard Copy) โดยบริษัทฯ จะจัดส่งเอกสารให้แก่ท่านผ่านทางอีเมลซึ่งแจ้งไว้ในระบบ',
                  style: TextStyle(
                    fontSize: MyConstant.setMediaQueryWidth(context, 22),
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
                          fontSize: MyConstant.setMediaQueryWidth(context, 22),
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
                          fontSize: MyConstant.setMediaQueryWidth(context, 22),
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Text(
                  '5. เพื่อใช้สำหรับการโอนข้อมูลส่วนบุคลไปต่างประเทศในบางกรณีที่บริษัทฯมีความจำเป็นต้องส่งหรือโอนข้อมูลส่วนบุคคลของท่านไปยังต่างประเทศเพื่อดำเนินการตามวัตถุประสงค์ในการให้บริการแก่ท่าน เช่น เพื่อส่งข้อมูลส่วนบุคคลไปยังระบบคลาวด์ (Cloud) ที่มีแพลตฟอร์มหรือเครื่องแม่ข่าย (Server) อยู่ต่างประเทศ เช่น ประเทศสิงคโปร์ หรือสหรัฐอเมริกา โดยบริษัทฯ ได้ดำเนินการตามหลักเกณฑ์การให้ความคุ้มครองข้อมูลส่วนบุคคลที่ส่งหรือโอนไปยังต่างประเทศที่คณะกรรมการคุ้มครองข้อมูลส่วนบุคคลประกาศกำหนด',
                  style: TextStyle(
                    fontSize: MyConstant.setMediaQueryWidth(context, 22),
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
                          fontSize: MyConstant.setMediaQueryWidth(context, 22),
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
                          fontSize: MyConstant.setMediaQueryWidth(context, 22),
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
                    fontSize: MyConstant.setMediaQueryWidth(context, 22),
                  ),
                  textAlign: TextAlign.start,
                ),
                Text(
                  'ข้าพเจ้าได้อ่านและเข้าใจในรายละเอียดเกี่ยวกับการเก็บ รวบรวม ใช้และเปิดเผยข้อมูลส่วนบุคคลของบริษัทฯตามที่ระบุในนโยบายคุ้มครองข้อมูลส่วนบุคคลรวมถึงประกาศความเป็นส่วนตัวที่เกี่ยวข้องแล้ว รายละเอียดตามที่ปรากฏในเว็บไซต์',
                  style: TextStyle(
                    fontSize: MyConstant.setMediaQueryWidth(context, 22),
                  ),
                  textAlign: TextAlign.justify,
                ),
                InkWell(
                  onTap: () {
                    openlaunchUrl('https://www.chase.co.th/en/privacy-policy')
                        .catchError((error) {
                      if (kDebugMode) {
                        print('Error launching URL: $error');
                      }
                    });
                  },
                  child: Row(
                    children: [
                      Flexible(
                        child: Text(
                          'https://www.chase.co.th/en/privacy-policy',
                          style: TextStyle(
                            fontSize:
                                MyConstant.setMediaQueryWidth(context, 22),
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
                    fontSize: MyConstant.setMediaQueryWidth(context, 22),
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
                          onPressed: (currentYomrub3 != "ไม่ยินยอม")
                              ? () {
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
                                }
                              : null,
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
