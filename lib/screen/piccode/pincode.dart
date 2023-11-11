import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_chaseapp/component/bottombar.dart';
import 'package:mobile_chaseapp/screen/homepage/notify.dart';
import 'package:mobile_chaseapp/utils/app_navigator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../component/numpad.dart';
import '../../../utils/key_storage.dart';

class PinCodeArgs {
  final bool isGotoNotif;

  const PinCodeArgs({
    this.isGotoNotif = false,
  });
}

class PinCode extends StatefulWidget {
  static const routeName = "PinCode";
  final PinCodeArgs? args;

  const PinCode({
    super.key,
    this.args,
  });

  @override
  State<PinCode> createState() => _PinCodeState();
}

class _PinCodeState extends State<PinCode> {
  int length = 6;

  onChange(String number) async {
    if (number.length == length) {
      final prefs = await SharedPreferences.getInstance();
      String pin = prefs.getString(KeyStorage.pin) ?? '';

      if (pin == number) {
        if (widget.args!.isGotoNotif) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const Notify(
                isFromFCM: true,
              ),
            ),
          );
        } else {
          print('pin ถูก');
          // ignore: use_build_context_synchronously
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const Bottombar(),
            ),
          );
        }
      } else {
        //print('pin ผิด');
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: SizedBox(
                height: 180.h,
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
                      "รหัส PIN ไม่ถูกต้องกรุณากรอก PIN ใหม่อีกครั้ง",
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
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Icon(
                            Icons.close,
                            size: 30.h,
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

      setState(() {});
    }
    print(number);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // double _height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 160.h + kToolbarHeight,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/image/bgpin.jpg'),
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                    ),
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/image/g_logo.png',
                      fit: BoxFit.cover,
                      height: 120.h,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              width: width,
              margin: const EdgeInsets.only(top: kToolbarHeight + 140).h,
              decoration: const BoxDecoration(
                color: Color(0xFFF395d5d),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 30.h,
                  ),
                  Text(
                    'กรุณากรอก PIN เพื่อใช้งาน',
                    style: TextStyle(
                      fontSize: 23.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Numpad(
                    length: 6,
                    onChange: onChange,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
