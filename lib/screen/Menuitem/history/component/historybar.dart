import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_chaseapp/utils/my_constant.dart';
import 'package:mobile_chaseapp/utils/responsive_heigth__context.dart';

class HisBar extends StatefulWidget {
  const HisBar({super.key});

  @override
  State<HisBar> createState() => _HisBarState();
}

class _HisBarState extends State<HisBar> {
  @override
  Widget build(BuildContext context) {
    // double _width = MediaQuery.of(context).size.width;
    // double _height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
          alignment: Alignment.bottomCenter,
          height: ResponsiveHeightContext.isMobile(context)
              ? 65.h + kToolbarHeight
              : 60.h + kToolbarHeight,
          child: Row(
            children: [
              Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.black.withOpacity(.1),
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    size: MyConstant.setMediaQueryWidth(context, 25),
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
                'ประวัติชำระเงิน',
                style: TextStyle(
                  fontSize: 21.sp,
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
