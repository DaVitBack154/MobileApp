import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_chaseapp/screen/profile/update_profile.dart';
import 'package:mobile_chaseapp/utils/key_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../controller/getprofile_controller.dart';

class FormProfile extends StatefulWidget {
  const FormProfile({super.key});

  // final String token;
  // const FormProfile({required this.token, Key? key}) : super(key: key);

  @override
  State<FormProfile> createState() => _FormProfileState();
}

class _FormProfileState extends State<FormProfile> {
  final ProfileController _profileController = ProfileController();

  Future<void> fetchProfileData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString(KeyStorage.token) ?? ''; // ดึง Token

      if (token.isNotEmpty) {
        // ตรวจสอบว่า Token ไม่เป็น null ก่อนใช้งาน
        await _profileController.fetchProfileData(token);
        setState(() {});
        //print('getprofileupdate');
      }
    } catch (error) {
      // Handle error if fetching profile data fails
    }
    return;
  }

  @override
  void initState() {
    super.initState();
    fetchProfileData(); // Fetch profile data when widget is initialized
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return SizedBox(
      width: width,
      child: Column(
        children: [
          SizedBox(
            height: 30.w,
          ),
          CircleAvatar(
            backgroundColor: Colors.grey.shade100,
            radius: 33.h,
            child: Image.asset(
              'assets/image/icon_a.png',
              fit: BoxFit.cover,
              height: 35.h,
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                ).w,
                child: Text(
                  'เบอร์โทรศัพท์',
                  style: TextStyle(
                    fontSize: 20.sp,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5.h,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UpdateProfile(
                    phone: _profileController.userModel.user!.phone!,
                  ),
                ),
              ).then((_) async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                String token = prefs.getString(KeyStorage.token) ?? '';
                await _profileController.fetchProfileData(token);

                setState(() {});
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: 20,
              ).w,
              child: Container(
                height: 60.h,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.phone_in_talk,
                            color: Color(0xFF395D5D),
                            size: 30,
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          Text(
                            _profileController.userModel.user?.phone!
                                    .replaceAllMapped(
                                        RegExp(r'(\d{3})(\d{3})(\d+)'),
                                        (Match m) =>
                                            "${m[1]}-${m[2]}-${m[3]}") ??
                                '',
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF395D5D),
                            ),
                          ),
                        ],
                      ),
                      const Row(
                        children: [
                          Icon(
                            Icons.edit_square,
                            size: 25,
                            color: Color(0xFF395D5D),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                ).w,
                child: Text(
                  'อีเมล',
                  style: TextStyle(
                    fontSize: 20.sp,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5.h,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UpdateProfile(
                      email: _profileController.userModel.user!.email!,
                    ),
                  )).then((_) async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                String token = prefs.getString(KeyStorage.token) ?? '';
                await _profileController.fetchProfileData(token);
                setState(() {});
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: 30,
              ).w,
              child: Container(
                height: 60.h,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.email,
                            size: 30,
                            color: Color(0xFF395D5D),
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          Text(
                            _profileController.userModel.user?.email ?? '',
                            style: TextStyle(
                              fontSize: 19.sp,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF395D5D),
                            ),
                          ),
                        ],
                      ),
                      const Row(
                        children: [
                          Icon(
                            Icons.edit_square,
                            size: 25,
                            color: Color(0xFF395D5D),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                ).w,
                child: Text(
                  'ที่อยู่',
                  style: TextStyle(
                    fontSize: 20.sp,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5.h,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UpdateProfile(
                      sentAddressuser:
                          _profileController.userModel.user!.sentAddressuser!,
                      district: _profileController.userModel.user!.district!,
                      subdistrict:
                          _profileController.userModel.user!.subdistrict!,
                      provin: _profileController.userModel.user!.provin!,
                      postcode: _profileController.userModel.user!.postcode!,
                    ),
                  )).then((_) async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                String token = prefs.getString(KeyStorage.token) ?? '';
                await _profileController.fetchProfileData(token);
                setState(() {});
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: 30,
              ).w,
              child: Container(
                // height: 60.h,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'assets/image/iconaddress.png',
                            width: 27.w,
                            height: 27.h,
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    _profileController
                                            .userModel.user?.sentAddressuser ??
                                        '',
                                    style: TextStyle(
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF395D5D),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    'เขต : ',
                                    style: TextStyle(
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF395D5D),
                                    ),
                                  ),
                                  Text(
                                    _profileController
                                            .userModel.user?.district ??
                                        '',
                                    style: TextStyle(
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF395D5D),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    'แขวง : ',
                                    style: TextStyle(
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF395D5D),
                                    ),
                                  ),
                                  Text(
                                    _profileController
                                            .userModel.user?.subdistrict ??
                                        '',
                                    style: TextStyle(
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF395D5D),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    'จังหวัด : ',
                                    style: TextStyle(
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF395D5D),
                                    ),
                                  ),
                                  Text(
                                    _profileController.userModel.user?.provin ??
                                        '',
                                    style: TextStyle(
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF395D5D),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Text(
                                    _profileController
                                            .userModel.user?.postcode ??
                                        '',
                                    style: TextStyle(
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF395D5D),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                      const Row(
                        children: [
                          Icon(
                            Icons.edit_square,
                            size: 25,
                            color: Color(0xFF395D5D),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
