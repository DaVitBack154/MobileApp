import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobile_chaseapp/controller/getacc_controller.dart';
import 'package:mobile_chaseapp/getcontroller/getacc_controller.dart';
import 'package:mobile_chaseapp/model/respon_accuser.dart';
import 'package:mobile_chaseapp/screen/account/component/acc_card.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  // String? typeCustomer;
  UserAccModel? accData;
  AccController accController = AccController();
  bool loading = true;
  CustomerController customerController = Get.put(CustomerController());

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
  // final prefs = await SharedPreferences.getInstance();
  // typeCustomer = prefs.getString(KeyStorage.typeCustomer) ?? 'Y';

  Future<bool> onWillPop() async {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

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
            body: Stack(
              children: [
                Container(
                  width: width,
                  height: 350.h + kToolbarHeight,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/image/bg.png'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(30),
                    ),
                  ),
                ),
                SafeArea(
                  child: Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 20.h),
                          child: Text(
                            'ACCOUNT',
                            style: TextStyle(
                              fontSize: 28.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Expanded(
                          child: loading
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(bottom: 80.h),
                                      width: 40.w,
                                      height: 35.h,
                                      child: CircularProgressIndicator(
                                        color: Colors.teal.shade500,
                                      ),
                                    ),
                                  ],
                                )
                              : Obx(
                                  () {
                                    return customerController
                                                    .typeCustomer.value ==
                                                'Y' &&
                                            (accData?.data != null &&
                                                accData!.data!.isNotEmpty &&
                                                (accData!.data![0].ciType ==
                                                        'T' ||
                                                    accData!.data![0].ciType ==
                                                        ''))
                                        ? const AccCard()
                                        : accData?.data != null &&
                                                accData!.data!.isNotEmpty &&
                                                accData!.data![0].ciType == 'F'
                                            ? Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      vertical: 30.h,
                                                      horizontal: 25.w,
                                                    ),
                                                    child: SizedBox(
                                                      width: width,
                                                      height: 370.h,
                                                      child: Card(
                                                        clipBehavior:
                                                            Clip.antiAlias,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                        ),
                                                        elevation: 2,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
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
                                                              'เนื่องจากท่านเป็นบัญชีนิติบุคคล',
                                                              style: TextStyle(
                                                                fontSize: 25.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 25.h,
                                                            ),
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                vertical: 10.h,
                                                                horizontal:
                                                                    25.w,
                                                              ),
                                                              child: Text(
                                                                'กรุณาติดต่่อเจ้าหน้าที่ Callcenter 02-821-1055',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      25.sp,
                                                                  color: Colors
                                                                      .grey
                                                                      .shade500,
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
                                            : customerController
                                                        .typeCustomer.value ==
                                                    'N'
                                                ? Column(
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                          vertical: 30.h,
                                                          horizontal: 25.w,
                                                        ),
                                                        child: SizedBox(
                                                          width: width,
                                                          height: 370.h,
                                                          child: Card(
                                                            clipBehavior:
                                                                Clip.antiAlias,
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                            ),
                                                            elevation: 2,
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Image.asset(
                                                                  'assets/image/danger.png',
                                                                  height: 60.h,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                                SizedBox(
                                                                  height: 20.h,
                                                                ),
                                                                Text(
                                                                  'ไม่พบข้อมูลสมาชิก',
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        30.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 25.h,
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .symmetric(
                                                                    vertical:
                                                                        10.h,
                                                                    horizontal:
                                                                        25.w,
                                                                  ),
                                                                  child: Text(
                                                                    'ไม่พบข้อมูลสมาชิกในระบบ กรุณาติดต่อ CallCenter 02-821-1055',
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          20.sp,
                                                                      color: Colors
                                                                          .grey
                                                                          .shade700,
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
                                                : SizedBox.shrink();
                                  },
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
      ),
    );
  }
}
