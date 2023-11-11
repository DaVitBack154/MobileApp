import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_chaseapp/screen/profile/component/form_profile.dart';
import 'package:mobile_chaseapp/screen/profile/component/navbar_edit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  void initState() {
    getDataUser();
    super.initState();
  }

  void getDataUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token'); // ดึง Token
    // ignore: avoid_print
    print(token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        const Column(
          children: [
            NavbarEdit(),
          ],
        ),
        Container(
          margin: const EdgeInsets.only(top: kToolbarHeight + 85).h,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: const FormProfile(),
        ),
      ],
    ));
  }
}
