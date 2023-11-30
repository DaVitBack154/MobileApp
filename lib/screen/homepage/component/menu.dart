import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_chaseapp/screen/Menuitem/history/history.dart';
import 'package:mobile_chaseapp/screen/Menuitem/qrpay/pay.dart';
import 'package:mobile_chaseapp/screen/Menuitem/req_doc/req_doc.dart';
import 'package:mobile_chaseapp/utils/my_constant.dart';
import 'package:mobile_chaseapp/utils/responsive_heigth__context.dart';
import 'package:mobile_chaseapp/utils/responsive_width__context.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import '../../../controller/getprofile_controller.dart';
//import '../../../utils/key_storage.dart';
import '../../login_page/login_page.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.height);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        InkWell(
          child: Column(
            children: [
              Container(
                width: 60.w,
                height: 55.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Image(
                  image: AssetImage('assets/image/icon1.png'),
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                'ชำระเงิน',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                  fontSize: 18.sp,
                ),
              ),
            ],
          ),
          onTap: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            String? token = prefs.getString('token'); // ดึง Token
            if (token == null) {
              // ignore: use_build_context_synchronously
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const Login(),
                ),
              );
              return;
            }
            setState(() {});

            // ignore: use_build_context_synchronously
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Payment(),
              ),
            );
          },
        ),
        InkWell(
          child: Column(
            children: [
              Container(
                width: 60.w,
                height: 55.h,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Image(
                  image: AssetImage('assets/image/icon2.png'),
                  // width: 70,
                  // height: 70,
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                'ขอเอกสาร',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                  fontSize: 18.sp,
                ),
              ),
            ],
          ),
          onTap: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            String? token = prefs.getString('token'); // ดึง Token
            if (token == null) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const Login(),
                ),
              );
              return;
            }
            setState(() {});
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ReqDocument(),
              ),
            );
          },
        ),
        InkWell(
          child: Column(
            children: [
              Container(
                width: 60.w,
                height: 55.h,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Image(
                  image: AssetImage('assets/image/icon3.png'),
                  // width: 70,
                  // height: 70,
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                'ประวัติชำระ',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                  fontSize: 18.sp,
                ),
              ),
            ],
          ),
          onTap: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            String? token = prefs.getString('token'); // ดึง Token
            if (token == null) {
              // ignore: use_build_context_synchronously
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const Login(),
                ),
              );
              return;
            }
            setState(() {});
            // ignore: use_build_context_synchronously
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const History(),
              ),
            );
          },
        ),
      ],
    );
  }
}
