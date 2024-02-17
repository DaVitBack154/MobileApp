//import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_chaseapp/controller/getnotify.dart';
import 'package:mobile_chaseapp/controller/getnotifypromotion.dart';
import 'package:mobile_chaseapp/controller/updatenotipromotion.dart';
import 'package:mobile_chaseapp/firebase_cloud_messaging_provider.dart';
import 'package:mobile_chaseapp/model/respon_notify.dart';
import 'package:mobile_chaseapp/model/respon_notipromotion.dart';
import 'package:mobile_chaseapp/screen/homepage/notify.dart';
import 'package:mobile_chaseapp/screen/login_page/login_page.dart';
import 'package:mobile_chaseapp/utils/my_constant.dart';
import 'package:mobile_chaseapp/utils/responsive_heigth__context.dart';
import 'package:mobile_chaseapp/utils/responsive_width__context.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../utils/key_storage.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  NotifyPromotionController notifyPromotionController =
      NotifyPromotionController();
  UpdateNotiPromotion updateNotiPromotion = UpdateNotiPromotion();
  NotifyController notifyController = NotifyController();
  String? name;
  bool? readed;
  bool? readed2;

  NotiPromotion? notipromotion;
  UserNotify? userNotify;
  Future<void> fetchProfileName() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      // String? uid = prefs.getString(KeyStorage.uid);
      name = prefs.getString(KeyStorage.name);
      notipromotion = await notifyPromotionController.fetchNotifyPromotion();
      readed = !(notipromotion!.data!.any((val) => val.statusRead == 'N'));

      userNotify = await notifyController.fetchNotify();
      readed2 = !(userNotify!.data!.any((val) => val.statusRead == 'N'));
      setState(() {});
      //showNotify();
    } catch (error) {
      // Handle error if fetching profile data fails
    }
    return;
  }

  @override
  void initState() {
    super.initState();
    fetchProfileName();
    FirebaseCloudMessagingProvider.onFirebaseMessageReceived(onListen: () {
      print("this condition");
      fetchProfileName();
    });
  }

  @override
  Widget build(BuildContext context) {
    // double height = MediaQuery.of(context).size.height;
    // print(height);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: ResponsiveHeightContext.isMobileFoldVertical(context)
              ? MyConstant.setMediaQueryHeight(context, 30)
              : ResponsiveHeightContext.isMobileSmall(context)
                  ? MyConstant.setMediaQueryHeight(context, 40)
                  : ResponsiveHeightContext.isMobile(context)
                      ? MyConstant.setMediaQueryHeight(context, 60)
                      : 7.h,
        ),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 30,
            vertical: 10,
          ),
          alignment: Alignment.bottomCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 25.h,
                    child: Image.asset(
                      'assets/image/icon_a.png',
                      fit: BoxFit.cover,
                      height: 25.h,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: ResponsiveWidthContext.isTablet(context) ? 30 : 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'สวัสดีคุณ !',
                          style: TextStyle(
                            fontSize:
                                MyConstant.setMediaQueryWidth(context, 22),
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          name ?? '',
                          style: TextStyle(
                              fontSize:
                                  MyConstant.setMediaQueryWidth(context, 30),
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Stack(
                children: [
                  Row(
                    children: [
                      Container(
                        width: MyConstant.setMediaQueryWidth(context, 60),
                        height: 45.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.black.withOpacity(.1),
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.notifications,
                            size: MyConstant.setMediaQueryWidth(context, 25),
                            color: Colors.white,
                          ),
                          onPressed: () async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            String? token =
                                prefs.getString('token'); // ดึง Token

                            if (token == null) {
                              // ignore: use_build_context_synchronously
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Login(),
                                ),
                              );
                              return;
                            }

                            // อัปเดตค่า statusread เป็น "Y" ในฐานข้อมูล
                            // UpdateNotiPromotion updateNotiPromotion =
                            //     UpdateNotiPromotion();
                            // await updateNotiPromotion.fetchUpdateNotiPromotion(
                            //   token: token,
                            //   statusRead: "Y",
                            // );

                            final result = await Navigator.push<bool>(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Notify(),
                              ),
                            );

                            if (result!) {
                              fetchProfileName();
                            }
                          },
                        ),
                      ),
                    ],
                  ),

                  // != NULL AND equal to false
                  if (readed != null && !readed! ||
                      readed2 != null && !readed2!)
                    Container(
                      margin: const EdgeInsets.only(
                        left: 30,
                        top: 10,
                      ).h,
                      width: 10.w,
                      height: 10.h,
                      child: const CircleAvatar(
                        backgroundColor: Colors.red,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
