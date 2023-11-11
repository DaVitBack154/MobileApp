import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../controller/getprofile_controller.dart';
import '../../../utils/key_storage.dart';

class NavbarProfile extends StatefulWidget {
  const NavbarProfile({super.key});

  @override
  State<NavbarProfile> createState() => _NavbarProfileState();
}

class _NavbarProfileState extends State<NavbarProfile> {
  final ProfileController _profileController = ProfileController();

  Future<void> fetchProfileData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString(KeyStorage.token) ?? ''; // ดึง Token

      if (token.isNotEmpty) {
        // ตรวจสอบว่า Token ไม่เป็น null ก่อนใช้งาน
        await _profileController.fetchProfileData(token);
        setState(() {
          // MyGlobalVariables.userType =
          //     _profileController.userModel.user?.typeCustomer!;
        });
        // ignore: avoid_print
        print('getname');
      }
    } catch (error) {
      // Handle error if fetching profile data fails
    }
    return;
  }

  @override
  void initState() {
    super.initState();
    fetchProfileData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/image/bg.png'),
          fit: BoxFit.cover,
        ),
      ),
      height: 300.h + kToolbarHeight,
      child: Container(
        margin: const EdgeInsets.only(top: kToolbarHeight + 10).h,
        child: Column(
          children: [
            Image.asset(
              'assets/image/w_Arma.png',
              fit: BoxFit.cover,
              height: 100.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _profileController.userModel.user?.name ?? '',
                  style: TextStyle(
                    fontSize: 32.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 15.w,
                ),
                Text(
                  _profileController.userModel.user?.surname ?? '',
                  style: TextStyle(
                    fontSize: 32.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
