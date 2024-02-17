import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mobile_chaseapp/screen/account/component/acc_card.dart';
import 'package:mobile_chaseapp/utils/key_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  String? typeCustomer;
  String? ciType;
  bool load = false;

  @override
  void initState() {
    super.initState();
    getTypeCustomer();
  }

  Future<void> getTypeCustomer() async {
    final prefs = await SharedPreferences.getInstance();
    typeCustomer = prefs.getString(KeyStorage.typeCustomer) ?? 'Y';
    ciType = prefs.getString(KeyStorage.ciType) ?? 'T';

    print('typeCustomer : $typeCustomer');
    print('ciType : $ciType');
    load = true;
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
                      child: typeCustomer == 'Y' && ciType == 'T'
                          ? const AccCard()
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
                                                'เนื่องจากท่านเป็นบัญชีนิติบุคคล',
                                                style: TextStyle(
                                                  fontSize: 25.sp,
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
                                                  'กรุณาติดต่่อเจ้าหน้าที่ Callcenter 02-821-1055',
                                                  style: TextStyle(
                                                    fontSize: 25.sp,
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
                              : load == false
                                  ? LoadingAnimationWidget.threeArchedCircle(
                                      color: Colors.teal.shade700,
                                      size: 35.w,
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
                                                        fontSize: 20.sp,
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
                                    ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
