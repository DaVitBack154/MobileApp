import 'package:flutter/material.dart';
import 'package:mobile_chaseapp/screen/Menuitem/history/history.dart';
import 'package:mobile_chaseapp/screen/Menuitem/qrpay/pay.dart';
import 'package:mobile_chaseapp/screen/Menuitem/req_doc/req_doc.dart';
import 'package:mobile_chaseapp/utils/my_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../login_page/login_page.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        buildMenuButton('assets/image/icon1.png', 'ชำระเงิน', const Payment()),
        buildMenuButton(
            'assets/image/icon2.png', 'ขอเอกสาร', const ReqDocument()),
        buildMenuButton(
            'assets/image/icon3.png', 'ประวัติชำระ', const History()),
      ],
    );
  }

  Widget buildMenuButton(String imagePath, String title, Widget destination) {
    return InkWell(
      child: Column(
        children: [
          Container(
            width: MyConstant.setMediaQueryWidth(context, 58),
            height: MyConstant.setMediaQueryWidth(context, 58),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: EdgeInsets.all(
                MyConstant.setMediaQueryWidth(context, 12),
              ),
              child: Image(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.normal,
              fontSize: MyConstant.setMediaQueryWidth(context, 22),
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
            builder: (context) => destination,
          ),
        );
      },
    );
  }
}
