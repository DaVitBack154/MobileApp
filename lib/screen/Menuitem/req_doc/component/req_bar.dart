import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_chaseapp/utils/responsive_heigth__context.dart';

class ReqDocBar extends StatefulWidget {
  const ReqDocBar({super.key});

  @override
  State<ReqDocBar> createState() => _ReqDocBarState();
}

class _ReqDocBarState extends State<ReqDocBar> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Container(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            alignment: Alignment.center,
            height: ResponsiveHeightContext.isMobile(context)
                ? 100.h + kToolbarHeight
                : 80.h + kToolbarHeight,
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.black.withOpacity(.1),
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      //print('back');
                    },
                  ),
                ),
                SizedBox(
                  width: 25.w,
                ),
                Text(
                  'ขอเอกสาร',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.sp,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
