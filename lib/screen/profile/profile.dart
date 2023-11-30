import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_chaseapp/component/bottombar.dart';
import 'package:mobile_chaseapp/controller/logout_controller.dart';
import 'package:mobile_chaseapp/screen/piccode/pincode.dart';
import 'package:mobile_chaseapp/screen/profile/component/navbarprofile.dart';
import 'package:mobile_chaseapp/screen/profile/edit_profile.dart';
import 'package:mobile_chaseapp/utils/app_navigator.dart';
import 'package:mobile_chaseapp/utils/key_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final LogoutController _logoutController = LogoutController();

  Future<void> _handleLogout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString(KeyStorage.token) ?? ''; // ดึง Token
    String pin = prefs.getString(KeyStorage.pin) ?? '';

    if (token.isNotEmpty) {
      // ตรวจสอบว่า Token ไม่เป็น null ก่อนใช้งาน
      await _logoutController.logout(device: '');
      setState(() {});
      //print('getprofileupdate');
    }
  }

  @override
  void initState() {
    super.initState();
    _handleLogout();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          const Column(
            children: [
              NavbarProfile(),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: kToolbarHeight + 170).h,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 20.h,
                ),
                SizedBox(
                  width: double.infinity,
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: Colors.grey.shade200,
                          ),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey.shade200,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.edit_document,
                                    size: 30,
                                    color: Color(0xFF103533),
                                  ),
                                  SizedBox(
                                    width: 30.w,
                                  ),
                                  Text(
                                    'ตั้งค่าโปรไฟล์',
                                    style: TextStyle(
                                      fontSize: 23.sp,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF103533),
                                    ),
                                  ),
                                ],
                              ),
                              const Row(
                                children: [
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    size: 25,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EditProfile(),
                        ),
                      );
                    },
                  ),
                ),
                const Expanded(
                  child: SizedBox(),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 15.h,
                    horizontal: 20.w,
                  ),
                  child: ElevatedButton(
                    onPressed: () async {
                      // await _handleLogout();
                      // SharedPreferences prefs =
                      //     await SharedPreferences.getInstance();
                      // await prefs.remove('');
                      // ignore: use_build_context_synchronously
                      AppNavigator.pushReplacementNamed(
                        PinCode.routeName,
                        arguments: const PinCodeArgs(isGotoNotif: false),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(width, 35.h),
                      backgroundColor: const Color(0xFF103533),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'ออกจากระบบ',
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
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
