import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_chaseapp/utils/my_constant.dart';
import 'package:mobile_chaseapp/utils/responsive_width__context.dart';

class Bar extends StatelessWidget {
  const Bar({super.key});

  @override
  Widget build(BuildContext context) {
    // double _width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          alignment: Alignment.bottomCenter,
          height: ResponsiveWidthContext.isMobileFoldVertical(context)
              ? 110.h
              : ResponsiveWidthContext.isMobile(context) ||
                      ResponsiveWidthContext.isMobileSmall(context)
                  ? 106.h
                  : MyConstant.setMediaQueryWidth(context, 110),
          child: Row(
            children: [
              Container(
                width: 40.w,
                height: 35.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.black.withOpacity(.1),
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    size: MyConstant.setMediaQueryWidth(context, 25),
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              SizedBox(
                width: 20.w,
              ),
              Text(
                'ยอดชำระ',
                style: TextStyle(
                  fontSize: MyConstant.setMediaQueryWidth(context, 28),
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
