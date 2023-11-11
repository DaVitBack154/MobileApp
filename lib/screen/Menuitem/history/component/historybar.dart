import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
          height: 70.h + kToolbarHeight,
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.black.withOpacity(.1),
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
              SizedBox(
                width: 25.w,
              ),
              Text(
                'ประวัติชำระเงิน',
                style: TextStyle(
                  fontSize: 23.sp,
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
