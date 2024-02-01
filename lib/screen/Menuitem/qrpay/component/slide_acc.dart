import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:mobile_chaseapp/component/card_user.dart';
import 'package:mobile_chaseapp/screen/Menuitem/qrpay/pay_from.dart';
import '../../../../controller/getacc_controller.dart';

class SlideAcc extends StatefulWidget {
  const SlideAcc({super.key});

  @override
  State<SlideAcc> createState() => _SlideAccState();
}

class _SlideAccState extends State<SlideAcc> {
  AccController accController = AccController();
  final CarouselController carouselController = CarouselController();
  int _currentIndex = 0;

  bool loading = true;

  final thaiBahtFormat = NumberFormat.currency(locale: 'th_TH', symbol: '');

  final formattedDate = DateFormat("yyyy-MM-dd");

  Future<void> fetchAccData() async {
    setState(() {
      loading = true;
    });
    try {
      await accController.fetchAccData();
      // Use the updated method that returns List<UserAccModel>
      loading = false;
      setState(() {});
    } catch (error) {
      print('Error fetching profile data: $error');
      // Handle error if fetching profile data fails
    }
  }

  @override
  void initState() {
    super.initState();
    fetchAccData(); // Fetch profile data when widget is initialized
  }

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    //double height = MediaQuery.of(context).size.height;
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
                          child: CardUser(
                            data: data,
                          ),
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
              SizedBox(
                height: 10.h,
              ),
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

              SizedBox(
                height: 10.h,
              ),
              // card ด้านล่างทั้งหมด
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.w,
                  vertical: 15.h,
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
                      if ((accController.userAccModel.data ?? [])
                          .isNotEmpty) ...[
                        SizedBox(
                          height: 20.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 10,
                            right: 10,
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  accController.userAccModel
                                              .data![_currentIndex].companyId ==
                                          'CORT'
                                      ? Text(
                                          'บริษัท คอร์ทส์ เม็กก้าสโตร์ (ประเทศไทย) จำกัด',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16.sp,
                                          ),
                                        )
                                      : Row(
                                          children: [
                                            Text(
                                              'ผู้รับโอนสิทธิ์ : ',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                color: Colors.grey.shade600,
                                                fontSize: 16.sp,
                                              ),
                                            ),
                                            accController
                                                        .userAccModel
                                                        .data![_currentIndex]
                                                        .companyId ==
                                                    'CFAA'
                                                ? Text(
                                                    'บริษัท บริหารสินทรัพย์ ซีเอฟ เอเชีย จำกัด',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 16.sp,
                                                    ),
                                                  )
                                                : Text(
                                                    'บริษัท รีโซลูชั่น เวย์ จำกัด',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 16.sp,
                                                    ),
                                                  ),
                                          ],
                                        ),
                                ],
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              Container(
                                width: double.infinity,
                                height: 1, // กำหนดความสูงของเส้น
                                color: Color.fromARGB(
                                    255, 207, 204, 204), // กำหนดสีของเส้น
                              ),
                              SizedBox(
                                height: 15.h,
                              ),

                              //ลบวันที่ผู้รับโอนสิทธ์

                              accController.userAccModel.data![_currentIndex]
                                          .tBuyFromName
                                          .trim() ==
                                      ''
                                  ? SizedBox.shrink()
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'ผู้โอนสิทธิ์ :',
                                          style: TextStyle(
                                            color: Colors.grey.shade600,
                                            fontSize: 17.sp,
                                          ),
                                        ),
                                        Text(
                                          accController.userAccModel
                                              .data![_currentIndex].tBuyFromName
                                              .trim(),
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16.sp,
                                          ),
                                        ),
                                      ],
                                    ),

                              SizedBox(
                                height: 10.h,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'วันที่ชำระล่าสุด :',
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 17.sp,
                                    ),
                                  ),
                                  accController
                                              .userAccModel
                                              .data![_currentIndex]
                                              .lastPayDate ==
                                          null
                                      ? Text(
                                          'ไม่พบข้อมูล',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16.sp,
                                          ),
                                        )
                                      : Text(
                                          formattedDate.format(
                                            DateTime.parse(accController
                                                .userAccModel
                                                .data![_currentIndex]
                                                .lastPayDate
                                                .toString()),
                                          ),
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16.sp,
                                          ),
                                        ),
                                ],
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'ยอดชำระครั้งล่าสุด (บาท) :',
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 17.sp,
                                    ),
                                  ),
                                  Text(
                                    thaiBahtFormat.format(accController
                                        .userAccModel
                                        .data![_currentIndex]
                                        .lastPayAmount),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              //ปุ่มชำระเงิน
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PayFrom(),
                    ),
                  );
                },
                style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all<Size>(
                    Size(270, 45),
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(
                    const Color(0xFF103533), // กำหนดสีพื้นหลังของปุ่ม
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(10), // กำหนดรัศมีของเส้นขอบปุ่ม
                    ),
                  ),
                ),
                child: Text(
                  'ชำระเงิน',
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          );
  }
}
