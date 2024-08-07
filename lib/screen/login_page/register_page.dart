import 'dart:async';
import 'dart:io';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mobile_chaseapp/controller/otp_controller.dart';
import 'package:mobile_chaseapp/controller/register_controller.dart';
import 'package:mobile_chaseapp/controller/update_controller.dart';
import 'package:mobile_chaseapp/firebase_cloud_messaging_provider.dart';
import 'package:mobile_chaseapp/screen/login_page/pin_page.dart';
import 'package:mobile_chaseapp/utils/my_constant.dart';
import 'package:mobile_chaseapp/utils/responsive_heigth__context.dart';
import 'package:mobile_chaseapp/utils/responsive_width__context.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../component/debouncer.dart';
import '../../component/textfield.dart';
import '../../utils/key_storage.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({
    Key? key,
    this.yomrub1,
    this.yomrub2,
    this.yomrub3,
    this.yomrub4,
    this.yomrub5,
  }) : super(key: key);

  final String? yomrub1;
  final String? yomrub2;
  final String? yomrub3;
  final String? yomrub4;
  final String? yomrub5;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final RegisterController _registerController = RegisterController();
  final CreateOTPController createotpController = CreateOTPController();
  final UpdateController authController = UpdateController();

  Timer? _timer;

  int currentIndex = 0;
  int countdown = 60; // เวลานับถอยหลังเริ่มต้นที่ 30 วินาที

  bool idNotExists = false;
  bool isPhone = true;
  String? errorTextGentName;
  String? errorTextName;
  String? errorTextSurName;
  String? errorTextIdCard;
  String? errorTextEmail;
  String? errorTextPhone;
  String? getotpstatus;
  // String? platformname;

  String profileImg = 'assets/image/user.png';
  String contractImg = 'assets/image/unread.png';
  String verifyImg = 'assets/image/shield.png';

  Color profileColor = const Color(0xFFF2F2F2);
  Color contractColor = const Color(0xFFF2F2F2);
  Color verifyColor = const Color(0xFFF2F2F2);
  Color line1Color = const Color(0x33F2F2F2);
  Color line2Color = const Color(0x33F2F2F2);

  // final _debouncer = Debouncer(
  //   delay: const Duration(milliseconds: Duration.millisecondsPerSecond),
  // );

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  @override
  void initState() {
    super.initState();
    _registerController.pinController.addListener(_listener);
  }

  // รอแก้ไขตรงนี้
  _listener() async {
    final firebaseToken = await FirebaseCloudMessagingProvider.getToken;
    String platformname = 'Unknown';
    if (_registerController.pinController.text.length == 6) {
      String sub = _registerController.phoneController.text;
      sub = '66' + sub.substring(1);
      getotpstatus = await createotpController.getOTP(
          phone: sub, otp: _registerController.pinController.text);
      print(getotpstatus);

      if (kIsWeb) {
        platformname = 'Web';
      } else if (Platform.isAndroid) {
        platformname = 'Android';
      } else if (Platform.isIOS) {
        platformname = 'IOS';
      } else if (Platform.isFuchsia) {
        platformname = 'Fuchsia';
      } else if (Platform.isLinux) {
        platformname = 'Linux';
      } else if (Platform.isMacOS) {
        platformname = 'MacOS';
      } else if (Platform.isWindows) {
        platformname = 'Windows';
      } else {
        platformname = 'Unknown';
      }
      print(platformname.toString() + 'aaaaaaaaaa');

      if (getotpstatus == 'true') {
        String result = await _registerController.fetchRegisterUser(
          gentname: _registerController.gentnameController.text,
          name: _registerController.nameController.text,
          surname: _registerController.surnameController.text,
          idCard: _registerController.idCardController.text,
          email: _registerController.emailController.text == ''
              ? _registerController.emailController.text = 'ไม่พบอีเมล'
              : _registerController.emailController.text,
          phone: _registerController.phoneController.text,
          device: firebaseToken,
          platform: platformname.toString(),
          yomrub1: widget.yomrub1.toString(),
          yomrub2: widget.yomrub2.toString(),
          yomrub3: widget.yomrub3.toString(),
          yomrub4: widget.yomrub4.toString(),
          yomrub5: widget.yomrub5.toString(),
        );
        print(result + 'result');
        print('objectfffffff');
        if (result.isNotEmpty) {
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(result),
            ),
          );
          return;
        }

        // ignore: use_build_context_synchronously
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return Center(
              child: LoadingAnimationWidget.twistingDots(
                leftDotColor: Color.fromARGB(255, 241, 162, 3),
                rightDotColor: Color.fromARGB(255, 227, 11, 11),
                size: 60,
              ),
            );
          },
        );
        await Future.delayed(const Duration(seconds: 4));
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Pin_page(),
          ),
        );
      } else {
        _registerController.pinController.clear();
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: SizedBox(
                height: 200.h,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/image/danger.png',
                      height: 50.h,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      "รหัส OTP ไม่ถูกต้องกรุณาลองใหม่อีกครั้ง",
                      style: TextStyle(
                        fontSize: 18.sp,
                        // color: Colors.grey.shade500,
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
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Icon(
                            Icons.close,
                            size: 25.h,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // actions: [

              // ],
            );
          },
        );
      }
    }
  }

  Future setOTP() async {
    String sub = _registerController.phoneController.text;
    sub = '66' + sub.substring(1);
    getotpstatus = await createotpController.createPhoneOTP(phone: sub);
  }

  void startCountdown() {
    setState(() {
      countdown = 60; // เริ่มนับถอยหลัง 30 วินาที
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        countdown--; // ลดเวลานับถอยหลังลงทีละ 1 วินาที
      });

      if (timer.tick == 60) {
        timer.cancel();
        _timer?.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;
    final query = MediaQuery.of(context);

    List<Widget> pages = [
      _profile(),
      _contract(),
      _otp(),
    ];

    Future<bool> onWillPop() async {
      return false;
    }

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
          child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              automaticallyImplyLeading: false,
              leading: currentIndex == 0
                  ? null
                  : Container(
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: MyConstant.setMediaQueryWidth(context, 25),
                        ),
                        onPressed: () {
                          if (currentIndex > 0) {
                            setState(() {
                              currentIndex--;
                              //  profileColor =  Colors.white;
                              //  line1Color = const Color(0x33F2F2F2);
                              //  profileImg = 'assets/image/user.png';
                            });
                          }
                        },
                      ),
                    ),
            ),
            // resizeToAvoidBottomInset: false,
            extendBodyBehindAppBar: true,
            extendBody: true,
            body: Column(
              children: [
                Container(
                  width: width,
                  height: 165.h + kToolbarHeight,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/image/bg_2.png',
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          top: ResponsiveWidthContext.isMobile(context)
                              ? MyConstant.setMediaQueryWidth(context, 40)
                              : ResponsiveWidthContext.isMobileFoldVertical(
                                      context)
                                  ? MyConstant.setMediaQueryWidth(context, 10)
                                  : MyConstant.setMediaQueryWidth(context, 35),
                        ),
                        child: Text(
                          'ลงทะเบียน',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize:
                                MyConstant.setMediaQueryWidth(context, 30),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MyConstant.setMediaQueryWidth(context, 25),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          _circle(
                            assetImage: currentIndex == 0 ? profileImg : null,
                            title: 'ขั้นตอนที่ 1',
                            detail: 'ข้อมูลส่วนตัว',
                            color: profileColor,
                          ),
                          _line(line1Color),
                          _circle(
                            assetImage: currentIndex <= 1 ? contractImg : null,
                            title: 'ขั้นตอนที่ 2',
                            detail: 'ข้อมูลการติดต่อ',
                            color: contractColor,
                          ),
                          _line(line2Color),
                          _circle(
                            assetImage: currentIndex <= 2 ? verifyImg : null,
                            title: 'ขั้นตอนที่ 3',
                            detail: 'ยืนยันตัวตน',
                            color: verifyColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    // reverse: true,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 15.w,
                            vertical: 25.h,
                          ),
                          child: pages[currentIndex],
                        ),
                        if (currentIndex != 2) ...[
                          ElevatedButton(
                            onPressed: () async {
                              switch (currentIndex) {
                                case 0:
                                  {
                                    if (_registerController
                                        .gentnameController.text.isEmpty) {
                                      errorTextGentName = 'กรุณาเลือกคำนำหน้า';
                                    } else {
                                      errorTextGentName = null;
                                    }

                                    if (_registerController.nameController.text
                                        .trim()
                                        .isEmpty) {
                                      errorTextName = 'กรุณากรอกชื่อ';
                                    } else if (_registerController
                                            .nameController.text
                                            .trim()
                                            .length <=
                                        2) {
                                      errorTextName = 'กรุณากรอกชื่อให้ครบถ้วน';
                                    } else {
                                      errorTextName = null;
                                    }

                                    if (_registerController
                                        .surnameController.text
                                        .trim()
                                        .isEmpty) {
                                      errorTextSurName = 'กรุณากรอกนามสกุล';
                                    } else if (_registerController
                                            .surnameController.text
                                            .trim()
                                            .length <=
                                        2) {
                                      errorTextSurName =
                                          'กรุณากรอกนามสกุลให้ครบถ้วน';
                                    } else {
                                      errorTextSurName = null;
                                    }

                                    if (_registerController
                                        .idCardController.text
                                        .trim()
                                        .isEmpty) {
                                      errorTextIdCard =
                                          'กรุณากรอกหมายเลขบัตรประชาชน';
                                    } else if (_registerController
                                            .idCardController.text
                                            .trim()
                                            .length <
                                        13) {
                                      errorTextIdCard =
                                          'กรุณากรอกหมายเลขบัตรประชาชนให้ครบถ้วน';
                                    } else {
                                      var result = await _registerController
                                          .fetchGetIdCard(_registerController
                                              .idCardController.text);

                                      idNotExists = result.status!;

                                      if (result.status!) {
                                        errorTextIdCard =
                                            'พบเลขบัตรประชาชนในระบบ';
                                        setState(() {});
                                      }
                                    }

                                    if (errorTextGentName == null &&
                                        errorTextName == null &&
                                        errorTextSurName == null &&
                                        errorTextIdCard == null) {
                                      currentIndex++;
                                      profileColor = const Color(0xFF648CF3);
                                      line1Color = const Color(0xFF648CF3);
                                    }
                                    setState(() {});
                                  }
                                  break;

                                case 1:
                                  {
                                    // if (_registerController.emailController.text
                                    //     .trim()
                                    //     .isEmpty) {
                                    //   errorTextEmail = 'กรุณากรอกอีเมลล์';
                                    // } else if (_registerController
                                    //         .emailController.text
                                    //         .trim()
                                    //         .length <=
                                    //     2) {
                                    //   errorTextEmail =
                                    //       'กรุณากรอกอีเมลล์ให้ครบถ้วน';
                                    // } else if (!EmailValidator.validate(
                                    //   _registerController.emailController.text
                                    //       .trim(),
                                    // )) {
                                    //   errorTextEmail = 'รูปแบบอีเมลไม่ถูกต้อง';
                                    // } else {
                                    //   errorTextEmail = null;
                                    // }

                                    if (_registerController.phoneController.text
                                        .trim()
                                        .isEmpty) {
                                      errorTextPhone = 'กรุณากรอกเบอร์โทรศัพท์';
                                    } else if (_registerController
                                            .phoneController.text
                                            .trim()
                                            .length <=
                                        2) {
                                      errorTextPhone =
                                          'กรุณากรอกเบอร์โทรศัพท์ให้ครบถ้วน';
                                      // } else if (isPhone) {
                                      //   errorTextPhone = 'พบเบอร์โทรศัพในระบบ';
                                    } else {
                                      errorTextPhone = null;
                                    }

                                    var result = await authController
                                        .fetchGetPhone(_registerController
                                            .phoneController.text);
                                    isPhone = result;
                                    print('object ----- $isPhone');
                                    if (isPhone == true) {
                                      errorTextPhone = 'พบเบอร์โทรศัพท์ในระบบ';
                                      setState(() {});
                                    }

                                    if (errorTextEmail == null &&
                                        errorTextPhone == null &&
                                        isPhone == false) {
                                      await setOTP();

                                      currentIndex++;
                                      line2Color = const Color(0xFF648CF3);
                                      contractColor = const Color(0xFF648CF3);
                                      startCountdown();
                                    }
                                    setState(() {});
                                  }
                                  break;
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(width * 0.8,
                                  MyConstant.setMediaQueryWidth(context, 40)),
                              backgroundColor: const Color(0xFF103533),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              'ถัดไป',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: MyConstant.setMediaQueryWidth(
                                  context,
                                  25,
                                ),
                              ),
                            ),
                          ),
                        ],
                        SizedBox(
                          height: 20.h,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _profile() {
    double width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'คำนำหน้า',
              style: TextStyle(
                color: Color(0xFF5C5C5C),
                fontSize: MyConstant.setMediaQueryWidth(context, 23),
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 3),
              child: DropdownButtonFormField<String>(
                value: _registerController.gentnameController.text.isNotEmpty
                    ? _registerController.gentnameController.text
                    : null, // ใช้ค่าว่างหากไม่มีค่าในตอนแรก
                icon: Icon(
                  Icons.keyboard_arrow_down_outlined,
                  size: MyConstant.setMediaQueryWidth(context, 30),
                ),
                hint: Text(
                  'กรุณาเลือกคำนำหน้า',
                  style: ResponsiveWidthContext.isTablet(context) ||
                          ResponsiveWidthContext.isTablet11(context)
                      ? TextStyle(fontSize: 9.sp)
                      : null,
                ),
                style: TextStyle(
                  fontSize: MyConstant.setMediaQueryWidth(context, 18),
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade600,
                ),

                isExpanded: true,
                padding: EdgeInsets.symmetric(
                  horizontal: 10.w,
                  vertical: 2.h,
                ),
                onChanged: (value) {
                  //print(value);
                  if (value == null) {
                    _registerController.gentnameController.text = '';
                    setState(() {
                      errorTextGentName = 'กรุณาเลือกคำนำหน้า';
                    });
                  } else {
                    setState(() {
                      _registerController.gentnameController.text = value;
                      errorTextGentName = null;
                      //print(value + 'tokota');
                    });
                  }
                },

                items: const [
                  DropdownMenuItem(
                    value: 'นาย',
                    child: Text('นาย'),
                  ),
                  DropdownMenuItem(
                    value: 'นาง',
                    child: Text('นาง'),
                  ),
                  DropdownMenuItem(
                    value: 'นางสาว',
                    child: Text('นางสาว'),
                  ),
                ],
                decoration: InputDecoration(
                  enabledBorder: const UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.grey), // สีเมื่อไม่ Focus
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ), // สีเมื่อ Focus
                  ),
                ),
              ),
            ),
          ),
          //เชคเงื่อนไข ของ คำนำหน้า
          if (errorTextGentName != null)
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 2.h,
                    horizontal: 15.w,
                  ),
                  child: Text(
                    'กรุณาเลือกคำนำหน้า',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: MyConstant.setMediaQueryWidth(context, 23),
                    ),
                  ),
                ),
              ],
            ),
          //เชคเงื่อนไข ของ คำนำหน้า
          SizedBox(
            height: 15.h,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'ชื่อ',
              style: TextStyle(
                  color: Color(0xFF5C5C5C),
                  fontSize: MyConstant.setMediaQueryWidth(context, 23),
                  fontWeight: FontWeight.w400),
            ),
          ),
          textField(
            'ชื่อ',
            controller: _registerController.nameController,
            width: width,
            autoFocus: false,
            padding: const EdgeInsets.only(top: 3, bottom: 24),
            contentPadding: EdgeInsets.symmetric(horizontal: 15.w),
            errorText: errorTextName,
            hintStyle: TextStyle(
              fontSize: MyConstant.setMediaQueryWidth(
                context,
                25,
              ),
            ),
            fontSize: 17.sp,
            inputFormatter: [
              FilteringTextInputFormatter.deny(
                  RegExp(r'[0-9\s]')), // ป้องกันตัวเลขและเว้นวรรค
            ],
            onChanged: (value) {
              value.isEmpty
                  ? errorTextName = 'กรุณากรอกชื่อ'
                  : errorTextName = null;
              setState(() {});
            },
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'นามสกุล',
              style: TextStyle(
                  color: Color(0xFF5C5C5C),
                  fontSize: MyConstant.setMediaQueryWidth(context, 23),
                  fontWeight: FontWeight.w400),
            ),
          ),
          textField(
            'นามสกุล',
            controller: _registerController.surnameController,
            width: width,
            autoFocus: false,
            padding: const EdgeInsets.only(top: 3, bottom: 24),
            contentPadding: EdgeInsets.symmetric(horizontal: 15.w),
            errorText: errorTextSurName,
            hintStyle: TextStyle(
                fontSize: MyConstant.setMediaQueryWidth(
              context,
              25,
            )),
            fontSize: 17.sp,
            inputFormatter: [
              FilteringTextInputFormatter.deny(
                  RegExp(r'[0-9\s]')), // ป้องกันตัวเลขและเว้นวรรค
            ],
            onChanged: (value) {
              value.isEmpty
                  ? errorTextSurName = 'กรุณากรอกนามสกุล'
                  : errorTextSurName = null;
              setState(() {});
            },
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'หมายเลขบัตรประชาชน',
              style: TextStyle(
                  color: Color(0xFF5C5C5C),
                  fontSize: MyConstant.setMediaQueryWidth(
                    context,
                    23,
                  ),
                  fontWeight: FontWeight.w400),
            ),
          ),
          textField(
            'หมายเลขบัตรประชาชน',
            controller: _registerController.idCardController,
            width: width,
            autoFocus: false,
            maxLength: 13,
            padding: const EdgeInsets.only(top: 3, bottom: 24),
            contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
            errorText: errorTextIdCard,
            hintStyle: TextStyle(
              fontSize: MyConstant.setMediaQueryWidth(
                context,
                25,
              ),
            ),
            fontSize: 17.sp,
            onChanged: (value) {
              value.isEmpty
                  ? errorTextIdCard = 'กรุณากรอกหมายเลขบัตรประชาชน'
                  : errorTextIdCard = null;
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  Widget _contract() {
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'อีเมล',
            style: TextStyle(
                color: Color(0xFF5C5C5C),
                fontSize: MyConstant.setMediaQueryWidth(context, 23),
                fontWeight: FontWeight.w400),
          ),
        ),
        textField(
          'example@gmail.com',
          controller: _registerController.emailController,
          width: width,
          autoFocus: false,
          padding: const EdgeInsets.only(top: 3, bottom: 24),
          contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
          errorText: errorTextEmail,
          hintStyle: TextStyle(
            fontSize: MyConstant.setMediaQueryWidth(context, 25),
          ),
          fontSize: 17.sp,
          // onChanged: (value) {
          //   setState(() {
          //     if (value.isEmpty) {
          //       errorTextEmail = 'กรุณากรอกอีเมลล์';
          //     } else if (!EmailValidator.validate(value.trim())) {
          //       errorTextEmail = 'กรุณากรอกรูปแบบ อีเมลให้ถูกต้อง';
          //     } else {
          //       errorTextEmail = null;
          //     }
          //   });
          // },
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'หมายเลขโทรศัพท์',
            style: TextStyle(
                color: Color(0xFF5C5C5C),
                fontSize: MyConstant.setMediaQueryWidth(context, 23),
                fontWeight: FontWeight.w400),
          ),
        ),
        textField(
          'หมายเลขโทรศัพท์',
          controller: _registerController.phoneController,
          width: width,
          autoFocus: false,
          padding: const EdgeInsets.only(top: 3, bottom: 24),
          contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
          errorText: errorTextPhone,
          hintStyle: TextStyle(
            fontSize: MyConstant.setMediaQueryWidth(context, 25),
          ),
          fontSize: 17.sp,
          onChanged: (value) {
            value.isEmpty || value.length != 10
                ? errorTextPhone = 'กรุณากรอกเบอร์โทรศัพท์ให้ถูกต้อง'
                : errorTextPhone = null;
            setState(() {});
            //TODO รอพี่พาทำ
          },
          keyboardType: TextInputType.phone,
          maxLength: 10,
        ),
      ],
    );
  }

  Widget _otp() {
    // double width = MediaQuery.of(context).size.width;
    final defaulPinTheme = PinTheme(
      width: 50.w,
      height: 45.h,
      textStyle: TextStyle(fontSize: 22.sp, color: Colors.black),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.transparent),
      ),
    );
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'OTP จะถูกส่งไปยังหมายเลข',
            style: TextStyle(
                color: Color(0xFF5C5C5C),
                fontSize: 20.sp,
                fontWeight: FontWeight.w400),
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey.shade200,
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _registerController.phoneController.text.replaceAllMapped(
                      RegExp(r'(\d{3})(\d{3})(\d+)'),
                      (Match m) => "${m[1]}-${m[2]}-${m[3]}"),
                  style: TextStyle(
                    fontSize: 23.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  'ขอ OTP ใหม่อีกครั้ง',
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: Colors.grey.shade500,
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                countdown > 0
                    ? Text(
                        '${countdown.toString()} วินาที',
                        style: TextStyle(
                          fontSize: 20.sp,
                          color: Colors.red,
                        ),
                      )
                    : GestureDetector(
                        onTap: () async {
                          if (countdown == 0) {
                            await setOTP();
                            startCountdown(); // เริ่มนับถอยหลังเมื่อกด "ขอ OTP ใหม่อีกครั้ง"'

                            // ตรวจสอบว่ากำลังนับถอยหลังหรือไม่ก่อนที่จะรับ OTP ใหม่
                            // แล้วค่อยเรียกฟังก์ชันส่ง OTP ใหม่
                          }
                        },
                        child: Text(
                          'กดที่นี่เพื่อขอ OTP ใหม่',
                          style: TextStyle(
                            fontSize: 17.sp,
                            color: const Color(0xFF103533),
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: 20.h,
        ),
        Pinput(
          controller: _registerController.pinController,
          length: 6,
          defaultPinTheme: defaulPinTheme.copyWith(
            decoration: defaulPinTheme.decoration!.copyWith(
              color: const Color(
                0xFFF395D5D,
              ), // เปลี่ยนสีพื้นหลังของช่องกรอก PIN
            ),
            textStyle: TextStyle(
              color: Colors.white,
              fontSize: 23.sp, // เปลี่ยนสีตัวอักษรภายในช่องกรอก PIN
            ),
          ),
          focusedPinTheme: defaulPinTheme.copyWith(
            decoration: defaulPinTheme.decoration!.copyWith(
              border: Border.all(
                color: Color(0xFFF395D5D),
              ),
              color: const Color(
                0xFFF395D5D,
              ),
            ),
            textStyle: TextStyle(
              color: Colors.white,
              fontSize: 23.sp, // เปลี่ยนสีตัวอักษรภายในช่องกรอก PIN
            ),
          ),
        ),
      ],
    );
  }

  Widget _circle({
    required String? assetImage,
    required String title,
    required String detail,
    required Color color,
  }) {
    return Column(
      children: [
        assetImage != null
            ? Container(
                width: MyConstant.setMediaQueryWidth(context, 60),
                height: MyConstant.setMediaQueryWidth(context, 60),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color,
                ),
                child: Image.asset(
                  assetImage,
                  scale: ResponsiveWidthContext.isTablet(context) ||
                          ResponsiveWidthContext.isTablet11(context) ||
                          ResponsiveWidthContext.isTabletMini(context)
                      ? MyConstant.setMediaQueryWidth(context, 0.5)
                      : 1.3,
                  color: Color(0xFF103533),
                ),
              )
            : Container(
                width: MyConstant.setMediaQueryWidth(context, 60),
                height: MyConstant.setMediaQueryWidth(context, 60),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color,
                ),
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                ),
              ),
        SizedBox(height: 5.h),
        Text(
          title,
          style: TextStyle(
            fontSize: ResponsiveWidthContext.isTablet(context) ||
                    ResponsiveWidthContext.isTablet11(context)
                ? MyConstant.setMediaQueryWidth(context, 23)
                : MyConstant.setMediaQueryWidth(context, 20),
            color: Colors.grey.shade400,
          ),
        ),
        Text(
          detail,
          style: TextStyle(
            fontSize: ResponsiveWidthContext.isTablet(context) ||
                    ResponsiveWidthContext.isTablet11(context)
                ? MyConstant.setMediaQueryWidth(context, 23)
                : MyConstant.setMediaQueryWidth(context, 20),
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _line(Color color) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MyConstant.setMediaQueryWidth(context, 55),
      ),
      child: Container(
        height: 5.h,
        width: 50.w,
        margin: EdgeInsets.symmetric(horizontal: 5.w),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}
