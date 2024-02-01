import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mobile_chaseapp/component/bottombar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../component/numpad.dart';
import '../../../controller/update_controller.dart';
import '../../../utils/key_storage.dart';

class Create_pin extends StatefulWidget {
  const Create_pin({super.key});

  @override
  State<Create_pin> createState() => _Create_pinState();
}

class _Create_pinState extends State<Create_pin> {
  final _updateController = UpdateController();

  TextEditingController controller = TextEditingController();

  bool varifiy = false;

  int length = 6;

  onChange(String number) async {
    if (number.length == length) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(KeyStorage.pin, number);

      controller.clear();
      varifiy = true;
      setState(() {});
    }
    print(number);
  }

  onChangeRe(String number) async {
    if (number.length == length) {
      final prefs = await SharedPreferences.getInstance();
      String pin = prefs.getString(KeyStorage.pin) ?? '';
      if (pin == number) {
        await _updateController.fetchUpdateProfile(
          pin: number,
        );
        // TODO: เหมือนกันให้ทำอะไร
        print('pin ถูก');

        // await prefs.setBool(KeyStorage.cfPin, true);
        // ignore: use_build_contxt_synchronously, use_build_context_synchronously
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return Center(
              child: LoadingAnimationWidget.twistingDots(
                leftDotColor: Color.fromARGB(255, 246, 165, 3),
                rightDotColor: Color.fromARGB(255, 224, 24, 24),
                size: 60,
              ),
            );
          },
        );

        await Future.delayed(const Duration(seconds: 3));

        // ignore: use_build_context_synchronously
        Navigator.pop(context);
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Bottombar(),
          ),
        );
      } else {
        // TODO: pin ไม่เหมืนอกันให้ทำอะไร
        print('pin ผิด');
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
                      "รหัส PIN ไม่ถูกต้องกรุณากรอก PIN ใหม่อีกครั้ง",
                      style: TextStyle(
                        fontSize: 19.sp,
                        color: Colors.grey.shade600,
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

      controller.clear();
      setState(() {});
    }
    print(number);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 30.h,
              horizontal: 20.w,
            ),
            child: Text(
              varifiy ? 'ยืนยันรหัส PIN อีกครั้ง' : 'สร้างรหัส PIN เพื่อใช้งาน',
              style: TextStyle(
                fontSize: 25.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
          Numpad(
            length: 6,
            onChange: !varifiy ? onChange : onChangeRe,
            isCreatePin: true,
          ),
        ],
      ),
      onWillPop: () async {
        return false;
      },
    );
  }
}
