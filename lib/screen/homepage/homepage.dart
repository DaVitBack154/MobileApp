import 'package:animations/animations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_chaseapp/controller/getprofile_controller.dart';
import 'package:mobile_chaseapp/controller/updatestarpont_controller.dart';
import 'package:mobile_chaseapp/screen/homepage/component/menu.dart';
import 'package:mobile_chaseapp/screen/homepage/component/navbar.dart';
import 'package:mobile_chaseapp/screen/homepage/component/slide.dart';
import 'package:mobile_chaseapp/screen/homepage/salehome/salehome.dart';
import 'package:mobile_chaseapp/utils/key_storage.dart';
import 'package:mobile_chaseapp/utils/my_constant.dart';
import 'package:mobile_chaseapp/utils/responsive_heigth__context.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final ProfileController profileController = ProfileController();
  final UpdateStarController updateStarController = UpdateStarController();
  double rating = 0;
  String feedbackMessage = '';
  String comment = '';
  String? errorCommentUser;

  void getStarUser() async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString(KeyStorage.token) ?? '';
    await profileController.fetchProfileData(token);
    // print('${profileController.userModel.user?.statusStar}+aaaaaa');
    if (profileController.userModel.user?.statusStar == 'Y') {
      _showRatingDialog(context);
    }
  }

  final commentcontroller = TextEditingController();

  @override
  void initState() {
    getStarUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final query = MediaQuery.of(context);
    return MediaQuery(
      data: query.copyWith(
        // ignore: deprecated_member_use
        textScaler: TextScaler.linear(query.textScaleFactor.clamp(1.0, 1.0)),
      ),
      child: Scaffold(
        body: Column(
          children: [
            Container(
              width: MyConstant.setMediaQueryWidthFull(context),
              height: ResponsiveHeightContext.isMobileFoldVertical(context)
                  ? MyConstant.setMediaQueryHeight(context, 435)
                  : ResponsiveHeightContext.isMobileSmall(context)
                      ? MyConstant.setMediaQueryHeight(context, 485)
                      : ResponsiveHeightContext.isMobile(context)
                          ? null
                          : null,
              decoration: const BoxDecoration(
                color: Colors.black,
                image: DecorationImage(
                  image: AssetImage('assets/image/bg.png'),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  const Navbar(),
                  const Slide(),
                  const Menu(),
                  SizedBox(height: 5.h),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    btnSaleHome(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget btnSaleHome() {
    return Column(
      children: [
        SizedBox(
          height: 10.h,
        ),
        Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 15.w,
              ),
              child: Text(
                'ที่ดินและบ้าน',
                style: TextStyle(
                  fontSize: 19.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 5.w,
          ),
          child: InkWell(
            child: Card(
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              color: Colors.white,
              elevation: 3,
              child: Container(
                color: Colors.grey.shade100,
                child: Row(
                  children: [
                    Image.asset(
                      'assets/image/salehome001.jpg',
                      width: 180.w,
                      fit: BoxFit.cover,
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'ประกาศขาย',
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xfff395d5d)),
                            ),
                            Text(
                              'ที่ดิน ทาวเฮาส์ บ้านมือสอง กรุงเทพและทั่วประเทศ',
                              style: TextStyle(
                                fontSize: 14.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SaleHome(),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Future<void> _showRatingDialog(BuildContext context) async {
    final formkey = GlobalKey<FormState>();

    Future<bool> onWillPop() async {
      return true;
    }

    final query = MediaQuery.of(context);
    await showModal(
      configuration: const FadeScaleTransitionConfiguration(
        transitionDuration: Duration(milliseconds: 300),
        reverseTransitionDuration: Duration(milliseconds: 150),
        barrierDismissible: true,
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
            child: LayoutBuilder(builder: (context, constraints) {
              return WillPopScope(
                onWillPop: () {
                  return onWillPop().catchError(
                    (error) {
                      if (kDebugMode) {
                        print(
                          'error ===>> $error',
                        );
                      }
                      return true;
                    },
                  );
                },
                child: Scaffold(
                  backgroundColor: const Color.fromARGB(0, 255, 255, 255),
                  body: Form(
                    key: formkey,
                    child: Center(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Dialog(
                              child: Container(
                                constraints: BoxConstraints(
                                  minHeight: 320.h,
                                  maxWidth: 350.w,
                                ),
                                child: StatefulBuilder(
                                    builder: (context, setState) {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            icon: Icon(
                                              Icons.close,
                                              size: 30,
                                              color: Colors.teal.shade800,
                                            ),
                                          )
                                        ],
                                      ),
                                      Center(
                                        child: Text(
                                          'ประเมิลการใช้งาน',
                                          style: TextStyle(
                                              color: Color(0xFF103533),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.sp),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      Column(
                                        children: [
                                          RatingBar.builder(
                                            initialRating: rating,
                                            minRating: 1,
                                            direction: Axis.horizontal,
                                            allowHalfRating: false,
                                            itemCount: 5,
                                            itemSize: 40.0,
                                            itemBuilder: (context, _) =>
                                                const Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                            onRatingUpdate: (value) async {
                                              setState(() {
                                                rating = value;
                                                updateFeedbackMessage();
                                              });
                                            },
                                          ),
                                          SizedBox(height: 20),
                                          Text(
                                            feedbackMessage,
                                            style: TextStyle(
                                              fontSize: 19.sp,
                                            ),
                                          ),
                                          SizedBox(height: 15),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10.w,
                                                horizontal: 10.h),
                                            child: Column(
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'แสดงความคิดเห็นของคุณ',
                                                      style: TextStyle(
                                                        fontSize: 18.sp,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 5.h,
                                                ),
                                                TextFormField(
                                                  maxLines: null,
                                                  controller: commentcontroller,
                                                  decoration: InputDecoration(
                                                    labelText:
                                                        'กรุณาแสดงความคิดเห็น',
                                                    labelStyle: TextStyle(
                                                      color:
                                                          Colors.grey.shade800,
                                                    ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors
                                                              .grey.shade400),
                                                    ),
                                                    focusedBorder:
                                                        const OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.grey),
                                                    ),
                                                  ),
                                                  cursorColor:
                                                      Colors.grey.shade400,
                                                  textInputAction:
                                                      TextInputAction.done,
                                                ),
                                                SizedBox(
                                                  height: 10.h,
                                                ),
                                                ElevatedButton(
                                                  onPressed: () async {
                                                    await UpdateStarController()
                                                        .fetchUpdateStar(
                                                      'N',
                                                      commentcontroller.text,
                                                      rating.toString(),
                                                    );
                                                    Navigator.of(context).pop();
                                                  },
                                                  style: ButtonStyle(
                                                    minimumSize:
                                                        MaterialStateProperty
                                                            .all(Size.fromHeight(
                                                                40)), // กำหนดความสูงตามต้องการ
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all(Color(
                                                                0xFF103533)), // กำหนดสีพื้นหลัง
                                                    shape: MaterialStateProperty
                                                        .all(RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8))), // กำหนดรูปทรงของปุ่ม
                                                  ),
                                                  child: Text(
                                                    'บันทึก',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 19.sp,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                }),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        );
      },
    );
  }

  Future updateFeedbackMessage() async {
    if (rating == 5) {
      feedbackMessage = 'ดีมาก';
    } else if (rating == 4) {
      feedbackMessage = 'ดี';
    } else if (rating == 3) {
      feedbackMessage = 'พอใช้';
    } else if (rating == 2) {
      feedbackMessage = 'ไม่ค่อยพึงพอใจ';
    } else if (rating == 1) {
      feedbackMessage = 'ไม่พึงพอใจ';
    }
  }
}
