import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_chaseapp/screen/Menuitem/req_doc/component/req_bar.dart';
import 'package:mobile_chaseapp/screen/Menuitem/req_doc/component/req_doc_post.dart';
import 'package:mobile_chaseapp/utils/key_storage.dart';
import 'package:mobile_chaseapp/utils/responsive_heigth__context.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReqDocument extends StatefulWidget {
  const ReqDocument({super.key});

  @override
  State<ReqDocument> createState() => _ReqDocumentState();
}

class _ReqDocumentState extends State<ReqDocument> {
  String? typeCustomer;
  String? ciType;

  @override
  void initState() {
    super.initState();
    getTypeCustomer();
  }

  Future<void> getTypeCustomer() async {
    final prefs = await SharedPreferences.getInstance();
    typeCustomer = prefs.getString(KeyStorage.typeCustomer) ?? 'Y';
    ciType = prefs.getString(KeyStorage.ciType) ?? 'T';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    //double height = MediaQuery.of(context).size.height;
    final query = MediaQuery.of(context);
    return MediaQuery(
      data: query.copyWith(
        // ignore: deprecated_member_use
        textScaler: TextScaler.linear(query.textScaleFactor.clamp(1.0, 1.0)),
      ),
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                Container(
                  width: width,
                  height: ResponsiveHeightContext.isMobile(context)
                      ? 300.h + kToolbarHeight
                      : 290.h + kToolbarHeight,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                    ),
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/image/bg.png',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: const Column(
                    children: [
                      ReqDocBar(),
                    ],
                  ),
                  //ส่วน navbar,
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: kToolbarHeight + 50).h,
              width: double.infinity,
              child: typeCustomer == 'Y' && ciType == 'T'
                  ? const ReqDocumentFrom()
                  : ciType == 'F'
                      ? Column(
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
                                        'ไม่พบข้อมูลสมาชิก',
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
                                          'เนื่องจากผู้สมัครเป็นบัญชีนิติบุคคล กรุณาติดต่อ Callcenter 02-821-1055',
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
                        )
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
                                          'ไม่พบข้อมูลสมาชิกในระบบ สนใจสินเชื่อกรุณาติดต่อ CallCenter 02-821-1055',
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
            )
          ],
        ),
      ),
    );
  }
}
