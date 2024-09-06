import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_chaseapp/component/card_user.dart';
import 'package:mobile_chaseapp/controller/user_req_controller.dart';
import 'package:mobile_chaseapp/screen/Menuitem/req_doc/req_doc_userfrom.dart';
import 'package:mobile_chaseapp/utils/my_constant.dart';
import 'package:mobile_chaseapp/utils/responsive_heigth__context.dart';
import 'package:mobile_chaseapp/utils/responsive_width__context.dart';
import '../../../../controller/getacc_controller.dart';

class ReqDocumentFrom extends StatefulWidget {
  const ReqDocumentFrom({super.key});

  @override
  State<ReqDocumentFrom> createState() => _ReqDocumentFromState();
}

class _ReqDocumentFromState extends State<ReqDocumentFrom> {
  AccController accController = AccController();
  UserReqController userReqController = UserReqController();
  CarouselSliderController carouselController = CarouselSliderController();
  int _currentIndex = 0;
  final _formKey = GlobalKey<FormState>();
  String? errorOther;
  bool loading = true;

  String? choseRadio = 'ใบเสร็จรับเงิน';

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
    fetchAccData();
  }

  @override
  Widget build(BuildContext context) {
    // double height = MediaQuery.of(context).size.height;
    return loading
        ? const SizedBox()
        : Stack(
            children: [
              Column(
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
                        viewportFraction: 0.93,
                        height:
                            ResponsiveWidthContext.isMobileFoldVertical(context)
                                ? 200.h
                                : 190.h,
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
                            width: _currentIndex == entry.key ? 25 : 7,
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
                    height: 15.h,
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: kToolbarHeight + 190).h,
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20.w,
                              vertical: 5.h,
                            ),
                            child: Text(
                              'โปรดระบุเอกสารที่ต้องการ',
                              style: TextStyle(
                                color: const Color(0xFF5C5C5C),
                                fontSize:
                                    MyConstant.setMediaQueryWidth(context, 27),
                                fontWeight: FontWeight.w400,
                                height: 1.51,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.w, vertical: 3.h),
                        child: Column(
                          children: [
                            Card(
                              elevation: 1,
                              child: RadioListTile(
                                title: Row(
                                  children: [
                                    Image.asset(
                                      'assets/image/receipt.png',
                                      height: 25.h,
                                    ),
                                    SizedBox(
                                      width: 30.w,
                                    ),
                                    Text(
                                      'ใบเสร็จรับเงิน',
                                      style: TextStyle(
                                        fontSize: MyConstant.setMediaQueryWidth(
                                            context, 25),
                                        fontWeight: FontWeight.w400,
                                        height: 0.71,
                                      ),
                                    ),
                                  ],
                                ),
                                value: 'ใบเสร็จรับเงิน',
                                groupValue: choseRadio,
                                onChanged: (value) {
                                  setState(() {
                                    choseRadio = value.toString();
                                  });
                                },
                                activeColor: Colors.teal.shade700,
                              ),
                            ),
                            Visibility(
                              visible: accController.userAccModel
                                      .data![_currentIndex].flagCode
                                      .toString() ==
                                  'CLS',
                              child: Card(
                                elevation: 1,
                                child: RadioListTile(
                                  title: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Image.asset('assets/image/closebg2.png',
                                          height: 25.h),
                                      SizedBox(width: 30.w),
                                      Text(
                                        'หนังสือปิดบัญชี',
                                        style: TextStyle(
                                          fontSize:
                                              MyConstant.setMediaQueryWidth(
                                                  context, 25),
                                          fontWeight: FontWeight.w400,
                                          height: 0.71,
                                        ),
                                      ),
                                    ],
                                  ),
                                  value: 'หนังสือปิดบัญชี',
                                  groupValue: choseRadio,
                                  onChanged: (value) {
                                    setState(() {
                                      choseRadio = value.toString();
                                    });
                                  },
                                  activeColor: Colors.teal.shade700,
                                ),
                              ),
                            ),
                            Card(
                              elevation: 1,
                              child: RadioListTile(
                                title: Row(
                                  children: [
                                    Image.asset(
                                      'assets/image/edit2.png',
                                      height: 25.h,
                                    ),
                                    SizedBox(
                                      width: 30.w,
                                    ),
                                    Text(
                                      'อื่นๆ',
                                      style: TextStyle(
                                        fontSize: MyConstant.setMediaQueryWidth(
                                            context, 25),
                                        fontWeight: FontWeight.w400,
                                        height: 0.71,
                                      ),
                                    ),
                                  ],
                                ),
                                value: 'เอกสารอื่นๆ',
                                groupValue: choseRadio,
                                onChanged: (value) {
                                  setState(() {
                                    choseRadio = value.toString();
                                  });
                                },
                                activeColor: Colors.teal.shade700,
                              ),
                            ),
                            choseRadio == 'เอกสารอื่นๆ'
                                ? Form(
                                    key: _formKey,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        TextFormField(
                                          maxLines: null,
                                          controller:
                                              userReqController.otherController,
                                          decoration: InputDecoration(
                                            labelText:
                                                'กรุณาระบุเอกสารที่ต้องการ',
                                            labelStyle: TextStyle(
                                              color: Colors.black,
                                              fontSize:
                                                  MyConstant.setMediaQueryWidth(
                                                      context, 20),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey
                                                      .shade300), // เส้นขอบเมื่อไม่ได้รับการโฟกัส
                                            ),
                                            focusedBorder:
                                                const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors
                                                      .grey), // เส้นขอบเมื่อได้รับการโฟกัส
                                            ),
                                          ),
                                          style: TextStyle(
                                            fontSize:
                                                MyConstant.setMediaQueryWidth(
                                                    context, 20),
                                          ),
                                          cursorColor: Colors.grey.shade400,
                                          textInputAction: TextInputAction.done,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty ||
                                                value.length <= 3) {
                                              return 'กรุณากรอกข้อความ';
                                            }
                                            setState(() {});
                                            return null; // ส่งค่า null ถ้าข้อมูลถูกต้อง
                                          },
                                        ),
                                      ],
                                    ),
                                  )
                                : const SizedBox.shrink()
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (choseRadio == 'เอกสารอื่นๆ') {
                            if (_formKey.currentState!.validate()) {
                              String callcenterNumber = '';
                              if (accController.userAccModel
                                      .data![_currentIndex].companyId ==
                                  'CFAA') {
                                callcenterNumber = '02-826-5377';
                              } else if (accController.userAccModel
                                      .data![_currentIndex].companyId ==
                                  'RWAY') {
                                callcenterNumber = '02-821-1055';
                              } else {
                                callcenterNumber = '02-857-5188';
                              }

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ReqDocFromUser(
                                      documentChose: choseRadio,
                                      customerId: accController.userAccModel
                                          .data![_currentIndex].customerId,
                                      other: userReqController
                                          .otherController.text,
                                      callcenter: callcenterNumber),
                                ),
                              );
                            }
                          } else {
                            String callcenterNumber = '';
                            if (accController.userAccModel.data![_currentIndex]
                                    .companyId ==
                                'CFAA') {
                              callcenterNumber = '02-826-5377';
                            } else if (accController.userAccModel
                                    .data![_currentIndex].companyId ==
                                'RWAY') {
                              callcenterNumber = '02-821-1055';
                            } else {
                              callcenterNumber = '02-857-5188';
                            }
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ReqDocFromUser(
                                    documentChose: choseRadio,
                                    customerId: accController.userAccModel
                                        .data![_currentIndex].customerId,
                                    other:
                                        userReqController.otherController.text,
                                    callcenter: callcenterNumber),
                              ),
                            );
                          }
                        },
                        style: ButtonStyle(
                          fixedSize: MaterialStateProperty.all<Size>(
                            Size(
                              320.w,
                              MyConstant.setMediaQueryWidth(context, 40),
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xFF103533), // กำหนดสีพื้นหลังของปุ่ม
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  10), // กำหนดรัศมีของเส้นขอบปุ่ม
                            ),
                          ),
                        ),
                        child: Text(
                          'ถัดไป',
                          style: TextStyle(
                            fontSize:
                                MyConstant.setMediaQueryWidth(context, 25),
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
  }
}
