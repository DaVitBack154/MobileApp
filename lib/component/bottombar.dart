import 'package:animations/animations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_chaseapp/component/rating_widget.dart';
import 'package:mobile_chaseapp/controller/getprofile_controller.dart';
import 'package:mobile_chaseapp/controller/updatestarpont_controller.dart';
import 'package:mobile_chaseapp/screen/account/account.dart';
import 'package:mobile_chaseapp/screen/contract_page/contract.dart';
import 'package:mobile_chaseapp/screen/homepage/homepage.dart';
import 'package:mobile_chaseapp/screen/login_page/login_page.dart';
import 'package:mobile_chaseapp/screen/profile/profile.dart';
import 'package:mobile_chaseapp/utils/key_storage.dart';
import 'package:mobile_chaseapp/utils/my_constant.dart';
import 'package:mobile_chaseapp/utils/responsive_heigth__context.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
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
  final ProfileController profileController = ProfileController();
  double rating = 0;
  String feedbackMessage = '';
  String comment = '';
  final commentcontroller = TextEditingController();
  String maidaiHai = '';
  String? errorCommentUser;
  bool checkeatting = false;

  @override
  void initState() {
    super.initState();
    getStarUser();
  }

  void getStarUser() async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString(KeyStorage.token) ?? '';
    await profileController.fetchProfileData(token);
    // print('${profileController.userModel.user?.statusStar}+aaaaaa');
    if (profileController.userModel.user?.statusStar == 'Y') {
      _showRatingDialog(context);
    }
  }

  Future<void> _showRatingDialog(BuildContext context) async {
    Future<bool> onWillPop() async {
      return false;
    }

    final query = MediaQuery.of(context);
    rating = 0;
    commentcontroller.clear();
    maidaiHai = '';
    checkeatting = false;
    feedbackMessage = '';
    await showModal(
      configuration: const FadeScaleTransitionConfiguration(
        transitionDuration: Duration(milliseconds: 300),
        reverseTransitionDuration: Duration(milliseconds: 150),
        barrierDismissible: false,
      ),
      context: context,
      builder: (BuildContext context) {
        return MediaQuery(
          data: query.copyWith(
            textScaleFactor: query.textScaleFactor.clamp(1.0, 1.0),
          ),
          child: GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(
              FocusNode(),
            ),
            behavior: HitTestBehavior.opaque,
            child: WillPopScope(
              onWillPop: () {
                return onWillPop().catchError(
                  (error) {
                    if (kDebugMode) {
                      print(
                        'error ===>> $error',
                      );
                    }
                    return false;
                  },
                );
              },
              child: RatingDialogWidget(),
            ),
          ),
        );
      },
    );
  }

  Future<bool> onWillPop() async {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery.withClampedTextScaling(
      minScaleFactor: 1,
      maxScaleFactor: 1,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: PopScope(
          onPopInvoked: (didPop) async => await onWillPop().catchError(
            (error) {
              if (kDebugMode) {
                print(
                  'error ===>> onWillPop: $error',
                );
              }
              return false;
            },
          ),
          child: Scaffold(
            body: IndexedSemantics(
              index: pageIndex,
              child: pages[pageIndex],
            ),
            bottomNavigationBar: SalomonBottomBar(
              backgroundColor: Colors.white,
              selectedItemColor: const Color(0xFF103533),
              unselectedItemColor: Colors.grey.shade400,
              onTap: (index) async {
                if (index != pageIndex) {
                  getStarUser();
                }
                if (index == 1 || index == 3) {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  String? token = prefs.getString('token'); // ดึง Token

                  if (token == null) {
                    // ignore: use_build_context_synchronously
                    Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation1, animation2) =>
                            const Login(),
                        transitionsBuilder:
                            (context, animation1, animation2, child) {
                          final tween = Tween(
                              begin: const Offset(1.0, 0.0), end: Offset.zero);
                          return SlideTransition(
                            position: tween.animate(animation1),
                            child: child,
                          );
                        },
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
                SalomonBottomBarItem(
                  icon: Image.asset(
                    pageIndex == 0
                        ? 'assets/image/iconhome.png'
                        : 'assets/image/iconhome_none.png',
                    width: pageIndex == 0 ? 28.w : 23.w,
                  ),
                  title: Text(
                    'หน้าแรก',
                    style: TextStyle(
                      fontSize: MyConstant.setMediaQueryWidth(context, 22),
                      fontFamily: 'FC Iconic',
                    ),
                  ),
                  selectedColor: Color(0xFF103533),
                ),
                SalomonBottomBarItem(
                  icon: Image.asset(
                    pageIndex == 1
                        ? 'assets/image/iconacc.png'
                        : 'assets/image/iconacc_none.png',
                    width: 28.w,
                  ),
                  title: Text(
                    'บัญชี',
                    style: TextStyle(
                      fontSize: MyConstant.setMediaQueryWidth(context, 22),
                      fontFamily: 'FC Iconic',
                    ),
                  ),
                  selectedColor: Color(0xFF103533),
                ),
                SalomonBottomBarItem(
                  icon: Image.asset(
                    pageIndex == 2
                        ? 'assets/image/iconaddress.png'
                        : 'assets/image/iconaddress_none.png',
                    width: 28.w,
                  ),
                  title: Text(
                    'ติดต่อ',
                    style: TextStyle(
                      fontSize: MyConstant.setMediaQueryWidth(context, 22),
                      fontFamily: 'FC Iconic',
                    ),
                  ),
                  selectedColor: Color(0xFF103533),
                ),
                SalomonBottomBarItem(
                  icon: Icon(
                    Icons.menu,
                    size: MyConstant.setMediaQueryWidth(context, 32),
                    color:
                        pageIndex == 3 ? Color(0xFF103533) : Color(0xFFF9badad),
                  ),
                  title: Text(
                    'โปรไฟล์',
                    style: TextStyle(
                      fontSize: MyConstant.setMediaQueryWidth(context, 22),
                      fontFamily: 'FC Iconic',
                    ),
                  ),
                  selectedColor: Color(0xFF103533),
                ),
              ],
            ),
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
                _exitApp(context);
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

  void _exitApp(BuildContext context) {
    SystemNavigator.pop();
  }
}
