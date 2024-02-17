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
            width: MyConstant.setMediaQueryWidth(context, 60),
            // width: ResponsiveWidthContext.isMobileSmall(context)
            //     ? MyConstant.setMediaQueryWidth(context, 70)
            //     : ResponsiveWidthContext.isTablet(context)
            //         ? MyConstant.setMediaQueryWidth(context, 90)
            //         : ResponsiveWidthContext.isTablet11(context)
            //             ? MyConstant.setMediaQueryWidth(context, 45)
            //             : ResponsiveWidthContext.isTabletMini(context)
            //                 ? MyConstant.setMediaQueryWidth(context, 60)
            //                 : MyConstant.setMediaQueryWidth(context, 65),
            height: MyConstant.setMediaQueryWidth(context, 60),
            // height: ResponsiveWidthContext.isTablet(context)
            //     ? MyConstant.setMediaQueryWidth(context, 90)
            //     : ResponsiveWidthContext.isTablet11(context)
            //         ? MyConstant.setMediaQueryWidth(context, 45)
            //         : ResponsiveWidthContext.isTabletMini(context)
            //             ? MyConstant.setMediaQueryWidth(context, 60)
            //             : MyConstant.setMediaQueryHeight(context, 60),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: EdgeInsets.all(MyConstant.setMediaQueryWidth(context, 10)
                  // ResponsiveWidthContext.isTablet(context)
                  //     ? 15
                  //     : ResponsiveWidthContext.isTablet11(context)
                  //         ? MyConstant.setMediaQueryWidth(context, 10)
                  //         : ResponsiveWidthContext.isTabletMini(context)
                  //             ? MyConstant.setMediaQueryWidth(context, 12)
                  //             : 15,
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
                fontSize: MyConstant.setMediaQueryWidth(context, 23)
                // fontSize: ResponsiveWidthContext.isTablet(context)
                //     ? MyConstant.setMediaQueryWidth(context, 35)
                //     : ResponsiveWidthContext.isTablet11(context)
                //         ? MyConstant.setMediaQueryWidth(context, 18)
                //         : MyConstant.setMediaQueryWidth(context, 22),
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

  // print(MediaQuery.of(context).size.height);
  // return Row(
  //   mainAxisAlignment: MainAxisAlignment.spaceAround,
  //   children: [
  //     InkWell(
  //       child: Column(
  //         children: [
  //           Container(
  //             width: ResponsiveHeightContext.isMobileFoldVertical(context)
  //                 ? MyConstant.setMediaQueryHeight(context, 55)
  //                 : ResponsiveHeightContext.isMobileSmall(context)
  //                     ? MyConstant.setMediaQueryHeight(context, 60)
  //                     : ResponsiveHeightContext.isMobile(context)
  //                         ? MyConstant.setMediaQueryHeight(context, 60)
  //                         : ResponsiveHeightContext.isTablet(context)
  //                             ? MyConstant.setMediaQueryHeight(context, 90)
  //                             : null,
  //             height: ResponsiveHeightContext.isMobileFoldVertical(context)
  //                 ? MyConstant.setMediaQueryHeight(context, 55)
  //                 : ResponsiveHeightContext.isMobileSmall(context)
  //                     ? MyConstant.setMediaQueryHeight(context, 60)
  //                     : ResponsiveHeightContext.isMobile(context)
  //                         ? MyConstant.setMediaQueryHeight(context, 60)
  //                         : ResponsiveHeightContext.isTablet(context)
  //                             ? MyConstant.setMediaQueryHeight(context, 80)
  //                             : null,
  //             decoration: BoxDecoration(
  //               color: Colors.white,
  //               borderRadius: BorderRadius.circular(20),
  //             ),
  //             child: Padding(
  //               padding: const EdgeInsets.all(18.0),
  //               child: const Image(
  //                 image: AssetImage('assets/image/icon1.png'),
  //                 fit: BoxFit.cover,
  //               ),
  //             ),
  //           ),
  //           Text(
  //             'ชำระเงิน',
  //             style: TextStyle(
  //               color: Colors.white,
  //               fontWeight: FontWeight.normal,
  //               fontSize:
  //                   ResponsiveHeightContext.isTablet(context) ? 16.sp : 17.sp,
  //             ),
  //           ),
  //         ],
  //       ),
  //       onTap: () async {
  //         SharedPreferences prefs = await SharedPreferences.getInstance();
  //         String? token = prefs.getString('token'); // ดึง Token
  //         if (token == null) {
  //           // ignore: use_build_context_synchronously
  //           Navigator.pushReplacement(
  //             context,
  //             MaterialPageRoute(
  //               builder: (context) => const Login(),
  //             ),
  //           );
  //           return;
  //         }
  //         setState(() {});

  //         // ignore: use_build_context_synchronously
  //         Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //             builder: (context) => const Payment(),
  //           ),
  //         );
  //       },
  //     ),
  //     InkWell(
  //       child: Column(
  //         children: [
  //           Container(
  //             width: ResponsiveHeightContext.isMobileFoldVertical(context)
  //                 ? MyConstant.setMediaQueryHeight(context, 55)
  //                 : ResponsiveHeightContext.isMobileSmall(context)
  //                     ? MyConstant.setMediaQueryHeight(context, 60)
  //                     : ResponsiveHeightContext.isMobile(context)
  //                         ? MyConstant.setMediaQueryHeight(context, 60)
  //                         : null,
  //             height: ResponsiveHeightContext.isMobileFoldVertical(context)
  //                 ? MyConstant.setMediaQueryHeight(context, 55)
  //                 : ResponsiveHeightContext.isMobileSmall(context)
  //                     ? MyConstant.setMediaQueryHeight(context, 60)
  //                     : ResponsiveHeightContext.isMobile(context)
  //                         ? MyConstant.setMediaQueryHeight(context, 60)
  //                         : MyConstant.setMediaQueryHeight(context, 60),
  //             decoration: BoxDecoration(
  //               shape: BoxShape.rectangle,
  //               color: Colors.white,
  //               borderRadius: BorderRadius.circular(20),
  //             ),
  //             child: const Image(
  //               image: AssetImage('assets/image/icon2.png'),
  //               // width: 70,
  //               // height: 70,
  //             ),
  //           ),
  //           Text(
  //             'ขอเอกสาร',
  //             style: TextStyle(
  //               color: Colors.white,
  //               fontWeight: FontWeight.normal,
  //               fontSize: 18.sp,
  //             ),
  //           ),
  //         ],
  //       ),
  //       onTap: () async {
  //         SharedPreferences prefs = await SharedPreferences.getInstance();
  //         String? token = prefs.getString('token'); // ดึง Token
  //         if (token == null) {
  //           Navigator.pushReplacement(
  //             context,
  //             MaterialPageRoute(
  //               builder: (context) => const Login(),
  //             ),
  //           );
  //           return;
  //         }
  //         setState(() {});
  //         Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //             builder: (context) => const ReqDocument(),
  //           ),
  //         );
  //       },
  //     ),
  //     InkWell(
  //       child: Column(
  //         children: [
  //           Container(
  //             width: ResponsiveHeightContext.isMobileFoldVertical(context)
  //                 ? MyConstant.setMediaQueryHeight(context, 55)
  //                 : ResponsiveHeightContext.isMobileSmall(context)
  //                     ? MyConstant.setMediaQueryHeight(context, 60)
  //                     : ResponsiveHeightContext.isMobile(context)
  //                         ? MyConstant.setMediaQueryHeight(context, 60)
  //                         : null,
  //             height: ResponsiveHeightContext.isMobileFoldVertical(context)
  //                 ? MyConstant.setMediaQueryHeight(context, 55)
  //                 : ResponsiveHeightContext.isMobileSmall(context)
  //                     ? MyConstant.setMediaQueryHeight(context, 60)
  //                     : ResponsiveHeightContext.isMobile(context)
  //                         ? MyConstant.setMediaQueryHeight(context, 60)
  //                         : MyConstant.setMediaQueryHeight(context, 60),
  //             decoration: BoxDecoration(
  //               shape: BoxShape.rectangle,
  //               color: Colors.white,
  //               borderRadius: BorderRadius.circular(20),
  //             ),
  //             child: const Image(
  //               image: AssetImage('assets/image/icon3.png'),
  //               // width: 70,
  //               // height: 70,
  //             ),
  //           ),
  //           Text(
  //             'ประวัติชำระ',
  //             style: TextStyle(
  //               color: Colors.white,
  //               fontWeight: FontWeight.normal,
  //               fontSize: 18.sp,
  //             ),
  //           ),
  //         ],
  //       ),
  //       onTap: () async {
  //         SharedPreferences prefs = await SharedPreferences.getInstance();
  //         String? token = prefs.getString('token'); // ดึง Token
  //         if (token == null) {
  //           // ignore: use_build_context_synchronously
  //           Navigator.pushReplacement(
  //             context,
  //             MaterialPageRoute(
  //               builder: (context) => const Login(),
  //             ),
  //           );
  //           return;
  //         }
  //         setState(() {});
  //         // ignore: use_build_context_synchronously
  //         Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //             builder: (context) => const History(),
  //           ),
  //         );
  //       },
  //     ),
  //   ],
  // );
}
