import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_chaseapp/screen/account/account.dart';
import 'package:mobile_chaseapp/screen/contract_page/contract.dart';
import 'package:mobile_chaseapp/screen/homepage/homepage.dart';
import 'package:mobile_chaseapp/screen/login_page/login_page.dart';
import 'package:mobile_chaseapp/screen/profile/profile.dart';
import 'package:mobile_chaseapp/utils/responsive_heigth__context.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Bottombar extends StatefulWidget {
  static const routeName = "Bottombar";

  const Bottombar({super.key});

  @override
  State<Bottombar> createState() => _BottombarState();
}

class _BottombarState extends State<Bottombar> {
  int pageIndex = 0;

  List<Widget> pages = [
    const Homepage(),
    const Account(),
    const Contract(),
    const Profile(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: WillPopScope(
        onWillPop: () => OncloseProgram(context),
        child: Scaffold(
          body: IndexedSemantics(
            index: pageIndex,
            child: pages[pageIndex],
          ),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.white,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            elevation: 10,
            selectedFontSize:
                ResponsiveHeightContext.isTablet(context) ? 14.sp : 16.sp,
            iconSize: ResponsiveHeightContext.isTablet(context) ? 45 : 30,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
            selectedItemColor: const Color(0xFF103533),
            unselectedItemColor: Colors.grey.shade400,
            onTap: (index) async {
              if (index == 1 || index == 3) {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                String? token = prefs.getString('token'); // ดึง Token

                if (token == null) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Login(),
                    ),
                  );
                  return;
                }
                setState(() {
                  pageIndex = index;
                });
              } else {
                setState(() {
                  pageIndex = index;
                });
              }
            },
            currentIndex: pageIndex,
            items: [
              BottomNavigationBarItem(
                icon: pageIndex == 0
                    ? Image.asset(
                        'assets/image/iconhome.png',
                        width: 28.w,
                        height: 28.h,
                      )
                    : Image.asset(
                        'assets/image/iconhome_none.png',
                        width: 23.w,
                        height: 23.h,
                      ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: pageIndex == 1
                    ? Image.asset(
                        'assets/image/iconacc.png',
                        width: 30.w,
                        height: 30.w,
                      )
                    : Image.asset(
                        'assets/image/iconacc_none.png',
                        width: ResponsiveHeightContext.isTablet(context)
                            ? 25.w
                            : 30.h,
                        height: ResponsiveHeightContext.isTablet(context)
                            ? 25.w
                            : 30.h,
                      ),
                label: 'Account',
              ),
              BottomNavigationBarItem(
                icon: pageIndex == 2
                    ? Image.asset(
                        // 'assets/image/iconprofile.png',
                        'assets/image/iconaddress.png',
                        width: 28.w,
                        height: 28.h,
                      )
                    : Image.asset(
                        'assets/image/iconaddress_none.png',
                        // 'assets/image/iconprofile_none.png',
                        width: ResponsiveHeightContext.isTablet(context)
                            ? 22.w
                            : 28.h,
                        height: ResponsiveHeightContext.isTablet(context)
                            ? 22.w
                            : 28.h,
                      ),
                label: 'Contact',
              ),
              BottomNavigationBarItem(
                icon: pageIndex == 3
                    ? const Icon(
                        Icons.menu,
                        size: 45,
                        color: Color(0xFFF103533),
                      )
                    : const Icon(
                        Icons.menu,
                        size: 45,
                        color: Color(0xFFF9badad),
                      ),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Future<bool> OncloseProgram(BuildContext context) async {
    bool? exitApp = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'คุณต้องการออกจากโปรแกรมหรือไม่',
            style: TextStyle(fontSize: 19.sp, fontWeight: FontWeight.normal),
          ),
          // content: Text('คุณต้องการออกจากโปรแกรมหรือไม่'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Container(
                width: 60.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xFF103533),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 10.h,
                    horizontal: 10.w,
                  ),
                  child: Center(
                    child: Text(
                      'ยกเลิก',
                      style: TextStyle(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.normal,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Container(
                width: 60.w,
                decoration: BoxDecoration(
                  color: Color(0xFF103533),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 10.h,
                    horizontal: 10.w,
                  ),
                  child: Center(
                    child: Text(
                      'ตกลง',
                      style: TextStyle(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
    return exitApp ?? false;
  }
}
