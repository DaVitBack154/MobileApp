import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mobile_chaseapp/component/bottombar.dart';
import 'package:mobile_chaseapp/controller/getpromotion.dart';
import 'package:mobile_chaseapp/model/respon_promotion.dart';
import 'package:mobile_chaseapp/screen/homepage/component/imgnetwork.dart';
import 'package:mobile_chaseapp/screen/homepage/promotion/knowledge_content_bon.dart';
import 'package:mobile_chaseapp/screen/login_page/login_page.dart';
import 'package:mobile_chaseapp/screen/profile/profile.dart';
import 'package:mobile_chaseapp/utils/my_constant.dart';
import 'package:mobile_chaseapp/utils/responsive_width__context.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Slide extends StatefulWidget {
  const Slide({super.key});

  @override
  State<Slide> createState() => _SlideState();
}

class _SlideState extends State<Slide> {
  PromotionController promotionController = PromotionController();
  CarouselSliderController carouselController = CarouselSliderController();
  int currentIndex = 0;
  bool loading = true;
  UserPromotion? userPromotion;
  String imageUrl = ImageNetwork.url;
  int pageIndex = 0;
  String? checktoken;

  Future<void> fetchPromotion() async {
    final prefs = await SharedPreferences.getInstance();
    checktoken = prefs.getString('token'); // ดึง Token
    setState(() {
      loading = true;
    });
    try {
      userPromotion = await promotionController.fetchPromotion();
      loading = false;
      setState(() {
        userPromotion!.data!.removeWhere((element) =>
            // element.typeImage != 'image_bon' || element.status == 'OFF')
            element.status == 'OFF');
      });
    } catch (error) {
      print('เกิดข้อผิดพลาดในการดึงข้อมูล: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchPromotion();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const SizedBox()
        : Column(
            children: [
              Stack(
                children: [
                  CarouselSlider(
                    items: userPromotion!.data! // กรองรายการที่มีข้อมูลเท่านั้น
                        .map(
                          (item) => Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            width: double.infinity,
                            child: Center(
                              child: InkWell(
                                onTap: () {
                                  // if (item.typeImage == 'image_lang') {
                                  //   if (checktoken == null) {
                                  //     Navigator.pushReplacement(
                                  //       context,
                                  //       MaterialPageRoute(
                                  //         builder: (context) => const Login(),
                                  //       ),
                                  //     );
                                  //     return;
                                  //   } else {
                                  //     Navigator.pushAndRemoveUntil(
                                  //       context,
                                  //       MaterialPageRoute(
                                  //           builder: (context) =>
                                  //               const Bottombar(
                                  //                 pageIndex: 3,
                                  //               )),
                                  //       (Route<dynamic> route) => false,
                                  //     );
                                  //   }
                                  // } else {
                                  //   Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //       builder: (context) => PromotionBon(
                                  //         item: item,
                                  //       ),
                                  //     ),
                                  //   );
                                  // }

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PromotionBon(
                                        item: item,
                                      ),
                                    ),
                                  );
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: CachedNetworkImage(
                                    placeholder: (context, url) =>
                                        LoadingAnimationWidget
                                            .threeArchedCircle(
                                      color: Colors.teal.shade700,
                                      size: 35.w,
                                    ),
                                    fit: BoxFit.cover,
                                    imageUrl:
                                        '$imageUrl/public/image/${item.image ?? ''}',
                                    // errorWidget: (context, url, error) => Padding(
                                    //   padding: const EdgeInsets.all(25.0),
                                    //   child: Image.asset(
                                    //     MyConstant.error1,
                                    //     fit: BoxFit.cover,
                                    //   ),
                                    // ),
                                    imageBuilder: (context, imageProvider) {
                                      return Image(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: ResponsiveWidthContext
                                                .isMobileFoldVertical(context)
                                            ? MyConstant.setMediaQueryWidth(
                                                context, 210)
                                            : ResponsiveWidthContext.isMobile(
                                                        context) ||
                                                    ResponsiveWidthContext
                                                        .isMobileSmall(context)
                                                ? MyConstant.setMediaQueryWidth(
                                                    context, 195)
                                                : ResponsiveWidthContext
                                                        .isTablet(context)
                                                    ? MyConstant
                                                        .setMediaQueryWidth(
                                                            context, 290)
                                                    : null,
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                    carouselController: carouselController,
                    options: CarouselOptions(
                      viewportFraction: 0.93,
                      autoPlay: true,
                      enableInfiniteScroll: false,
                      initialPage: currentIndex,
                      onPageChanged: (index, reason) {
                        setState(() {
                          currentIndex = index;
                        });
                      },
                    ),
                  ),
                  Positioned(
                    bottom: ResponsiveWidthContext.isTablet(context)
                        ? 40
                        : ResponsiveWidthContext.isMobileSmall(context) ||
                                ResponsiveWidthContext.isMobile(context)
                            ? 0
                            : 20, // กำหนดตำแหน่ง bottom
                    left: 0, // กำหนดตำแหน่ง left
                    right: 0, // กำหนดตำแหน่ง right
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: promotionController.userpromotion.data!
                            .asMap()
                            .entries
                            .map(
                          (entry) {
                            return GestureDetector(
                              onTap: () =>
                                  carouselController.animateToPage(entry.key),
                              child: Container(
                                width: currentIndex == entry.key
                                    ? MyConstant.setMediaQueryWidth(context, 25)
                                    : 7,
                                height: ResponsiveWidthContext.isTablet(context)
                                    ? 8.0
                                    : 6.0,
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 3.0,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: currentIndex == entry.key
                                      ? Colors.white
                                      : Colors.grey.shade400,
                                ),
                              ),
                            );
                          },
                        ).toList(),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: ResponsiveWidthContext.isMobileFoldVertical(context)
                    ? MyConstant.setMediaQueryWidth(context, 17)
                    : ResponsiveWidthContext.isMobileSmall(context) ||
                            ResponsiveWidthContext.isMobile(context)
                        ? MyConstant.setMediaQueryWidth(context, 26)
                        : null,
              ),
            ],
          );
  }
}
