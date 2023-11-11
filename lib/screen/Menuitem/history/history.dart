import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_chaseapp/screen/Menuitem/history/component/historybar.dart';
import 'package:mobile_chaseapp/screen/Menuitem/history/component/slide_his.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/key_storage.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  String? typeCustomer;

  @override
  void initState() {
    super.initState();
    getTypeCustomer();
  }

  Future<void> getTypeCustomer() async {
    final prefs = await SharedPreferences.getInstance();
    typeCustomer = prefs.getString(KeyStorage.typeCustomer) ?? 'Y';
    //print('typeCustomeritempayment : $typeCustomer');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 320.h + kToolbarHeight,
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
            child: const HisBar(),
          ),
          Container(
            width: width,
            margin: const EdgeInsets.only(top: kToolbarHeight + 65).h,
            child: typeCustomer == null
                ? const SizedBox()
                : typeCustomer == 'Y'
                    ? const SlideHis()
                    : Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 30.h,
                              horizontal: 25.w,
                            ),
                            child: SizedBox(
                              width: width,
                              height: 370.h,
                              child: Card(
                                clipBehavior: Clip.antiAlias,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                elevation: 2,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/image/danger.png',
                                      height: 60.h,
                                      fit: BoxFit.cover,
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    Text(
                                      'ไม่พบข้อมูล',
                                      style: TextStyle(
                                        fontSize: 30.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 25.h,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 10.h,
                                        horizontal: 25.w,
                                      ),
                                      child: Text(
                                        'ไม่พบข้อมูลสมาชิกในระบบ สนใจสินเชื่อกรุณาติดต่อ CallCenter 02-002-2032',
                                        style: TextStyle(
                                          fontSize: 19.sp,
                                          color: Colors.grey.shade500,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
          ),
        ],
      ),
    );
  }
}
