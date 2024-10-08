import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_chaseapp/component/card_user.dart';
import 'package:mobile_chaseapp/controller/getprofile_controller.dart';
import 'package:mobile_chaseapp/controller/update_controller.dart';
import 'package:mobile_chaseapp/controller/userpay_controller.dart';
import 'package:mobile_chaseapp/model/respon_payuser.dart';
import 'package:mobile_chaseapp/screen/Menuitem/history/history.dart';
import 'package:mobile_chaseapp/screen/Menuitem/qrpay/qr.dart';
import 'package:mobile_chaseapp/utils/key_storage.dart';
import 'package:mobile_chaseapp/utils/my_constant.dart';
import 'package:mobile_chaseapp/utils/responsive_heigth__context.dart';
import 'package:mobile_chaseapp/utils/responsive_width__context.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../controller/getacc_controller.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class SlideFrom extends StatefulWidget {
  final int currentIndex;
  const SlideFrom({Key? key, required this.currentIndex}) : super(key: key);

  @override
  State<SlideFrom> createState() => _SlideFromState();
}

class _SlideFromState extends State<SlideFrom> {
  CarouselSliderController carouselController = CarouselSliderController();
  AccController accController = AccController();
  final _updateController = UpdateController();
  UserPayController userPayController = UserPayController();
  int _currentIndex = 0;

  bool loading = true;

  final FocusNode _yourFocusNode = FocusNode();
  TextEditingController amountController = TextEditingController();
  final ProfileController profileController = ProfileController();

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
    _currentIndex = widget.currentIndex;
    fetchAccData();
  }

  @override
  Widget build(BuildContext context) {
    // double height = MediaQuery.of(context).size.height;
    return KeyboardActions(
      config: KeyboardActionsConfig(
        keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
        actions: [
          KeyboardActionsItem(
            focusNode: _yourFocusNode,
            toolbarButtons: [
              (node) {
                return GestureDetector(
                  onTap: () => node.unfocus(),
                  child: const Padding(
                    padding: EdgeInsets.only(
                      right: 20,
                    ),
                    child: Text(
                      "เสร็จ",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                );
              },
            ],
          ),
        ],
      ),
      child: loading
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
                            width: _currentIndex == entry.key
                                ? MyConstant.setMediaQueryWidth(context, 20)
                                : 7,
                            height: 8.0,
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
                    height: ResponsiveWidthContext.isMobileFoldVertical(context)
                        ? 50.h
                        : ResponsiveWidthContext.isMobile(context) ||
                                ResponsiveWidthContext.isMobileSmall(context)
                            ? 32.h
                            : 20.h,
                  ),
                  //ในส่วน กรอก จำนวนเงิน ด้านล่าง
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'แบบฟอร์มชำระเงิน',
                              style: TextStyle(
                                fontSize:
                                    MyConstant.setMediaQueryWidth(context, 22),
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            InkWell(
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.grey.shade300,
                                  ),
                                  borderRadius: BorderRadius.circular(29),
                                  color: Colors.grey.shade200,
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
                                          fontSize: ResponsiveWidthContext
                                                  .isMobileFoldVertical(context)
                                              ? MyConstant.setMediaQueryWidth(
                                                  context, 22)
                                              : ResponsiveWidthContext.isMobile(
                                                          context) ||
                                                      ResponsiveWidthContext
                                                          .isMobileSmall(
                                                              context)
                                                  ? MyConstant
                                                      .setMediaQueryWidth(
                                                          context, 21)
                                                  : MyConstant
                                                      .setMediaQueryWidth(
                                                          context, 25),
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Image.asset(
                                        'assets/image/icon3.png',
                                        height: 27,
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
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 30.h,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          String token =
                              prefs.getString(KeyStorage.token) ?? '';
                          await profileController.fetchProfileData(token);

                          if (profileController.userModel.user?.starPoint ==
                                  '' ||
                              profileController.userModel.user?.starPoint ==
                                  null) {
                            await _updateController.fetchUpdateProfile(
                              statusStar: 'Y',
                            );
                            // print(
                            //     'tokota-> ${profileController.userModel.user?.starPoint}');
                          } else {
                            print('ให้คะแนนแล้ว');
                          }

                          Payuser? payuser =
                              await userPayController.createUserPay(
                            customerId: accController
                                .userAccModel.data![_currentIndex].customerId
                                .toString(),
                            idCard: accController
                                .userAccModel.data![_currentIndex].personalId
                                .toString(),
                            name: accController
                                .userAccModel.data![_currentIndex].tCustomerName
                                .toString(),
                            surname: accController.userAccModel
                                .data![_currentIndex].tCustomerSurname
                                .toString(),
                            company: accController
                                .userAccModel.data![_currentIndex].companyId
                                .toString(),
                            status: 'ขอแบบฟอร์มชำระเงิน',
                          );

                          if (payuser != null && payuser.data != null) {
                            Data data = payuser.data;
                            // แสดงข้อมูลที่ต้องการจาก data
                            print(
                                'บันทึกข้อมูลผู้ใช้สำเร็จ: ${data.name} ${data.surname}');
                          } else {
                            print('กรุณากรอกข้อมูลที่อยู่ให้ถูกต้อง');
                          }

                          String taxid = '';
                          if (accController.userAccModel.data![_currentIndex]
                                  .companyId ==
                              'CFAA') {
                            taxid = '0135555007263';
                          } else if (accController.userAccModel
                                  .data![_currentIndex].companyId ==
                              'RWAY') {
                            taxid = '0105546031394';
                          } else {
                            taxid = '0105545083871';
                          }
                          // ignore: use_build_context_synchronously
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => QRPayment(
                                amount: "0",
                                customerId: accController.userAccModel
                                    .data![_currentIndex].customerId,
                                psersonalId: accController.userAccModel
                                    .data![_currentIndex].personalId,
                                tCustomerName: accController.userAccModel
                                    .data![_currentIndex].tCustomerName,
                                tCustomerSurname: accController.userAccModel
                                    .data![_currentIndex].tCustomerSurname,
                                companyId: accController.userAccModel
                                    .data![_currentIndex].companyId,
                                taxId: taxid,
                              ),
                            ),
                          );

                          setState(() {});
                        },
                        style: ButtonStyle(
                          fixedSize: MaterialStateProperty.all<Size>(
                            Size(
                              270,
                              MyConstant.setMediaQueryWidth(context, 45),
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Color(0xFF103533), // กำหนดสีพื้นหลังของปุ่ม
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
                          'ขอแบบฟอร์มชำระเงิน',
                          style: TextStyle(
                            fontSize:
                                MyConstant.setMediaQueryWidth(context, 26),
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      // SizedBox(height: 200,),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
