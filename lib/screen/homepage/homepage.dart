import 'package:animations/animations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_chaseapp/controller/getprofile_controller.dart';
import 'package:mobile_chaseapp/controller/updatestarpont_controller.dart';
import 'package:mobile_chaseapp/screen/homepage/component/menu.dart';
import 'package:mobile_chaseapp/screen/homepage/component/navbar.dart';
import 'package:mobile_chaseapp/screen/homepage/component/slide.dart';
import 'package:mobile_chaseapp/screen/homepage/salehome/salehome.dart';
import 'package:mobile_chaseapp/utils/key_storage.dart';
import 'package:mobile_chaseapp/utils/my_constant.dart';
import 'package:mobile_chaseapp/utils/responsive_heigth__context.dart';
import 'package:mobile_chaseapp/utils/responsive_width__context.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final ProfileController profileController = ProfileController();
  final commentcontroller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future<bool> onWillPop() async {
    return false;
  }

  @override
  Widget build(BuildContext context) {
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
            body: Column(
              children: [
                Container(
                  width: MyConstant.setMediaQueryWidthFull(context),
                  height: ResponsiveWidthContext.isTablet(context)
                      ? MyConstant.setMediaQueryWidth(context, 565)
                      : ResponsiveWidthContext.isTablet11(context)
                          ? MyConstant.setMediaQueryWidth(context, 530)
                          : ResponsiveWidthContext.isMobile(context) ||
                                  ResponsiveWidthContext.isMobileSmall(
                                      context) ||
                                  ResponsiveWidthContext.isMobileFoldVertical(
                                      context)
                              ? MyConstant.setMediaQueryWidth(context, 502)
                              : MyConstant.setMediaQueryWidth(context, 530),
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
        ),
      ),
    );
  }

  Widget btnSaleHome() {
    return Column(
      children: [
        SizedBox(
          height: ResponsiveWidthContext.isMobile(context) ||
                  ResponsiveWidthContext.isMobileSmall(context)
              ? 10.h
              : 5.h,
        ),
        Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10.w,
              ),
              child: Text(
                'บ้านและที่ดิน',
                style: TextStyle(
                  fontSize: MyConstant.setMediaQueryWidth(context, 26),
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
              elevation: 4,
              child: Container(
                color: Colors.grey.shade100,
                child: Row(
                  children: [
                    Image.asset(
                      'assets/image/salehome01.png',
                      width: ResponsiveWidthContext.isMobileFoldVertical(
                              context)
                          ? MyConstant.setMediaQueryWidth(context, 210)
                          : ResponsiveWidthContext.isMobile(context) ||
                                  ResponsiveWidthContext.isMobileSmall(context)
                              ? MyConstant.setMediaQueryWidth(context, 210)
                              : MyConstant.setMediaQueryWidth(context, 240),
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
                              'ประกาศขาย',
                              style: TextStyle(
                                  fontSize: MyConstant.setMediaQueryWidth(
                                      context, 22),
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xfff395d5d)),
                            ),
                            Text(
                              'บ้านเดี่ยว ทาวน์เฮ้าส์ และที่ดิน ทั่วประเทศไทย',
                              style: TextStyle(
                                fontSize: ResponsiveWidthContext.isMobile(
                                            context) ||
                                        ResponsiveWidthContext.isMobileSmall(
                                            context)
                                    ? MyConstant.setMediaQueryWidth(context, 18)
                                    : ResponsiveWidthContext.isTablet11(
                                                context) ||
                                            ResponsiveWidthContext.isTabletMini(
                                                context)
                                        ? MyConstant.setMediaQueryWidth(
                                            context, 20)
                                        : MyConstant.setMediaQueryWidth(
                                            context, 21),
                              ),
                            ),
                            // Text(
                            //   'ทั่วประเทศไทย',
                            //   style: TextStyle(
                            //     fontSize: ResponsiveWidthContext.isMobile(
                            //                 context) ||
                            //             ResponsiveWidthContext.isMobileSmall(
                            //                 context)
                            //         ? MyConstant.setMediaQueryWidth(context, 18)
                            //         : MyConstant.setMediaQueryWidth(
                            //             context, 22),
                            //   ),
                            // ),
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
