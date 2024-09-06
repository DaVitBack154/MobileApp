import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobile_chaseapp/controller/getacc_controller.dart';
import 'package:mobile_chaseapp/getcontroller/getacc_controller.dart';
import 'package:mobile_chaseapp/model/respon_accuser.dart';
import 'package:mobile_chaseapp/screen/Menuitem/qrpay/component/bar.dart';
import 'package:mobile_chaseapp/screen/Menuitem/qrpay/component/slide_acc.dart';
import 'package:mobile_chaseapp/utils/my_constant.dart';
import 'package:mobile_chaseapp/utils/responsive_heigth__context.dart';
import 'package:mobile_chaseapp/utils/responsive_width__context.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../utils/key_storage.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  bool loading = true;
  UserAccModel? accData;
  AccController accController = AccController();
  final CustomerController customerController = Get.put(CustomerController());

  @override
  void initState() {
    super.initState();
    getTypeCustomer();
    customerController.fetchUserProfile();
  }

  Future<void> getTypeCustomer() async {
    setState(() {
      loading = true;
    });

    accData = await accController.fetchAccData();

    setState(() {
      loading = false;
    });
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
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              Column(
                children: [
                  Container(
                    width: width,
                    height:
                        ResponsiveWidthContext.isMobileFoldVertical(context) ||
                                ResponsiveWidthContext.isMobileSmall(context) ||
                                ResponsiveWidthContext.isMobile(context)
                            ? 280.h + kToolbarHeight
                            : ResponsiveWidthContext.isTablet11(context) ||
                                    ResponsiveWidthContext.isTablet(context)
                                ? 310.h + kToolbarHeight
                                : 300.h + kToolbarHeight,
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
                        Bar(),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: kToolbarHeight + 50).h,
                width: double.infinity,
                // decoration: BoxDecoration(color: Colors.green),
                child: loading
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 80.h),
                            width: 40.w,
                            height: 35.h,
                            child: CircularProgressIndicator(
                              color: Colors.teal.shade800,
                            ),
                          ),
                        ],
                      )
                    : Obx(() {
                        return customerController.typeCustomer.value == 'Y' &&
                                (accData?.data != null &&
                                    accData!.data!.isNotEmpty &&
                                    (accData!.data![0].ciType == 'T' ||
                                        accData!.data![0].ciType == ''))
                            ? const SlideAcc()
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
                                                      color:
                                                          Colors.grey.shade500,
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
                                : customerController.typeCustomer.value == 'N'
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
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 25.h,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                        vertical: 10.h,
                                                        horizontal: 25.w,
                                                      ),
                                                      child: Text(
                                                        'ไม่พบข้อมูลสมาชิกในระบบ กรุณาติดต่อ CallCenter 02-821-1055',
                                                        style: TextStyle(
                                                          fontSize: 19.sp,
                                                          color: Colors
                                                              .grey.shade700,
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
                                    : SizedBox();
                      }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
