import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_chaseapp/utils/my_constant.dart';

class NavbarEdit extends StatefulWidget {
  const NavbarEdit({super.key});

  @override
  State<NavbarEdit> createState() => _NavbarEditState();
}

class _NavbarEditState extends State<NavbarEdit> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/image/bg.png'),
          fit: BoxFit.cover,
        ),
      ),
      alignment: Alignment.center,
      height: 130.h + kToolbarHeight,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20.w,
        ),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.black.withOpacity(.1),
              ),
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios_new_outlined,
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
              'แก้ไขโปรไฟล์',
              style: TextStyle(
                fontSize: 23.sp,
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
