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
    double height = MediaQuery.of(context).size.height;
    return loading
        ? const SizedBox()
        : Column(
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
                          // child: Card(
                          //   clipBehavior: Clip.antiAlias,
                          //   shape: RoundedRectangleBorder(
                          //     borderRadius: BorderRadius.circular(24),
                          //   ),
                          //   elevation: 3,
                          //   child: Container(
                          //     decoration: const BoxDecoration(
                          //       image: DecorationImage(
                          //         image: AssetImage('assets/image/bgcard.png'),
                          //         fit: BoxFit.cover,
                          //       ),
                          //     ),
                          //     child: Padding(
                          //       padding: const EdgeInsets.symmetric(
                          //         horizontal: 18,
                          //       ),
                          //       child: Column(
                          //         mainAxisAlignment: MainAxisAlignment.center,
                          //         crossAxisAlignment: CrossAxisAlignment.start,
                          //         children: [
                          //           SizedBox(
                          //             child: Row(
                          //               mainAxisAlignment:
                          //                   MainAxisAlignment.spaceBetween,
                          //               children: [
                          //                 Column(
                          //                   crossAxisAlignment:
                          //                       CrossAxisAlignment.start,
                          //                   children: [
                          //                     Text(
                          //                       data.tCompanyName ==
                          //                               'บริษัท บริหารสินทรัพย์ ซีเอฟ เอเชีย จำกัด         '
                          //                           ? 'CF Asia Assets Management CO.,LTD.'
                          //                           : 'Resolution Way CO.,LTD.',
                          //                       style: const TextStyle(
                          //                         fontSize: 17,
                          //                         fontWeight: FontWeight.normal,
                          //                         height: 0.06,
                          //                         color: Color(0xFF5C5C5C),
                          //                         //color: Colors.grey.shade600,
                          //                       ),
                          //                     ),
                          //                     const SizedBox(
                          //                       height: 5,
                          //                     ),
                          //                     Text(
                          //                       data.tCompanyName,
                          //                       style: const TextStyle(
                          //                         fontSize: 17,
                          //                         fontWeight: FontWeight.normal,
                          //                         color: Color(0xFF5C5C5C),
                          //                       ),
                          //                     ),
                          //                   ],
                          //                 ),
                          //                 Column(
                          //                   children: [
                          //                     Image.asset(
                          //                       'assets/image/${data.companyId == 'CFAA' ? 'cfam.png' : 'rway.png'}',
                          //                       height: 20,
                          //                       fit: BoxFit.cover,
                          //                     ),
                          //                     const SizedBox(
                          //                       height: 15,
                          //                     )
                          //                   ],
                          //                 )
                          //               ],
                          //             ),
                          //           ),
                          //           const SizedBox(
                          //             height: 5,
                          //           ),
                          //           Column(
                          //             crossAxisAlignment:
                          //                 CrossAxisAlignment.start,
                          //             children: [
                          //               const Text(
                          //                 'ภาระหนี้คงเหลือ (บาท)',
                          //                 style: TextStyle(
                          //                   fontWeight: FontWeight.normal,
                          //                   fontSize: 18,
                          //                   height: 1.2,
                          //                   color: Colors.black,
                          //                 ),
                          //               ),
                          //               Text(
                          //                 thaiBahtFormat.format(data.osBalance),
                          //                 style: const TextStyle(
                          //                   fontSize: 30,
                          //                   fontWeight: FontWeight.w800,
                          //                   height: 1.2,
                          //                   color:
                          //                       Color.fromARGB(255, 9, 34, 33),
                          //                 ),
                          //               ),
                          //             ],
                          //           ),
                          //           const SizedBox(
                          //             height: 15,
                          //           ),
                          //           Row(
                          //             children: [
                          //               const Text(
                          //                 'Name : ',
                          //                 style: TextStyle(
                          //                   color: Color(0xFF8A8A8A),
                          //                   fontSize: 18,
                          //                   height: 1.2,
                          //                   fontWeight: FontWeight.normal,
                          //                 ),
                          //               ),
                          //               const SizedBox(
                          //                 width: 20,
                          //               ),
                          //               Text(
                          //                 '${data.tCustomerName}',
                          //                 style: const TextStyle(
                          //                   fontWeight: FontWeight.normal,
                          //                   fontSize: 20,
                          //                   height: 1.2,
                          //                 ),
                          //               ),
                          //               const SizedBox(
                          //                 width: 10,
                          //               ),
                          //               Text(
                          //                 '${data.tCustomerSurname}',
                          //                 style: const TextStyle(
                          //                   fontWeight: FontWeight.normal,
                          //                   fontSize: 20,
                          //                   height: 1.2,
                          //                 ),
                          //               ),
                          //             ],
                          //           ),
                          //           const SizedBox(
                          //             height: 5,
                          //           ),
                          //           Row(
                          //             children: [
                          //               const Text(
                          //                 'No Card : ',
                          //                 style: TextStyle(
                          //                   color: Color(0xFF8A8A8A),
                          //                   fontSize: 18,
                          //                   height: 1.1,
                          //                   fontWeight: FontWeight.normal,
                          //                 ),
                          //               ),
                          //               const SizedBox(
                          //                 width: 5,
                          //               ),
                          //               Text(
                          //                 '${data.customerId}',
                          //                 style: const TextStyle(
                          //                   fontWeight: FontWeight.normal,
                          //                   fontSize: 20,
                          //                   height: 1.1,
                          //                 ),
                          //               ),
                          //             ],
                          //           ),
                          //         ],
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ),
                      );
                    })
                    .values
                    .toList(),
                carouselController: carouselController,
                options: CarouselOptions(
                    viewportFraction: 0.93,
                    height: 220.h,
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
                children: accController.userAccModel.data!.asMap().entries.map(
                  (entry) {
                    return GestureDetector(
                      onTap: () => carouselController.animateToPage(entry.key),
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
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(height: 10.h,),
                          Text('หากมีข้อสงสัยกรุณาติดต่อ Call center 02-000-2032',style: TextStyle(
                            fontSize: 17.sp,
                            fontWeight: FontWeight.normal,
                            color: Colors.grey,
                          ),)
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
                                    color: const Color(0xFFF4F4F4),
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
                                                      color:
                                                          Colors.grey.shade600,
                                                      fontSize: 18.sp,
                                                    ),
                                                  ),
                                                  Text(
                                                    formattedDate(
                                                        payment.payDate!),
                                                    style: TextStyle(
                                                      color:
                                                          Colors.grey.shade600,
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
                                                            payment.payAmount),
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
          );
  }
}
