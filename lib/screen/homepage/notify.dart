import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:mobile_chaseapp/component/bottombar.dart';
import 'package:mobile_chaseapp/controller/getnotify.dart';
import 'package:mobile_chaseapp/controller/getnotifypromotion.dart';
import 'package:mobile_chaseapp/controller/update_paynoti.dart';
import 'package:mobile_chaseapp/controller/updatenotipromotion.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Notify extends StatefulWidget {
  static const routeName = "Notify";
  final bool isFromFCM;

  const Notify({super.key, this.isFromFCM = false});

  @override
  State<Notify> createState() => _NotifyState();
}

class _NotifyState extends State<Notify> {
  NotifyController notifyController = NotifyController();
  NotifyPromotionController notifyPromotionController =
      NotifyPromotionController();

  bool loading = true;
  final formattedDate = DateFormat("yyyy-MM-dd");
  final thaiBahtFormat = NumberFormat.currency(locale: 'th_TH', symbol: '');

  Future<void> fetchNotify() async {
    setState(() {
      loading = true;
    });
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token'); // ดึง Token

      UpdateNotiPromotion updateNotiPromotion = UpdateNotiPromotion();
      await updateNotiPromotion.fetchUpdateNotiPromotion(
        token: token,
        statusRead: "Y",
      );

      UpdatePaynoti updatePaynoti = UpdatePaynoti();
      await updatePaynoti.fetchUpdatePayNoti(
        token: token,
        statusRead: "Y",
      );

      await notifyController.fetchNotify();
      await notifyPromotionController.fetchNotifyPromotion();
      loading = false;
      setState(() {});
    } catch (error) {
      //print('เกิดข้อผิดพลาดในการดึงข้อมูล: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchNotify();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                width: width,
                height: 300.h + kToolbarHeight,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/image/bg.png'),
                    fit: BoxFit.cover,
                    alignment: Alignment.topRight,
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 60.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.black.withOpacity(.1),
                            ),
                            child: IconButton(
                              icon: const Icon(
                                Icons.arrow_back_ios_new_outlined,
                                size: 25,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                if (widget.isFromFCM) {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const Bottombar(),
                                    ),
                                  );
                                } else {
                                  Navigator.pop(context, true);
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            width: 25.w,
                          ),
                          Text(
                            'การแจ้งเตือน',
                            style: TextStyle(
                              fontSize: 25.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 120.h,
            bottom: 0,
            child: Container(
              width: width,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8),
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
                    : SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (notifyController.usernotify.data!.isNotEmpty &&
                                notifyPromotionController
                                    .notipromotion.data!.isNotEmpty) ...[
                              ...List.generate(
                                notifyController.usernotify.data?.length ?? 0,
                                (index) {
                                  final data =
                                      notifyController.usernotify.data?[index];
                                  if (data?.flag == 'One') {
                                    return Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 10.h,
                                        horizontal: 10.w,
                                      ),
                                      child: Container(
                                        width: width,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade100,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 10.h,
                                            vertical: 10.w,
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Row(
                                                children: [
                                                  Image.asset(
                                                    'assets/image/${data?.companyId == 'CFAA' ? 'cfam.png' : 'rway.png'}',
                                                    height: 18,
                                                    fit: BoxFit.cover,
                                                  ),
                                                  SizedBox(
                                                    height: 30.h,
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'ขอบคุณที่ชำระเงิน',
                                                    style: TextStyle(
                                                      fontSize: 19.sp,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(
                                                    formattedDate.format(
                                                      DateTime.parse(
                                                        data?.payDate
                                                                .toString() ??
                                                            'ไม่พบข้อมูล',
                                                      ),
                                                    ),
                                                    style: TextStyle(
                                                      fontSize: 20.sp,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'ยอดชำระเงิน',
                                                    style: TextStyle(
                                                      fontSize: 20.sp,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        thaiBahtFormat.format(
                                                            data?.payAmount ??
                                                                'nodata'),
                                                        style: TextStyle(
                                                          fontSize: 20.sp,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 10.w,
                                                      ),
                                                      Text(
                                                        'บาท',
                                                        style: TextStyle(
                                                          fontSize: 20.sp,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'เลขที่สัญญา',
                                                    style: TextStyle(
                                                      fontSize: 20.sp,
                                                    ),
                                                  ),
                                                  Text(
                                                    data?.customerId
                                                            .toString() ??
                                                        'fdfd',
                                                    style: TextStyle(
                                                      fontSize: 20.sp,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }

                                  if (data?.flag == 'All' ||
                                      data?.title == 'แจ้งปิดปรับปรุงระบบ') {
                                    return Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 10.h,
                                        horizontal: 10.w,
                                      ),
                                      child: Container(
                                        width: width,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade100,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 10.h,
                                            vertical: 10.w,
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Row(
                                                children: [
                                                  Image.asset(
                                                    'assets/image/danger.png',
                                                    height: 20.h,
                                                    fit: BoxFit.cover,
                                                  ),
                                                  SizedBox(
                                                    width: 10.w,
                                                  ),
                                                  Text(
                                                    data?.title.toString() ??
                                                        '',
                                                    style: TextStyle(
                                                      fontSize: 20.sp,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10.h,
                                              ),
                                              Text(
                                                'ทางระบบจะปิดปรับปรุง เวลา 20.00 และเปิดทำการ เวลา 21.00 ขอบคุณที่ใช้บริการ',
                                                style: TextStyle(
                                                  fontSize: 16.sp,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }

                                  return const Text('ไม่พบข้อมูล');
                                },
                              )
                                  .followedBy(
                                    List.generate(
                                      notifyPromotionController
                                              .notipromotion.data?.length ??
                                          0,
                                      (index) {
                                        final notiPromotionData =
                                            notifyPromotionController
                                                .notipromotion.data?[index];
                                        // รายการสำหรับ notiPromotionData
                                        if (notiPromotionData?.statusNoti ==
                                            'Y') {
                                          return Padding(
                                            padding: EdgeInsets.symmetric(
                                              vertical: 10.h,
                                              horizontal: 10.w,
                                            ),
                                            child: Container(
                                              width: width,
                                              decoration: BoxDecoration(
                                                color: Colors.grey.shade100,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 10.h,
                                                  vertical: 10.w,
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Image.asset(
                                                          'assets/image/icon_a.png',
                                                          height: 20.h,
                                                          fit: BoxFit.cover,
                                                        ),
                                                        SizedBox(
                                                          width: 10.w,
                                                        ),
                                                        Text(
                                                          notiPromotionData
                                                                  ?.titleNoti
                                                                  .toString() ??
                                                              'ไม่พบข้อมูล',
                                                          style: TextStyle(
                                                            fontSize: 20.sp,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                    Text(
                                                      notiPromotionData
                                                              ?.bodyNoti
                                                              .toString() ??
                                                          'ไม่พบข้อมูล',
                                                      style: TextStyle(
                                                        fontSize: 16.sp,
                                                      ),
                                                    ),
                                                    Text(notiPromotionData
                                                            ?.statusRead
                                                            .toString() ??
                                                        'fdfd')
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                        return const SizedBox.shrink();
                                      },
                                    ),
                                  )
                                  .toList(),
                            ] else ...[
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 15,
                                ),
                                child: Container(
                                  width: width,
                                  height: 40.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.black.withOpacity(.08),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'ไม่พบการแจ้งเตือน',
                                      style: TextStyle(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ],
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
