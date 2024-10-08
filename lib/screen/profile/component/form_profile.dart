import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_chaseapp/screen/profile/update_profile.dart';
import 'package:mobile_chaseapp/utils/key_storage.dart';
import 'package:mobile_chaseapp/utils/my_constant.dart';
import 'package:mobile_chaseapp/utils/responsive_heigth__context.dart';
import 'package:mobile_chaseapp/utils/responsive_width__context.dart';
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
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20.w,
            ),
            CircleAvatar(
              backgroundColor: Colors.grey.shade100,
              radius: ResponsiveWidthContext.isMobileFoldVertical(context)
                  ? 30.h
                  : 33.h,
              child: Image.asset(
                'assets/image/icon_a.png',
                fit: BoxFit.cover,
                height: ResponsiveWidthContext.isMobileFoldVertical(context)
                    ? 32.h
                    : 35.h,
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
                      fontSize: 18.sp,
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
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
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
                            Icon(
                              Icons.phone_in_talk,
                              color: Color(0xFF395D5D),
                              size: MyConstant.setMediaQueryWidth(context, 30),
                            ),
                            SizedBox(
                              width: 20.w,
                            ),
                            Text(
                              _profileController.userModel.user?.phone!
                                      .replaceAllMapped(
                                          RegExp(r'(\d{3})(\d{3})(\d+)'),
                                          (Match m) => "xxx-xxx-x${m[3]}") ??
                                  '',
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF395D5D),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.edit_square,
                              size: MyConstant.setMediaQueryWidth(context, 30),
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

            //รอเชค ว่ามี email ไหม
            _profileController.userModel.user?.email == 'ไม่พบอีเมล'
                ? SizedBox()
                : Column(
                    children: [
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
                                fontSize: 18.sp,
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
                                  email:
                                      _profileController.userModel.user!.email!,
                                ),
                              )).then((_) async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            String token =
                                prefs.getString(KeyStorage.token) ?? '';
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.email,
                                        size: MyConstant.setMediaQueryWidth(
                                            context, 30),
                                        color: Color(0xFF395D5D),
                                      ),
                                      SizedBox(
                                        width: 20.w,
                                      ),
                                      Text(
                                        _profileController.userModel.user?.email
                                                ?.replaceRange(
                                                    2,
                                                    _profileController
                                                        .userModel.user!.email!
                                                        .indexOf('@'),
                                                    'xxxxxxx') ??
                                            '',
                                        style: TextStyle(
                                          fontSize: 19.sp,
                                          fontWeight: FontWeight.w700,
                                          color: const Color(0xFF395D5D),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.edit_square,
                                        size: MyConstant.setMediaQueryWidth(
                                            context, 30),
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
            //รอเชค ว่ามี email ไหม

            _profileController.userModel.user?.sentAddressuser != null
                ? Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 20,
                          right: 20,
                        ).w,
                        child: Text(
                          'ที่อยู่',
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),
                    ],
                  )
                : const SizedBox.shrink(),
            SizedBox(
              height: 5.h,
            ),
            _profileController.userModel.user?.sentAddressuser != null
                ? GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UpdateProfile(
                              sentAddressuser: _profileController
                                  .userModel.user!.sentAddressuser!,
                              district:
                                  _profileController.userModel.user!.district!,
                              subdistrict: _profileController
                                  .userModel.user!.subdistrict!,
                              provin:
                                  _profileController.userModel.user!.provin!,
                              postcode:
                                  _profileController.userModel.user!.postcode!,
                            ),
                          )).then((_) async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            _profileController.userModel.user
                                                    ?.sentAddressuser ??
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
                                            _profileController.userModel.user
                                                    ?.subdistrict ??
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
                                            _profileController
                                                    .userModel.user?.provin ??
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
                              Row(
                                children: [
                                  Icon(
                                    Icons.edit_square,
                                    size: MyConstant.setMediaQueryWidth(
                                        context, 30),
                                    color: Color(0xFF395D5D),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
