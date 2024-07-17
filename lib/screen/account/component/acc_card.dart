// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:mobile_chaseapp/utils/my_constant.dart';
import 'package:mobile_chaseapp/utils/responsive_heigth__context.dart';
import '../../../controller/getacc_controller.dart';
import '../../../model/respon_accuser.dart';
import '../../Menuitem/qrpay/pay.dart';

class AccCard extends StatefulWidget {
  const AccCard({super.key});

  @override
  State<AccCard> createState() => _AccCardState();
}

class _AccCardState extends State<AccCard> {
  AccController accController = AccController();

  @override
  Widget build(BuildContext context) {
    final thaiBahtFormat = NumberFormat.currency(locale: 'th_TH', symbol: '');
    final formattedDate = DateFormat("dd-MM-yyyy");

    String formatCurrency(double amount) {
      final formatter = NumberFormat("#,###.00", "th");
      return formatter.format(amount);
    }

    return FutureBuilder(
      future: accController.fetchAccData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: SizedBox.shrink(),
            // child: CircularProgressIndicator(
            //   color: Colors.teal.shade500,
            // ),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: SizedBox.shrink(),
            // child: CircularProgressIndicator(
            //   color: Colors.teal.shade500,
            // ),
          );
        }

        final _model = snapshot.data as UserAccModel;

        return ListView(
          physics: const BouncingScrollPhysics(),
          children: _model.data!.map((data) {
            return GestureDetector(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.w,
                  vertical: 5.h,
                ),
                // child: CardUser(
                //   data: data,
                // ),
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 2,
                  child: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/image/bgcard.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 15.h,
                        horizontal: 10.w,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                data.companyId == 'RWAY'
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Resolution Way Co., Ltd.',
                                            style: TextStyle(
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.normal,
                                              height: 0.06,
                                              color: Color(0xFF5C5C5C),
                                              //color: Colors.grey.shade600,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          Text(
                                            'บริษัท รีโซลูชั่น เวย์ จำกัด',
                                            style: TextStyle(
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.normal,
                                              color: Color(0xFF5C5C5C),
                                            ),
                                          ),
                                        ],
                                      )
                                    : data.companyId == 'CFAA'
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'CF Asia Asset Management Co., Ltd.',
                                                style: TextStyle(
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.normal,
                                                  height: 0.06,
                                                  color: Color(0xFF5C5C5C),
                                                  //color: Colors.grey.shade600,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                              Text(
                                                'บริษัท บริหารสินทรัพย์ ซีเอฟ เอเชีย จำกัด',
                                                style: TextStyle(
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.normal,
                                                  color: Color(0xFF5C5C5C),
                                                ),
                                              ),
                                            ],
                                          )
                                        : Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Courts Megastore (Thailand) Co., Ltd.',
                                                style: TextStyle(
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.normal,
                                                  height: 0.06,
                                                  color: Color(0xFF5C5C5C),
                                                  //color: Colors.grey.shade600,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                              Text(
                                                'บริษัท คอร์ทส์ เม็กก้าสโตร์ (ประเทศไทย) จำกัด',
                                                style: TextStyle(
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.normal,
                                                  color: Color(0xFF5C5C5C),
                                                ),
                                              ),
                                            ],
                                          ),
                                Column(
                                  children: [
                                    data.companyId == 'RWAY' ||
                                            data.companyId == 'CFAA'
                                        ? Image.asset(
                                            'assets/image/${data.companyId == 'CFAA' || data.companyId == 'CFAM' ? 'cfam.png' : data.companyId == 'RWAY' ? 'rway.png' : 'courts.png'}',
                                            height:
                                                MyConstant.setMediaQueryWidth(
                                                    context, 20),
                                            fit: BoxFit.cover,
                                          )
                                        : Image.asset(
                                            'assets/image/${data.companyId == 'CFAA' || data.companyId == 'CFAM' ? 'cfam.png' : data.companyId == 'RWAY' ? 'rway.png' : 'courts.png'}',
                                            height:
                                                MyConstant.setMediaQueryWidth(
                                                    context, 17),
                                            fit: BoxFit.cover,
                                          ),
                                    SizedBox(
                                      height: 20.h,
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 7.h,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'ภาระหนี้คงเหลือ (บาท)',
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 18.sp,
                                  height: 1.2,
                                  color: Colors.black,
                                ),
                              ),
                              data.legalType == 'ยังไม่ได้ฟ้อง' &&
                                      (data.calType == 'D' ||
                                          data.calType == 'K')
                                  ? Column(
                                      children: [
                                        Text(
                                          data.osBalance != null
                                              ? formatCurrency(data.osBalance)
                                              : '',
                                          style: TextStyle(
                                            fontSize:
                                                MyConstant.setMediaQueryWidth(
                                                    context, 30),
                                            fontWeight: FontWeight.bold,
                                            height: 1.2,
                                            color: const Color(0xFF103533),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                      ],
                                    )
                                  : data.calType == '' || data.calType == null
                                      ? Column(
                                          children: [
                                            Text(
                                              'กรุณาติดต่อเจ้าหน้าที่เพื่อตรวจสอบยอดหนี้คงค้าง',
                                              style: TextStyle(
                                                fontSize: MyConstant
                                                    .setMediaQueryWidth(
                                                        context, 19),
                                                fontWeight: FontWeight.bold,
                                                height: 1.3,
                                                // color: const Color(0xFF103533),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5.h,
                                            ),
                                          ],
                                        )
                                      : data.legalType ==
                                                  'ฟ้องแล้วยังไม่พิพากษา' ||
                                              data.legalType ==
                                                  'พิพากษาแล้วยังไม่ยืนยัน'
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  data.lawsuiteAmount != null
                                                      ? formatCurrency(
                                                          data.lawsuiteAmount!)
                                                      : '',
                                                  style: TextStyle(
                                                    fontSize: MyConstant
                                                        .setMediaQueryWidth(
                                                            context, 25),
                                                    fontWeight: FontWeight.bold,
                                                    height: 1.2,
                                                    color:
                                                        const Color(0xFF103533),
                                                  ),
                                                ),
                                                Text(
                                                  'ยอดหนี้ ณ วันที่ ${formattedDate.format(
                                                    DateTime.parse(data
                                                        .lawsuiteDate
                                                        .toString()),
                                                  )} ',
                                                  style: TextStyle(
                                                    fontSize: MyConstant
                                                        .setMediaQueryWidth(
                                                            context, 17),
                                                    height: 1.2,
                                                    color:
                                                        const Color(0xFF103533),
                                                  ),
                                                ),
                                                Text(
                                                  'กรุณาติดต่อเจ้าหน้าที่เพื่อตรวจสอบยอดหนี้คงค้าง',
                                                  style: TextStyle(
                                                    fontSize: MyConstant
                                                        .setMediaQueryWidth(
                                                            context, 17),
                                                    height: 1.2,
                                                    color:
                                                        const Color(0xFF103533),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5.h,
                                                )
                                              ],
                                            )
                                          : data.legalType ==
                                                  'ยืนยันคำพิพากษาแล้ว'
                                              ? Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      data.osBalance != null
                                                          ? formatCurrency(
                                                              data.osBalance)
                                                          : '',
                                                      style: TextStyle(
                                                        fontSize: MyConstant
                                                            .setMediaQueryWidth(
                                                                context, 25),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        height: 1.2,
                                                        color: const Color(
                                                            0xFF103533),
                                                      ),
                                                    ),
                                                    Text(
                                                      'ยอดหนี้ ณ วันที่ ${formattedDate.format(
                                                        DateTime.parse(data
                                                            .reportAsOf
                                                            .toString()),
                                                      )} ',
                                                      style: TextStyle(
                                                        fontSize: MyConstant
                                                            .setMediaQueryWidth(
                                                                context, 17),
                                                        height: 1.0,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 5.h,
                                                    )
                                                  ],
                                                )
                                              : SizedBox.shrink()
                            ],
                          ),

                          // Row(
                          //   children: [
                          //     Text(
                          //       'Name :',
                          //       style: TextStyle(
                          //         color: Color(0xFF8A8A8A),
                          //         fontSize: 18.sp,
                          //         height: 1.2,
                          //         fontWeight: FontWeight.normal,
                          //       ),
                          //     ),
                          //     SizedBox(
                          //       width: 5.w,
                          //     ),
                          //     Text(
                          //       '${data.tCustomerName} ${data.tCustomerSurname}',
                          //       style: TextStyle(
                          //         fontWeight: FontWeight.normal,
                          //         fontSize: 18.sp,
                          //         height: 1.2,
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          Text(
                            'Name :',
                            style: TextStyle(
                              color: const Color(0xFF8A8A8A),
                              fontSize: 18.sp,
                              height: 1.2,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Text(
                            '${data.tCustomerName} ${data.tCustomerSurname}',
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 17.sp,
                            ),
                          ),

                          Text(
                            '${data.customerId}',
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 18.sp,
                              height: 1.2,
                            ),
                          ),
                          // Row(
                          //   children: [
                          //     Text(
                          //       'No Card : ',
                          //       style: TextStyle(
                          //         color: Color(0xFF8A8A8A),
                          //         fontSize: 18.sp,
                          //         height: 1.2,
                          //         fontWeight: FontWeight.normal,
                          //       ),
                          //     ),
                          //     SizedBox(
                          //       width: 5.w,
                          //     ),
                          //     Text(
                          //       '${data.customerId}',
                          //       style: TextStyle(
                          //         fontWeight: FontWeight.normal,
                          //         fontSize: 18.sp,
                          //         height: 1.2,
                          //       ),
                          //     ),
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Payment(),
                  ),
                );
              },
            );
          }).toList(),
        );
      },
    );
  }
}
