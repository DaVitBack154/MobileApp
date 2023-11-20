// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:mobile_chaseapp/screen/homepage/component/ads_salehome.dart';
// import 'package:mobile_chaseapp/screen/homepage/component/knowledge.dart';
import 'package:mobile_chaseapp/screen/homepage/component/menu.dart';
import 'package:mobile_chaseapp/screen/homepage/component/navbar.dart';
import 'package:mobile_chaseapp/screen/homepage/component/slide.dart';
import 'package:mobile_chaseapp/screen/homepage/salehome/salehome.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: width,
            height: (height * 0.5).h,
            padding: const EdgeInsets.only(bottom: 8).h,
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
            child: const Column(
              children: [
                Navbar(),
                Slide(),
                Menu(),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  btnSaleHome(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget btnSaleHome() {
    return Column(
      children: [
        SizedBox(
          height: 10.h,
        ),
        Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 15.w,
              ),
              child: Text(
                'ซื้อ-ขายบ้าน',
                style: TextStyle(
                  fontSize: 18.sp,
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: 5.h,
            horizontal: 7.w,
          ),
          child: Card(
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 5,
            child: Row(
              children: [
                Image.asset(
                  'assets/image/salehome.jpeg',
                  width: 170,
                  fit: BoxFit.cover,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ซื้อ-บ้านกับ เรามีบ้านให้เลือกมากมาย',
                          style: TextStyle(
                            fontSize: 16.sp,
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SaleHome(),
                                  ),
                                );
                              },
                              child: Text('สนใจดูรายละเอียด-คลิก'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
