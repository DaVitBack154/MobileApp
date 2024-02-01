import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:mobile_chaseapp/component/card_user.dart';
import '../../../../controller/getacc_controller.dart';
import '../../../../controller/getpayment_controller.dart';
import '../../../../model/respon_payment.dart';

class SlideHis extends StatefulWidget {
  const SlideHis({super.key});

  @override
  State<SlideHis> createState() => _SlideHisState();
}

class _SlideHisState extends State<SlideHis> {
  PaymentController paymentController = PaymentController();
  AccController accController = AccController();
  final CarouselController carouselController = CarouselController();
  int _currentIndex = 0;
  bool loading = true;

  List<Data>? userPayment;

  String formattedDate(String date) {
    return "${date.substring(0, 4)}-${date.substring(4, 6)}-${date.substring(6, 8)}";
  }

  Future<void> fetchPaymentData() async {
    setState(() {
      loading = true;
    });
    try {
      await paymentController.fetchPaymentData();
      await accController.fetchAccData();
      loading = false;
      setState(() {});
    } catch (error) {
      print('เกิดข้อผิดพลาดในการดึงข้อมูล: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchPaymentData();
  }

  @override
  Widget build(BuildContext context) {
    final thaiBahtFormat = NumberFormat.currency(locale: 'th_TH', symbol: '');
    // double height = MediaQuery.of(context).size.height;
    final query = MediaQuery.of(context);
    return loading
        ? const SizedBox()
        : MediaQuery(
            data: query.copyWith(
              // ignore: deprecated_member_use
              textScaler:
                  // ignore: deprecated_member_use
                  TextScaler.linear(query.textScaleFactor.clamp(1.0, 1.0)),
            ),
            child: Column(
              children: [
                CarouselSlider(
                  items: accController.userAccModel.data!
                      .asMap()
                      .map((index, data) {
                        return MapEntry(
                          index,
                          SizedBox(
                            width: double.infinity,
                            child: CardUser(data: data),
                          ),
                        );
                      })
                      .values
                      .toList(),
                  carouselController: carouselController,
                  options: CarouselOptions(
                      viewportFraction: 0.95,
                      height: 210.h,
                      autoPlay: false,
                      enableInfiniteScroll: false,
                      initialPage: _currentIndex,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentIndex = index;
                        });
                      }),
                ),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:
                      accController.userAccModel.data!.asMap().entries.map(
                    (entry) {
                      return GestureDetector(
                        onTap: () =>
                            carouselController.animateToPage(entry.key),
                        child: Container(
                          width: _currentIndex == entry.key ? 20 : 7,
                          height: 7.0,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 3.0,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: _currentIndex == entry.key
                                ? Colors.white
                                : Colors.grey.shade400,
                          ),
                        ),
                      );
                    },
                  ).toList(),
                ),
                // ปุ่มที่ติดกับภาพเลื่อน
                SizedBox(height: 10.h),
                // card ด้านล่างทั้งหมด
                () {
                  setState(() {
                    userPayment = paymentController.userPayment.data!
                        .where((element) =>
                            element.customerId ==
                            accController
                                .userAccModel.data![_currentIndex].customerId)
                        .toList();
                  });
                  return (userPayment ?? []).isEmpty
                      ? Column(
                          children: [
                            SizedBox(
                              height: 20.h,
                            ),
                            Text(
                              'ไม่พบรายการชำระ 6 เดือนย้อนหลัง',
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.normal,
                                color: Colors.grey.shade700,
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            accController.userAccModel.data![_currentIndex]
                                        .companyId ==
                                    'CFAA'
                                ? Text(
                                    'หากมีข้อสงสัยกรุณาติดต่อ CallCenter : 02-826-5377',
                                    style: TextStyle(
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.grey.shade700,
                                    ),
                                  )
                                : accController.userAccModel
                                            .data![_currentIndex].companyId ==
                                        'RWAY'
                                    ? Text(
                                        'หากมีข้อสงสัยกรุณาติดต่อ CallCenter : 02-821-1055',
                                        style: TextStyle(
                                          fontSize: 17.sp,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.grey.shade700,
                                        ),
                                      )
                                    : Text(
                                        'หากมีข้อสงสัยกรุณาติดต่อ CallCenter : 02-857-5188',
                                        style: TextStyle(
                                          fontSize: 17.sp,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.grey.shade700,
                                        ),
                                      ),
                          ],
                        )
                      : Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 10.h,
                              horizontal: 10.w,
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                children: userPayment!.map((payment) {
                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 3.h,
                                    ),
                                    child: Card(
                                      clipBehavior: Clip.antiAlias,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      elevation: 2,
                                      color: Color.fromARGB(255, 250, 250, 250),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Column(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 15.w,
                                                  vertical: 5.h,
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'วันที่ชำระเงิน',
                                                      style: TextStyle(
                                                        color: Colors
                                                            .grey.shade600,
                                                        fontSize: 18.sp,
                                                      ),
                                                    ),
                                                    Text(
                                                      formattedDate(
                                                          payment.payDate!),
                                                      style: TextStyle(
                                                        color: Colors
                                                            .grey.shade600,
                                                        fontSize: 18.sp,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  vertical: 10,
                                                ),
                                                child: Container(
                                                  width: double.infinity,
                                                  height:
                                                      1, // กำหนดความสูงของเส้น
                                                  color: Colors.grey
                                                      .shade300, // กำหนดสีของเส้น
                                                ),
                                              ),

                                              // แสดงรายการ payAmount เฉพาะในรายการที่ payDate เหมือนกันแรก
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  vertical: 10,
                                                  horizontal: 15,
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'ยอดที่ชำระแล้ว :',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 18.sp,
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          thaiBahtFormat.format(
                                                              payment
                                                                  .payAmount),
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 18.sp,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 5.w,
                                                        ),
                                                        Text(
                                                          'บาท',
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 18.sp,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 5.w,
                                                        ),
                                                        // Text(
                                                        //   payment.receiveDate
                                                        //               .toString() ==
                                                        //           '1800-01-01T00:00:00.000Z'
                                                        //       ? 'รอดำเนินการ'
                                                        //       : '',
                                                        //   style: TextStyle(
                                                        //       fontSize: 16.sp,
                                                        //       color: Colors
                                                        //           .grey.shade600),
                                                        // ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        );
                }(),
              ],
            ),
          );
  }
}
