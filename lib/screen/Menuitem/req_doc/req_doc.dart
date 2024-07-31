import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_chaseapp/controller/getacc_controller.dart';
import 'package:mobile_chaseapp/model/respon_accuser.dart';
import 'package:mobile_chaseapp/screen/Menuitem/req_doc/component/req_bar.dart';
import 'package:mobile_chaseapp/screen/Menuitem/req_doc/component/req_doc_post.dart';
import 'package:mobile_chaseapp/utils/key_storage.dart';
import 'package:mobile_chaseapp/utils/my_constant.dart';
import 'package:mobile_chaseapp/utils/responsive_heigth__context.dart';
import 'package:mobile_chaseapp/utils/responsive_width__context.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReqDocument extends StatefulWidget {
  const ReqDocument({super.key});

  @override
  State<ReqDocument> createState() => _ReqDocumentState();
}

class _ReqDocumentState extends State<ReqDocument> {
  String? typeCustomer;
  bool loading = true;
  UserAccModel? accData;
  AccController accController = AccController();

  Future<void> getTypeCustomer() async {
    setState(() {
      loading = true;
    });
    final prefs = await SharedPreferences.getInstance();
    typeCustomer = prefs.getString(KeyStorage.typeCustomer) ?? 'Y';
    accData = await accController.fetchAccData();
    loading = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getTypeCustomer();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return MediaQuery.withClampedTextScaling(
      minScaleFactor: 1,
      maxScaleFactor: 1,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: Stack(
            children: [
              Column(
                children: [
                  Container(
                    width: width,
                    height: ResponsiveWidthContext.isMobileFoldVertical(context)
                        ? 290.h + kToolbarHeight
                        : ResponsiveWidthContext.isMobile(context) ||
                                ResponsiveWidthContext.isMobileSmall(context)
                            ? 300.h + kToolbarHeight
                            : ResponsiveWidthContext.isTablet(context)
                                ? MyConstant.setMediaQueryWidth(context, 390) +
                                    kToolbarHeight
                                : MyConstant.setMediaQueryWidth(context, 380) +
                                    kToolbarHeight,

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
                margin: const EdgeInsets.only(top: kToolbarHeight + 52).h,
                width: double.infinity,
                child: loading
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 80.h),
                            width: 40.w,
                            height: 40.h,
                            child: CircularProgressIndicator(
                              color: Colors.teal.shade800,
                            ),
                          ),
                        ],
                      )
                    : typeCustomer == 'Y' &&
                            (accData?.data != null &&
                                accData!.data!.isNotEmpty &&
                                (accData!.data![0].ciType == 'T' ||
                                    accData!.data![0].ciType == ''))
                        ? const ReqDocumentFrom()
                        : accData?.data != null &&
                                accData!.data!.isNotEmpty &&
                                accData!.data![0].ciType == 'F'
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
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        elevation: 2,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                            : typeCustomer == 'N'
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
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            elevation: 2,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
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
                                                    'ไม่พบข้อมูลสมาชิกในระบบ กรุณาติดต่อ CallCenter 02-821-1055',
                                                    style: TextStyle(
                                                      fontSize: 19.sp,
                                                      color:
                                                          Colors.grey.shade700,
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
                                : SizedBox(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
