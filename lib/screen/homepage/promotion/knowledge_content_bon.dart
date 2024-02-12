import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:mobile_chaseapp/controller/getpromotion.dart';
import 'package:mobile_chaseapp/model/respon_promotion.dart';
import 'package:mobile_chaseapp/screen/homepage/component/imgnetwork.dart';

// ignore: must_be_immutable
class PromotionBon extends StatefulWidget {
  PromotionBon({super.key, required this.item});
  Datum item;
  @override
  State<PromotionBon> createState() => _PromotionBonState();
}

class _PromotionBonState extends State<PromotionBon> {
  PromotionController promotionController = PromotionController();
  String imageUrl = ImageNetwork.url;
  final formattedDate = DateFormat("dd/MM/yyyy");

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(height * 0.3), // here the desired height
        child: AppBar(
          elevation: 0,
          flexibleSpace: Container(
            width: width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    '$imageUrl/public/image/${widget.item.image ?? ''}'),
                fit: BoxFit.cover,
                // ให้รูปภาพปรับขนาดให้เต็ม Container
              ),
            ),
          ),
          leading: Container(
            margin: EdgeInsets.symmetric(
              vertical: 3.h,
              horizontal: 3.w,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.black.withOpacity(.3),
            ),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                size: 30,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ),
      body: SizedBox(
        width: width,
        height: height,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.item.expiredDate == '' || widget.item.expiredDate == null
                  ? const SizedBox.shrink()
                  : SizedBox(),
              // : Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Container(
              //         decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(25),
              //           color: Color(0xFF395D5D),
              //         ),
              //         child: Padding(
              //           padding: const EdgeInsets.all(12),
              //           child: Row(
              //             children: [
              //               Text(
              //                 'หมดเขตภายใน',
              //                 style: TextStyle(
              //                   fontWeight: FontWeight.bold,
              //                   fontSize: 17.sp,
              //                   color: Colors.white,
              //                 ),
              //               ),
              //               SizedBox(
              //                 width: 5.w,
              //               ),
              //               Text(
              //                 formattedDate.format(
              //                   DateTime.parse(
              //                       widget.item.expiredDate.toString()),
              //                 ),
              //                 style: TextStyle(
              //                   fontWeight: FontWeight.bold,
              //                   fontSize: 17.sp,
              //                   color: Colors.white,
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),
              //       ),
              //       const SizedBox.shrink(),
              //     ],
              //   ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: 10,
                        ),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            widget.item.titlePro!.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 20.sp,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        widget.item.contentPro!.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 18.sp,
                          color: Color(0xFF767676),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
