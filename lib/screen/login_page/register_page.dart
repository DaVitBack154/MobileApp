import 'dart:async';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_chaseapp/controller/register_controller.dart';
import 'package:mobile_chaseapp/firebase_cloud_messaging_provider.dart';
import 'package:mobile_chaseapp/screen/login_page/pin_page.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../component/debouncer.dart';
import '../../component/textfield.dart';
import '../../utils/key_storage.dart';
import 'component/format_phone.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final RegisterController _registerController = RegisterController();

  Timer? _timer;

  int currentIndex = 0;
  int countdown = 30; // เวลานับถอยหลังเริ่มต้นที่ 30 วินาที

  bool idNotExists = false;
  String? errorTextGentName;
  String? errorTextName;
  String? errorTextSurName;
  String? errorTextIdCard;
  String? errorTextEmail;
  String? errorTextPhone;

  String profileImg = 'assets/image/user.png';
  String contractImg = 'assets/image/unread.png';
  String verifyImg = 'assets/image/shield.png';

  Color profileColor = const Color(0xFFF2F2F2);
  Color contractColor = const Color(0xFFF2F2F2);
  Color verifyColor = const Color(0xFFF2F2F2);
  Color line1Color = const Color(0x33F2F2F2);
  Color line2Color = const Color(0x33F2F2F2);

  final _debouncer = Debouncer(
    delay: const Duration(milliseconds: Duration.millisecondsPerSecond),
  );

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

  _listener() async {
    final firebaseToken = await FirebaseCloudMessagingProvider.getToken;
    if (_registerController.pinController.text.length == 6) {
      if (_registerController.pinController.text == '111111') {
        String result = await _registerController.fetchRegisterUser(
          gentname: _registerController.gentnameController.text,
          name: _registerController.nameController.text,
          surname: _registerController.surnameController.text,
          idCard: _registerController.idCardController.text,
          email: _registerController.emailController.text,
          phone: _registerController.phoneController.text,
          device: firebaseToken ?? '',
        );
        if (result.isNotEmpty) {
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(result),
            ),
          );
          return;
        }

        if (_registerController.userModel.user != null &&
            _registerController.userModel.user?.id != null) {
          final prefs = await SharedPreferences.getInstance();

          await prefs.setString(
              KeyStorage.uid, _registerController.userModel.user!.id!);

          // ignore: use_build_context_synchronously
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  const Pin_page(), // แทน HomePage() ด้วยหน้าที่ต้องการไป
            ),
          );
        } else {
          // ignore: use_build_context_synchronously
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("แจ้งเตือน"),
                content: Text("ขออภัยระบบขัดข้อง"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("ปิด"),
                  ),
                ],
              );
            },
          );
        }
      } else {
        _registerController.pinController.clear();
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("แจ้งเตือน"),
              content: Text("ขออภัยระบบขัดข้อง"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("ปิด"),
                ),
              ],
            );
          },
        );
      }
    }
  }

  void startCountdown() {
    setState(() {
      countdown = 30; // เริ่มนับถอยหลัง 30 วินาที
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        countdown--; // ลดเวลานับถอยหลังลงทีละ 1 วินาที
      });

      if (timer.tick == 30) {
        timer.cancel();
        _timer?.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;

    List<Widget> pages = [
      _profile(),
      _contract(),
      _otp(),
    ];

    return GestureDetector(
      child: WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
            leading: currentIndex == 0
                ? null
                : IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 25,
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
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      'ลงทะเบียน',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                      ),
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

                                  if (_registerController.surnameController.text
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

                                  if (_registerController.idCardController.text
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
                                    if (idNotExists) {
                                      errorTextIdCard =
                                          'มีเลขบัตรประชาชนในระบบแล้ว';
                                    } else {
                                      errorTextIdCard = null;
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
                                  if (_registerController.emailController.text
                                      .trim()
                                      .isEmpty) {
                                    errorTextEmail = 'กรุณากรอกอีเมลล์';
                                  } else if (_registerController
                                          .emailController.text
                                          .trim()
                                          .length <=
                                      2) {
                                    errorTextEmail =
                                        'กรุณากรอกอีเมลล์ให้ครบถ้วน';
                                  } else if (!EmailValidator.validate(
                                    _registerController.emailController.text
                                        .trim(),
                                  )) {
                                    errorTextEmail = 'รูปแบบอีเมลไม่ถูกต้อง';
                                  } else {
                                    errorTextEmail = null;
                                  }

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
                                  } else {
                                    errorTextPhone = null;
                                  }
                                  if (errorTextEmail == null &&
                                      errorTextPhone == null) {
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
                            fixedSize: Size(width * 0.8, 50),
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
                                fontSize: 22.sp),
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
        onWillPop: () async {
          return false;
        },
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
                fontSize: 19.sp,
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
                icon: const Icon(
                  Icons.keyboard_arrow_down_outlined,
                  size: 25,
                ),
                hint: const Text('กรุณาเลือกคำนำหน้า'),
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade600,
                ),

                isExpanded: true,
                padding: EdgeInsets.symmetric(
                  horizontal: 10.w,
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
                      fontSize: 17.sp,
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
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w400),
            ),
          ),
          textField(
            'ชื่อ',
            controller: _registerController.nameController,
            width: width,
            autoFocus: false,
            padding: const EdgeInsets.only(top: 3, bottom: 24),
            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
            errorText: errorTextName,
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
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w400),
            ),
          ),
          textField(
            'นามสกุล',
            controller: _registerController.surnameController,
            width: width,
            autoFocus: false,
            padding: const EdgeInsets.only(top: 3, bottom: 24),
            contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
            errorText: errorTextSurName,
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
                  fontSize: 20.sp,
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
            onChanged: (value) {
              value.isEmpty
                  ? errorTextIdCard = 'กรุณากรอกหมายเลขบัตรประชาชน'
                  : errorTextIdCard = null;
              setState(() {});

              if (value.isNotEmpty && value.length == 13) {
                _debouncer.call(() async {
                  var result = await _registerController.fetchGetIdCard(value);

                  idNotExists = result.status!;

                  if (result.status!) {
                    errorTextIdCard = result.message;
                    setState(() {});
                  }
                });
              }
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
                fontSize: 20.sp,
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
          onChanged: (value) {
            setState(() {
              if (value.isEmpty) {
                errorTextEmail = 'กรุณากรอกอีเมลล์';
              } else if (!EmailValidator.validate(value.trim())) {
                errorTextEmail = 'กรุณากรอกรูปแบบ อีเมลให้ถูกต้อง';
              } else {
                errorTextEmail = null;
              }
            });
          },
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'หมายเลขโทรศัพท์',
            style: TextStyle(
                color: Color(0xFF5C5C5C),
                fontSize: 20.sp,
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
          onChanged: (value) {
            value.isEmpty
                ? errorTextPhone = 'กรุณากรอกเบอร์โทรศัพท์'
                : errorTextPhone = null;
            setState(() {});
          },
          keyboardType: TextInputType.phone,
          inputFormatter: [PhoneFormatter()],
        ),
      ],
    );
  }

  Widget _otp() {
    // double width = MediaQuery.of(context).size.width;
    final defaulPinTheme = PinTheme(
      width: 50.w,
      height: 50.h,
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
                    fontSize: 17.sp,
                    color: Colors.grey.shade500,
                  ),
                ),
                SizedBox(
                  width: 20.w,
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
                        onTap: () {
                          if (countdown == 0) {
                            startCountdown(); // เริ่มนับถอยหลังเมื่อกด "ขอ OTP ใหม่อีกครั้ง"
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
                width: 50.w,
                height: 50.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color,
                ),
                child: Image.asset(
                  assetImage,
                  scale: 1.5,
                  color: Color(0xFF103533),
                ),
              )
            : Container(
                width: 50.w,
                height: 50.h,
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
            fontSize: 16.sp,
            color: Colors.grey.shade400,
          ),
        ),
        Text(
          detail,
          style: TextStyle(
            fontSize: 17.sp,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _line(Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30).h,
      child: Container(
        height: 5.h,
        width: 55.w,
        margin: EdgeInsets.symmetric(horizontal: 5.w),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}
