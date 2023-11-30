import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_chaseapp/screen/homepage/component/menu.dart';
import 'package:mobile_chaseapp/screen/homepage/component/navbar.dart';
import 'package:mobile_chaseapp/screen/homepage/component/slide.dart';
import 'package:mobile_chaseapp/screen/homepage/salehome/salehome.dart';
import 'package:mobile_chaseapp/utils/my_constant.dart';
import 'package:mobile_chaseapp/utils/responsive_heigth__context.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    final query = MediaQuery.of(context);
    return MediaQuery(
      data: query.copyWith(
        // ignore: deprecated_member_use
        textScaler: TextScaler.linear(query.textScaleFactor.clamp(1.0, 1.0)),
      ),
      child: Scaffold(
        body: Column(
          children: [
            Container(
              width: MyConstant.setMediaQueryWidthFull(context),
              height: ResponsiveHeightContext.isMobile(context) ? 430.h : 445.h,
              decoration: const BoxDecoration(
                color: Colors.black,
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
      ),
    );
  }

  Widget btnSaleHome() {
    return Column(
      children: [
        SizedBox(
          height: ResponsiveHeightContext.isMobile(context) ? 10.h : 5.h,
        ),
        Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 15.w,
              ),
              child: Text(
                'ที่ดินและบ้าน',
                style: TextStyle(
                  fontSize: 19.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 5.w,
          ),
          child: InkWell(
            child: Card(
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              color: Colors.white,
              elevation: 3,
              child: Container(
                color: Colors.grey.shade100,
                child: Row(
                  children: [
                    Image.asset(
                      'assets/image/salehome.jpeg',
                      width: 170.w,
                      fit: BoxFit.contain,
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
                              'ประกาศขาย',
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFF395D5D)),
                            ),
                            Text(
                              'ที่ดิน ทาวเฮาส์ บ้านมือสอง กรุงเทพและทั่วประเทศ',
                              style: TextStyle(
                                fontSize: 14.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SaleHome(),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
