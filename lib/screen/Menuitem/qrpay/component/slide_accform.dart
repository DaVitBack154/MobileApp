import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:intl/intl.dart';
import 'package:mobile_chaseapp/component/card_user.dart';
import 'package:mobile_chaseapp/screen/Menuitem/history/history.dart';
import 'package:mobile_chaseapp/screen/Menuitem/qrpay/qr.dart';
import 'package:mobile_chaseapp/utils/my_constant.dart';
import '../../../../controller/getacc_controller.dart';

class SlideFrom extends StatefulWidget {
  const SlideFrom({super.key});

  @override
  State<SlideFrom> createState() => _SlideFromState();
}

class _SlideFromState extends State<SlideFrom> {
  final CarouselController carouselController = CarouselController();
  AccController accController = AccController();
  int _currentIndex = 0;

  bool loading = true;

  TextEditingController amountController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
      //print('Error fetching profile data: $error');
      // Handle error if fetching profile data fails
    }
  }

  @override
  void initState() {
    super.initState();
    fetchAccData();
  }

  @override
  Widget build(BuildContext context) {
    // double height = MediaQuery.of(context).size.height;
    return loading
        ? const SizedBox()
        : SingleChildScrollView(
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
                      height: 200.h,
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
                  height: 5.h,
                ),

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

                SizedBox(
                  height: 20.h,
                ),
                //ในส่วน กรอก จำนวนเงิน ด้านล่าง
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 15.h,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'รูปแบบการจ่าย',
                            style: TextStyle(
                              fontSize: 21.sp,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          InkWell(
                            child: Container(
                              width: 150.w,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: Colors.grey.shade300,
                                ),
                                borderRadius: BorderRadius.circular(29),
                                color: Colors.grey.shade100,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      'ประวัติการชำระเงิน',
                                      style: TextStyle(
                                        color: Colors.grey.shade500,
                                        fontSize: 17.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Image.asset(
                                      'assets/image/icon3.png',
                                      height: 30,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const History(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              FocusScope.of(context).unfocus();
                            },
                            child: Form(
                              key: _formKey,
                              child: TextFormField(
                                controller: amountController,
                                decoration: InputDecoration(
                                  border: const UnderlineInputBorder(),
                                  labelText: "ชำระเงิน",
                                  labelStyle: TextStyle(
                                    color: Colors.grey.shade700,
                                  ),
                                  suffixText: 'บาท',
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  hintText: 'ยอดชำระ',
                                  hintStyle: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey), // สีเมื่อไม่ Focus
                                  ),
                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFF103533),
                                    ), // สีเมื่อ Focus
                                  ),
                                ),
                                cursorColor: Colors.grey.shade400,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'กรุณากรอกจำนวนเงิน';
                                  } else if (value.length < 2) {
                                    return 'กรุณากรอกจำนวนเงิน';
                                  }
                                  setState(() {});
                                  return null;
                                },
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        signed: true, decimal: true),
                                style: TextStyle(fontSize: 20.sp),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => QRPayment(
                                      amount: amountController.text,
                                      customerId: accController.userAccModel
                                          .data![_currentIndex].customerId,
                                      psersonalId: accController.userAccModel
                                          .data![_currentIndex].personalId,
                                      taxId: accController.userAccModel
                                          .data![_currentIndex].companyTaxId,
                                    ),
                                  ),
                                );
                              }
                              setState(() {});
                            },
                            style: ButtonStyle(
                              fixedSize: MaterialStateProperty.all<Size>(
                                Size(250, 40),
                              ),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                Color(0xFF103533), // กำหนดสีพื้นหลังของปุ่ม
                              ),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      10), // กำหนดรัศมีของเส้นขอบปุ่ม
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
                          // SizedBox(height: 200,),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}
