import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:mobile_chaseapp/component/bottombar.dart';
import 'package:mobile_chaseapp/component/textfield.dart';
import 'package:mobile_chaseapp/config/app_info.dart';
import 'package:mobile_chaseapp/controller/getdate_server.dart';
import 'package:mobile_chaseapp/controller/getpayment_controller.dart';
import 'package:mobile_chaseapp/controller/getprofile_controller.dart';
import 'package:mobile_chaseapp/controller/user_req_controller.dart';
import 'package:mobile_chaseapp/model/respon_payment.dart';
import 'package:mobile_chaseapp/screen/Menuitem/req_doc/component/req_format.dart';
import 'package:mobile_chaseapp/utils/key_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

class ReqDocFromUser extends StatefulWidget {
  const ReqDocFromUser({
    Key? key,
    this.documentChose,
    this.customerId,
    this.other,
    this.callcenter,
  }) : super(key: key);

  final String? documentChose; // รับค่าที่ส่งมาจากหน้าก่อนหน้า
  final String? customerId; // รับค่าที่ส่งมาจากหน้าก่อนหน้า
  final String? other;
  final String? callcenter;

  @override
  State<ReqDocFromUser> createState() => _ReqDocFromUserState();
}

class _ReqDocFromUserState extends State<ReqDocFromUser> {
  final PaymentController paymentController = PaymentController();
  final UserReqController userReqController = UserReqController();
  final DateServerController dateController = DateServerController();
  final ProfileController profileController = ProfileController();

  bool loading = true;
  var dateServer = '';
  List<Data>? userPayment = [];

  Data? selectedPayment;
  String? currentValue = '';
  List<dynamic> monthlist = [];
  List<dynamic> defaultDate = mymonth;
  String? convertMonth = '';
  final formattedPayDate = DateFormatter.formatDate('20230831');

  //ในส่วนรูปแบบการส่ง
  final _formKey = GlobalKey<FormState>();
  String? errorTextaddress;
  String? chosesentRadio = 'ส่งแบบอีเมล';
  List provin = PROVINCE;
  List district = [];
  List subdistrict = [];
  List postcode = [];
  String? currentProvin;
  String? currentDistrict;
  String? currentSubdistrict;
  String? currentPostcode;
  String? nameProvin;
  String? nameDistrict;
  String? nameSubdistrict;
  String? namePostcode;
  //store===========
  String? email;
  String? name;
  String? surname;
  String? idCard;
  //เชคการเลือกว่าเลือก ใบเสร็จอันไหน
  bool? isSelectedReceiptNo;
  // ค่าใบเสร็จที่เลือก
  String? dataReceiptNo;
  Future<void> fetchPaymentData() async {
    setState(() {
      loading = true;
    });
    try {
      final prefs = await SharedPreferences.getInstance();
      String token = prefs.getString(KeyStorage.token) ?? '';
      email = prefs.getString(KeyStorage.email);
      name = prefs.getString(KeyStorage.name);
      surname = prefs.getString(KeyStorage.surname);
      idCard = prefs.getString(KeyStorage.idCard);
      await paymentController.fetchPaymentData();
      await dateController.fetchDateServer();
      await profileController.fetchProfileData(token);
      setState(() {
        dateServer = dateController.dateServer.data.toString();
        //print(dateServer);
        if (dateServer != '') {
          generateMonthsList();
        }
      });
      //debugPrint('userPayment: ${userPayment!.toString()}');
      loading = false;
      setState(() {});
    } catch (error) {
      //print('เกิดข้อผิดพลาดในการดึงข้อมูล: $error');
    }
  }

  generateMonthsList() {
    print('now =>' + dateServer.toString());
    // _dateServer = '2025-03-04 22:41:36';
    final currentYear = int.parse(dateServer.toString().substring(0, 4));
    //currentValue = currentYear.toString() + dateServer.toString().substring(5, 7);
    // print(currentValue!);
    for (int i = 0; i < 6; i++) {
      int newMonth = int.parse(dateServer.toString().substring(5, 7)) - i;
      // print('newMonth=>' + newMonth.toString());
      for (var m in defaultDate) {
        if (int.parse(m["id"].toString()) ==
            (newMonth <= 0 ? newMonth + 12 : newMonth)) {
          print('i==' + i.toString() + ' newmonth ' + newMonth.toString());
          var yyyymm;
          yyyymm = newMonth > 0
              ? currentYear.toString()
              : (currentYear - 1).toString();
          yyyymm = yyyymm +
              ('0${m["id"]}').substring(
                  ('0${m["id"]}').length - 2, ('0${m["id"]}').length);
          monthlist.add({
            "id": yyyymm,
            "name":
                '${m["name"].toString()} ${newMonth > 0 ? currentYear.toString() : currentYear - 1}'
          });
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    fetchPaymentData();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final thaiBahtFormat = NumberFormat.currency(locale: 'th_TH', symbol: '');
    final query = MediaQuery.of(context);

    return MediaQuery(
      data: query.copyWith(
        // ignore: deprecated_member_use
        textScaler: TextScaler.linear(query.textScaleFactor.clamp(1.0, 1.0)),
      ),
      child: Scaffold(
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
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                            SizedBox(
                              width: 25.w,
                            ),
                            Text(
                              'รายการขอเอกสาร',
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
            Container(
              width: width,
              margin: const EdgeInsets.only(top: kToolbarHeight + 80).h,
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 5.h,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 10.h,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'เลขที่สัญญา : ',
                                  style: TextStyle(
                                    color: Colors.grey.shade500,
                                    fontSize: 19.sp,
                                    fontWeight: FontWeight.w400,
                                    height: 1.51,
                                  ),
                                ),
                                SizedBox(
                                  width: 15.w,
                                ),
                                Text(
                                  '${widget.customerId}',
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w500,
                                    height: 1.51,
                                  ),
                                ),
                              ],
                            ),

                            Row(
                              children: [
                                Text(
                                  'หัวข้อเอกสาร : ',
                                  style: TextStyle(
                                    color: Colors.grey.shade500,
                                    fontSize: 19.sp,
                                    fontWeight: FontWeight.w400,
                                    height: 1.51,
                                  ),
                                ),
                                SizedBox(
                                  width: 15.w,
                                ),
                                Text(
                                  '${widget.documentChose}',
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w500,
                                    height: 1.51,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            //รอส่ง other เข้ามา

                            //ในส่วนการ ส่งค่ามาว่า user เลือก อะไรมา
                            widget.documentChose == 'ใบเสร็จรับเงิน'
                                ? Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            'กรุณาเลือกใบเสร็จย้อนหลัง 6 เดือน',
                                            style: TextStyle(
                                              color: Color(0xFF5C5C5C),
                                              fontSize: 19.sp,
                                              fontWeight: FontWeight.w400,
                                              height: 1.51,
                                            ),
                                          ),
                                        ],
                                      ),

                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      selectTypemonth(),
                                      SizedBox(
                                        height: 10.h,
                                      ),

                                      //card ด้านล่างทั้งหมด
                                      () {
                                        setState(() {
                                          if (paymentController
                                                  .userPayment.data !=
                                              null) {
                                            userPayment = paymentController
                                                .userPayment.data!
                                                .where((element) =>
                                                    element.customerId ==
                                                        widget.customerId &&
                                                    currentValue ==
                                                        (element.payDate)
                                                            .toString()
                                                            .substring(0, 6) &&
                                                    (element.receiptNo)
                                                            .toString() !=
                                                        'ยังไม่พบข้อมูล')
                                                .toList();
                                          } else {
                                            userPayment =
                                                []; //หรือวิธีการอื่น ๆ ที่เหมาะสมสำหรับสถานการณ์ของคุณ
                                          }
                                        });
                                        return (userPayment ?? []).isEmpty &&
                                                currentValue != ''
                                            ? Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        'ไม่พบข้อมูลการชำระเงินภายในเดือนนี้',
                                                        style: TextStyle(
                                                          color: Colors
                                                              .red.shade500,
                                                          fontSize: 18.sp,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          height: 1.51,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              )
                                            : Column(
                                                children: userPayment!
                                                    .map(
                                                      (payment) =>
                                                          (currentValue !=
                                                                  convertMonth)
                                                              ? Column(
                                                                  children: [
                                                                    Card(
                                                                      clipBehavior:
                                                                          Clip.antiAlias,
                                                                      shape:
                                                                          RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(5),
                                                                      ),
                                                                      elevation:
                                                                          2,
                                                                      color: Colors
                                                                          .white,
                                                                      child:
                                                                          RadioListTile(
                                                                        title:
                                                                            Text(
                                                                          DateFormatter.formatDate(
                                                                              payment.payDate!),
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                19.sp,
                                                                            fontWeight:
                                                                                FontWeight.normal,
                                                                          ),
                                                                        ),
                                                                        //title: Text(payment.payDate!,sty),
                                                                        value:
                                                                            payment,
                                                                        groupValue:
                                                                            selectedPayment,
                                                                        onChanged:
                                                                            (value) {
                                                                          setState(
                                                                              () {
                                                                            selectedPayment =
                                                                                value;
                                                                            dataReceiptNo =
                                                                                payment.receiptNo;
                                                                            isSelectedReceiptNo =
                                                                                true;
                                                                          });
                                                                        },
                                                                        activeColor: Colors
                                                                            .teal
                                                                            .shade700,
                                                                        subtitle:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Text(
                                                                              'ยอดที่ชำระแล้ว',
                                                                              style: TextStyle(
                                                                                fontWeight: FontWeight.normal,
                                                                                fontSize: 19.sp,
                                                                                color: Colors.grey.shade700,
                                                                              ),
                                                                            ),
                                                                            Row(
                                                                              children: [
                                                                                Text(
                                                                                  thaiBahtFormat.format(payment.payAmount),
                                                                                  style: TextStyle(
                                                                                    fontWeight: FontWeight.normal,
                                                                                    fontSize: 19.sp,
                                                                                    color: Colors.grey.shade700,
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  width: 10.w,
                                                                                ),
                                                                                Text(
                                                                                  'บาท',
                                                                                  style: TextStyle(
                                                                                    fontWeight: FontWeight.normal,
                                                                                    fontSize: 19.sp,
                                                                                    color: Colors.grey.shade700,
                                                                                  ),
                                                                                )
                                                                              ],
                                                                            )

                                                                            //ค่านี้คือเดือน ค่ามันคือเลขที่สัญญา filชื่อ receiptNo  ในบอกที่หน้าจอ  ค่านี้อยู่ไหน
                                                                            // Text(payment.receiptNo.toString()) //R000000001
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                )
                                                              : const SizedBox(),
                                                    )
                                                    .toList(), //พิ่ม .toList()
                                              );
                                      }(),
                                      //card ด้านล่างทั้งหมด
                                      (isSelectedReceiptNo ?? true) != true
                                          ? Row(
                                              children: [
                                                Text(
                                                  'กรุณาเลือกใบเสร็จที่ต้องการ',
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontSize: 19.sp),
                                                ),
                                              ],
                                            )
                                          : const SizedBox(),
                                    ],
                                  )
                                : widget.documentChose == 'หนังสือปิดบัญชี'
                                    ? const SizedBox.shrink()
                                    : SizedBox(
                                        width: width,
                                        child: Card(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              widget.other ?? 'tdfdf',
                                              style: TextStyle(
                                                fontSize: 20.sp,
                                                fontWeight: FontWeight.w500,
                                                height: 1.51,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),

                            //ในส่วนการ ส่งค่ามาว่า user เลือก อะไรมา
                            SizedBox(
                              height: 10.h,
                            ),
                            Row(
                              children: [
                                Text(
                                  'รูปแบบการส่งเอกสาร',
                                  style: TextStyle(
                                    fontSize: 19.sp,
                                    fontWeight: FontWeight.w500,
                                    height: 1.51,
                                    color: Color(0xFF5C5C5C),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              'รายการขอเอกสารจะมีระยะเวลาในวันทำการ 7 วันทำการ',
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 18.sp,
                              ),
                            ),
                            Text(
                              'หากมีข้อสงสัย ติดต่อ Callcenter : ${widget.callcenter}',
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 18.sp,
                              ),
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            Column(
                              children: [
                                Card(
                                  child: RadioListTile(
                                    title: Row(
                                      children: [
                                        Image.asset(
                                          'assets/image/mailreq.png',
                                          height: 25.h,
                                        ),
                                        SizedBox(
                                          width: 20.w,
                                        ),
                                        Text(
                                          email.toString(),
                                          style: TextStyle(
                                            fontSize: 19.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                    value: 'ส่งแบบอีเมล',
                                    groupValue: chosesentRadio,
                                    onChanged: (value) {
                                      setState(() {
                                        chosesentRadio = value.toString();
                                        provin = PROVINCE;
                                        district = [];
                                        subdistrict = [];
                                        postcode = [];
                                        currentProvin = '';
                                        currentDistrict = '';
                                        currentSubdistrict = '';
                                        currentPostcode = '';
                                      });
                                    },
                                    activeColor: Colors.teal.shade700,
                                  ),
                                ),
                                Card(
                                  child: RadioListTile(
                                    title: Row(
                                      children: [
                                        Image.asset(
                                          'assets/image/iconaddress.png',
                                          height: 25.h,
                                        ),
                                        SizedBox(
                                          width: 20.w,
                                        ),
                                        Text(
                                          'จัดส่งตามที่อยู่ปัจจุบัน',
                                          style: TextStyle(
                                            fontSize: 19.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                    value: 'ส่งแบบที่อยู่อาศัย',
                                    groupValue: chosesentRadio,
                                    onChanged: (value) {
                                      setState(() {
                                        chosesentRadio = value.toString();
                                      });
                                    },
                                    activeColor: Colors.teal.shade700,
                                  ),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                if (chosesentRadio == 'ส่งแบบที่อยู่อาศัย')
                                  //ถ้ามีข้อมูล ที่อยู่แล้วไม่ต้องกรอก ฟอร์มใหม่
                                  profileController.userModel.user
                                              ?.sentAddressuser !=
                                          null
                                      ? Card(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                              left: 15,
                                              right: 10,
                                              top: 10,
                                              bottom: 10,
                                            ).h,
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      profileController
                                                              .userModel
                                                              .user
                                                              ?.sentAddressuser ??
                                                          'ไม่พบข้อมูลที่อยู่',
                                                      style: TextStyle(
                                                        fontSize: 18.sp,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      'เขต : ',
                                                      style: TextStyle(
                                                        fontSize: 18.sp,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                    ),
                                                    Text(
                                                      profileController
                                                              .userModel
                                                              .user
                                                              ?.subdistrict ??
                                                          'ยังไม่พบข้อมูลเขต',
                                                      style: TextStyle(
                                                        fontSize: 18.sp,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10.w,
                                                    ),
                                                    Text(
                                                      'แขวง : ',
                                                      style: TextStyle(
                                                        fontSize: 18.sp,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                    ),
                                                    Text(
                                                      profileController
                                                              .userModel
                                                              .user
                                                              ?.district ??
                                                          'ยังไม่พบข้อมูลแขวง',
                                                      style: TextStyle(
                                                        fontSize: 18.sp,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      'จังหวัด : ',
                                                      style: TextStyle(
                                                        fontSize: 18.sp,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                    ),
                                                    Text(
                                                      profileController
                                                              .userModel
                                                              .user
                                                              ?.provin ??
                                                          'ยังไม่พบข้อมูลจังหวัด',
                                                      style: TextStyle(
                                                        fontSize: 18.sp,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10.w,
                                                    ),
                                                    Text(
                                                      profileController
                                                              .userModel
                                                              .user
                                                              ?.postcode ??
                                                          'ยังไม่พบข้อมูลรหัสไปรษณีย์',
                                                      style: TextStyle(
                                                        fontSize: 18.sp,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      // userReqController
                                      : Form(
                                          key: _formKey,
                                          child: Column(
                                            children: [
                                              textField(
                                                'บ้านเลขที่ / ซอย / หมู่ / ถนน',
                                                controller: userReqController
                                                    .sentAddressuserController,
                                                hintStyle: TextStyle(
                                                  fontSize: 19.sp,
                                                  color: Colors.grey.shade500,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                                fillColor: Colors.white,
                                                autoFocus: false,
                                                contentPadding:
                                                    const EdgeInsets.all(10),
                                                errorText: errorTextaddress,
                                                onChanged: (value) {
                                                  value.isEmpty ||
                                                          value.length < 5
                                                      ? errorTextaddress =
                                                          'กรุณากรอกที่อยู่ให้ครบถ้วน'
                                                      : errorTextaddress = null;
                                                  setState(() {});
                                                },
                                              ),
                                              SizedBox(
                                                height: 10.h,
                                              ),
                                              selectPovinType(),
                                              SizedBox(
                                                height: 10.h,
                                              ),
                                              selectDistrict(),
                                              SizedBox(
                                                height: 10.h,
                                              ),
                                              selectSubdistrict(),
                                              SizedBox(
                                                height: 10.h,
                                              ),
                                              selectPostcode(),
                                            ],
                                          ),
                                        ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    if (widget.documentChose ==
                                        'ใบเสร็จรับเงิน') {
                                      if (dataReceiptNo != null) {
                                        setState(() {
                                          isSelectedReceiptNo = true;
                                        });

                                        print(
                                            'เคสออกมาได้แล้ว: $chosesentRadio');
                                        if (chosesentRadio == 'ส่งแบบอีเมล') {
                                          String result =
                                              await userReqController
                                                  .fetchUserReq(
                                            name: name.toString(),
                                            surname: surname.toString(),
                                            idCard: idCard.toString(),
                                            noContract: widget.customerId!,
                                            listReq: widget.documentChose!,
                                            // other: widget.other ??
                                            //     userReqController
                                            //         .otherController.text,
                                            receiveNo: dataReceiptNo!,
                                            sentEmailuser: email,
                                          );
                                          if (result.isNotEmpty) {
                                            // ignore: use_build_context_synchronously
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(result),
                                              ),
                                            );
                                            return;
                                          }
                                        } else if (chosesentRadio ==
                                            'ส่งแบบที่อยู่อาศัย') {
                                          // _formKey.currentState!.validate();
                                          print('object-------');
                                          print(profileController
                                              .userModel.user?.sentAddressuser);
                                          if (profileController.userModel.user
                                                  ?.sentAddressuser !=
                                              null) {
                                            print('Check value 4: $nameProvin');

                                            // if (nameProvin == null ||
                                            //     nameProvin!.isEmpty) {
                                            //   print('this condition');
                                            //   return;
                                            // }

                                            String result =
                                                await userReqController
                                                    .fetchUserReq(
                                              name: name.toString(),
                                              surname: surname.toString(),
                                              idCard: idCard.toString(),
                                              noContract: widget.customerId!,
                                              listReq: widget.documentChose!,
                                              // other: widget.other ?? '',
                                              receiveNo: dataReceiptNo!,
                                              sentAddressuser: profileController
                                                  .userModel
                                                  .user
                                                  ?.sentAddressuser,
                                              provin: profileController
                                                  .userModel.user?.provin,
                                              district: profileController
                                                  .userModel.user?.district,
                                              subdistrict: profileController
                                                  .userModel.user?.subdistrict,
                                              postcode: profileController
                                                  .userModel.user?.postcode,
                                            );

                                            print('object----');
                                            print(result);

                                            // String updateProfile = await
                                            if (result.isNotEmpty) {
                                              // ignore: use_build_context_synchronously
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(result),
                                                ),
                                              );
                                              return;
                                            }
                                          } else {
                                            if (userReqController
                                                .sentAddressuserController
                                                .text
                                                .isEmpty) {
                                              errorTextaddress =
                                                  'กรุณากรอกที่อยู่ให้ถูกต้อง';
                                              setState(() {});
                                              return;
                                            }
                                            _formKey.currentState!.validate();
                                            if (nameProvin == null ||
                                                nameProvin!.isEmpty) {
                                              return;
                                            } else if (nameDistrict == null ||
                                                nameDistrict!.isEmpty) {
                                              return;
                                            } else if (nameSubdistrict ==
                                                    null ||
                                                nameSubdistrict!.isEmpty) {
                                              return;
                                            }

                                            String result =
                                                await userReqController
                                                    .fetchUserReq(
                                              name: name.toString(),
                                              surname: surname.toString(),
                                              idCard: idCard.toString(),
                                              noContract: widget.customerId!,
                                              listReq: widget.documentChose!,
                                              // other: widget.other ?? '',
                                              receiveNo: dataReceiptNo!,
                                              sentAddressuser: profileController
                                                      .userModel
                                                      .user
                                                      ?.sentAddressuser ??
                                                  userReqController
                                                      .sentAddressuserController
                                                      .text,
                                              provin: nameProvin,
                                              district: nameDistrict,
                                              subdistrict: nameSubdistrict,
                                              postcode: namePostcode,
                                            );
                                            if (result.isNotEmpty) {
                                              // ignore: use_build_context_synchronously
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(result),
                                                ),
                                              );
                                              return;
                                            }
                                          }
                                        }
                                        // ignore: use_build_context_synchronously
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              content: SizedBox(
                                                height: 210.h,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Image.asset(
                                                      'assets/image/success.png',
                                                      height: 50.h,
                                                      fit: BoxFit.cover,
                                                    ),
                                                    SizedBox(
                                                      height: 20.h,
                                                    ),
                                                    Text(
                                                      "สำเร็จ",
                                                      style: TextStyle(
                                                        fontSize: 30.sp,
                                                        color:
                                                            Color(0xFF103533),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                    Text(
                                                      "รายการขอเอกสารสำเร็จ",
                                                      style: TextStyle(
                                                        fontSize: 19.sp,
                                                        color: Colors
                                                            .grey.shade500,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 20.h,
                                                    ),
                                                    Center(
                                                      child: TextButton(
                                                        onPressed: () {
                                                          Navigator
                                                              .pushReplacement(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  const Bottombar(),
                                                            ),
                                                          );
                                                        },
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Color(
                                                                0xFF103533),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8),
                                                            child: Icon(
                                                              Icons.close,
                                                              size: 20.h,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              // actions: [
                                              //   Navigator.of(context).pop();
                                              // ],
                                            );
                                          },
                                        );
                                      } else {
                                        setState(() {
                                          isSelectedReceiptNo = false;
                                        });
                                      }
                                    } else {
                                      print('อันนี้ส่วน เอล: $chosesentRadio');
                                      if (chosesentRadio == 'ส่งแบบอีเมล') {
                                        String result = await userReqController
                                            .fetchUserReq(
                                          name: name.toString(),
                                          surname: surname.toString(),
                                          idCard: idCard.toString(),
                                          noContract: widget.customerId!,
                                          listReq: widget.documentChose!,
                                          other: widget.other ?? '',
                                          receiveNo: dataReceiptNo ?? '',
                                          sentEmailuser: email,
                                        );
                                        if (result.isNotEmpty) {
                                          // ignore: use_build_context_synchronously
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(result),
                                            ),
                                          );
                                          return;
                                        }
                                      } else if (chosesentRadio ==
                                          'ส่งแบบที่อยู่อาศัย') {
                                        if (userReqController
                                            .sentAddressuserController
                                            .text
                                            .isEmpty) {
                                          errorTextaddress =
                                              'กรุณากรอกที่อยู่ให้ถูกต้อง';
                                          setState(() {});
                                        }
                                        if (profileController.userModel.user
                                                ?.sentAddressuser !=
                                            null) {
                                          print('Check value1: $nameProvin');
                                          if (nameProvin == null ||
                                              nameProvin!.isEmpty) {
                                            print('this conditionccccccccß');
                                            return;
                                          }
                                          String result =
                                              await userReqController
                                                  .fetchUserReq(
                                            name: name.toString(),
                                            surname: surname.toString(),
                                            idCard: idCard.toString(),
                                            noContract: widget.customerId!,
                                            listReq: widget.documentChose!,
                                            other: widget.other ?? '',
                                            receiveNo: dataReceiptNo ?? '',
                                            sentAddressuser: profileController
                                                .userModel
                                                .user
                                                ?.sentAddressuser,
                                            provin: profileController
                                                .userModel.user?.provin,
                                            district: profileController
                                                .userModel.user?.district,
                                            subdistrict: profileController
                                                .userModel.user?.subdistrict,
                                            postcode: profileController
                                                .userModel.user?.postcode,
                                          );

                                          if (result.isNotEmpty) {
                                            // ignore: use_build_context_synchronously
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(result),
                                              ),
                                            );
                                            return;
                                          }
                                        } else if (_formKey.currentState!
                                            .validate()) {
                                          print('Check value: $nameProvin');
                                          if (nameProvin == null ||
                                              nameProvin!.isEmpty) {
                                            print('this condition');
                                            return;
                                          }
                                          String result =
                                              await userReqController
                                                  .fetchUserReq(
                                            name: name.toString(),
                                            surname: surname.toString(),
                                            idCard: idCard.toString(),
                                            noContract: widget.customerId!,
                                            listReq: widget.documentChose!,
                                            other: widget.other ?? '',
                                            receiveNo: dataReceiptNo ?? '',
                                            sentAddressuser: profileController
                                                    .userModel
                                                    .user
                                                    ?.sentAddressuser ??
                                                userReqController
                                                    .sentAddressuserController
                                                    .text,
                                            provin: nameProvin,
                                            district: nameDistrict,
                                            subdistrict: nameSubdistrict,
                                            postcode: namePostcode,
                                          );

                                          if (result.isNotEmpty) {
                                            // ignore: use_build_context_synchronously
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(result),
                                              ),
                                            );
                                            return;
                                          }
                                        }
                                      }
                                      // ignore: use_build_context_synchronously
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            content: SizedBox(
                                              height: 210.h,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                    'assets/image/success.png',
                                                    height: 50.h,
                                                    fit: BoxFit.cover,
                                                  ),
                                                  SizedBox(
                                                    height: 20.h,
                                                  ),
                                                  Text(
                                                    "สำเร็จ",
                                                    style: TextStyle(
                                                      fontSize: 30.sp,
                                                      color: Color(0xFF103533),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10.h,
                                                  ),
                                                  Text(
                                                    "รายการขอเอกสารสำเร็จ",
                                                    style: TextStyle(
                                                      fontSize: 19.sp,
                                                      color:
                                                          Colors.grey.shade500,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 20.h,
                                                  ),
                                                  Center(
                                                    child: TextButton(
                                                      onPressed: () {
                                                        Navigator
                                                            .pushReplacement(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                const Bottombar(),
                                                          ),
                                                        );
                                                      },
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0xFF103533),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8),
                                                          child: Icon(
                                                            Icons.close,
                                                            size: 20.h,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            // actions: [
                                            //   Navigator.of(context).pop();
                                            // ],
                                          );
                                        },
                                      );
                                    }
                                  },
                                  style: ButtonStyle(
                                    fixedSize: MaterialStateProperty.all<Size>(
                                      const Size(250, 40),
                                    ),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                      const Color(
                                          0xFF103533), // กำหนดสีพื้นหลังของปุ่ม
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
                                    'ส่ง',
                                    style: TextStyle(
                                      fontSize: 24.sp,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                              ],
                            ),
                          ],
                        ),
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

  Widget selectTypemonth() => FormHelper.dropDownWidget(
        context,
        "กรุณาเลือกเดือนที่ต้องการ",
        currentValue,
        monthlist,
        (onChangedVal) {
          currentValue = onChangedVal;
          debugPrint("Selected YearMonth type = $onChangedVal");
          setState(() {});
        },
        (onValidateVal) {
          if (onValidateVal == null) {
            return "ไม่พบข้อมูล";
          }
          return null;
        },
        borderColor: Colors.grey.shade200,
        borderFocusColor: Colors.grey.shade200,
        borderWidth: 1,
        borderRadius: 10,
        hintFontSize: 18,
        paddingLeft: 0,
        paddingRight: 0,
      );

  Widget selectPovinType() => FormHelper.dropDownWidget(
        context,
        "เลือกจังหวัด",
        currentProvin,
        provin,
        (onChangedVal) {
          currentProvin = onChangedVal;
          debugPrint("เลือกจังหวัด = $onChangedVal");
          for (var province in provin) {
            if (province["id"].toString == onChangedVal.toString) {
              nameProvin = province["name"].toString();
              print(nameProvin);
            }
          }
          setState(() {
            district = DISTRICT
                .where((element) => element["parentid"] == currentProvin)
                .toList();
            district.sort((a, b) {
              String nameA = a["name"].toString();
              String nameB = b["name"].toString();

              // ใช้ Intl.collate เพื่อให้เปรียบเทียบตัวอักษรไทยได้ถูกต้อง
              return nameA.compareTo(nameB);
            });
          });
        },
        (onValidateVal) {
          if (onValidateVal == null ||
              nameProvin == null ||
              nameProvin!.isEmpty) {
            return "กรุณาเลือกจังหวัด";
          }
          return null;
        },
        borderColor: Colors.grey.shade300,
        borderFocusColor: Colors.grey.shade200,
        borderWidth: 1,
        borderRadius: 10,
        paddingLeft: 2,
        paddingRight: 2,
        hintFontSize: 18,
      );

  Widget selectDistrict() => FormHelper.dropDownWidget(
        context,
        "เลือกเขต",
        currentDistrict,
        district,
        (onChangedVal) {
          currentDistrict = onChangedVal;
          debugPrint("เลือกเขต = $onChangedVal");
          for (var districtLoop in district) {
            if (districtLoop["id"].toString == onChangedVal.toString) {
              nameDistrict = districtLoop["name"].toString();
              print(nameDistrict);
            }
          }
          setState(() {
            subdistrict = SUBDISTRICT
                .where((element) => element["parentid"] == currentDistrict)
                .toList();
          });
        },
        (onValidateVal) {
          if (onValidateVal == null) {
            return "กรุณาเลือกเขต";
          }
          return null;
        },
        borderColor: Colors.grey.shade300,
        borderFocusColor: Colors.grey.shade200,
        borderWidth: 1,
        borderRadius: 10,
        paddingLeft: 2,
        paddingRight: 2,
        hintFontSize: 18,
      );

  Widget selectSubdistrict() => FormHelper.dropDownWidget(
        context,
        "เลือกแขวง",
        currentSubdistrict,
        subdistrict,
        (onChangedVal) {
          currentSubdistrict = onChangedVal;
          debugPrint("Selected YearMonth type = $onChangedVal");
          for (var subdistrictLoop in subdistrict) {
            if (subdistrictLoop["id"].toString == onChangedVal.toString) {
              nameSubdistrict = subdistrictLoop["name"].toString();
              print(nameSubdistrict);
            }
          }
          setState(() {
            postcode = POSTCODE
                .where((element) => element["parentid"] == currentSubdistrict)
                .toList();
          });
        },
        (onValidateVal) {
          if (onValidateVal == null) {
            return "กรุณาเลือกแขวง";
          }
          return null;
        },
        borderColor: Colors.grey.shade300,
        borderFocusColor: Colors.grey.shade200,
        borderWidth: 1,
        borderRadius: 10,
        paddingLeft: 2,
        paddingRight: 2,
        hintFontSize: 18,
      );

  Widget selectPostcode() => FormHelper.dropDownWidget(
        context,
        "เลือกรหัสไปรษณีย์",
        currentPostcode,
        postcode,
        (onChangedVal) {
          currentPostcode = onChangedVal;
          debugPrint("Selected YearMonth type = $onChangedVal");
          for (var postcodetLoop in postcode) {
            if (postcodetLoop["id"].toString == onChangedVal.toString) {
              namePostcode = postcodetLoop["name"].toString();
              print(namePostcode);
            }
          }
          setState(() {});
        },
        (onValidateVal) {
          if (onValidateVal == null) {
            return "กรุณาเลือกรหัสไปรษณีย์";
          }
          return null;
        },
        borderColor: Colors.grey.shade300,
        borderFocusColor: Colors.grey.shade200,
        borderWidth: 1,
        borderRadius: 10,
        paddingLeft: 2,
        paddingRight: 2,
        hintFontSize: 18,
      );
}
