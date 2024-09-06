import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_chaseapp/controller/updatestarpont_controller.dart';

class RatingDialogWidget extends StatefulWidget {
  const RatingDialogWidget({super.key});

  @override
  _RatingDialogWidgetState createState() => _RatingDialogWidgetState();
}

class _RatingDialogWidgetState extends State<RatingDialogWidget> {
  final formkey = GlobalKey<FormState>();
  double rating = 0;
  String feedbackMessage = '';
  String comment = '';
  final commentcontroller = TextEditingController();
  String maidaiHai = '';
  String? errorCommentUser;
  bool checkeatting = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("aaaa");
  }

  @override
  Widget build(BuildContext context) {
    print("aaa");
    return Scaffold(
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
                      minHeight: 390.h,
                      maxWidth: 350.w,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 15.h,
                        ),
                        Center(
                          child: Text(
                            '😊  ประเมินการให้บริการ',
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
                              itemCount: 3,
                              itemSize: 40.0,
                              itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (value) async {
                                setState(() {
                                  checkeatting = false;
                                  rating = value;
                                  updateFeedbackMessage();
                                });
                              },
                            ),
                            checkeatting
                                ? Column(
                                    children: [
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Text(
                                        'กรุณาให้คะแนนความพึงพอใจในการใช้แอพพลิเคชั่น',
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 15.sp,
                                        ),
                                      ),
                                    ],
                                  )
                                : SizedBox(),
                            SizedBox(height: 20),
                            Text(
                              feedbackMessage,
                              style: TextStyle(
                                fontSize: 19.sp,
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10.w, horizontal: 10.h),
                                child: Text(
                                  'ความคิดเห็นของท่านเป็นประโยชน์ต่อการนำไปพัฒนาและการปรับปรุงการบริการให้ดียิ่งขึ้น ขอบคุณที่ใช้บริการค่ะ 😊',
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.w, horizontal: 10.h),
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
                                      labelText: 'กรุณาแสดงความคิดเห็น',
                                      labelStyle: TextStyle(
                                        color: Colors.grey.shade800,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade400),
                                      ),
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                      ),
                                    ),
                                    cursorColor: Colors.grey.shade400,
                                    textInputAction: TextInputAction.done,
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      print("click");
                                      if (rating == 0) {
                                        checkeatting = true;
                                      } else {
                                        checkeatting = false;
                                        maidaiHai = '';
                                        await UpdateStarController()
                                            .fetchUpdateStar(
                                          'N',
                                          commentcontroller.text,
                                          rating.toString(),
                                          maidaiHai,
                                        );
                                        Navigator.of(context).pop();
                                      }

                                      setState(() {});
                                    },
                                    style: ButtonStyle(
                                      minimumSize: MaterialStateProperty.all(
                                          Size.fromHeight(
                                              40)), // กำหนดความสูงตามต้องการ
                                      backgroundColor:
                                          MaterialStateProperty.all(Color(
                                              0xFF103533)), // กำหนดสีพื้นหลัง
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
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
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future updateFeedbackMessage() async {
    if (rating == 3) {
      feedbackMessage = 'พึงพอใจมาก';
    } else if (rating == 2) {
      feedbackMessage = 'พึงพอใจปานกลาง';
    } else if (rating == 1) {
      feedbackMessage = 'ไม่พึงพอใจ';
    }
  }
}
