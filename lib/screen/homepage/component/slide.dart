import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mobile_chaseapp/controller/getpromotion.dart';
import 'package:mobile_chaseapp/model/respon_promotion.dart';
import 'package:mobile_chaseapp/screen/homepage/component/imgnetwork.dart';
import 'package:mobile_chaseapp/screen/homepage/promotion/knowledge_content_bon.dart';
import 'package:mobile_chaseapp/utils/my_constant.dart';
import 'package:mobile_chaseapp/utils/responsive_heigth__context.dart';

class Slide extends StatefulWidget {
  const Slide({super.key});

  @override
  State<Slide> createState() => _SlideState();
}

class _SlideState extends State<Slide> {
  PromotionController promotionController = PromotionController();
  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;
  bool loading = true;
  UserPromotion? userPromotion;
  String imageUrl = ImageNetwork.url;

  Future<void> fetchPromotion() async {
    setState(() {
      loading = true;
    });
    try {
      userPromotion = await promotionController.fetchPromotion();
      loading = false;
      setState(() {
        userPromotion!.data!.removeWhere((element) =>
            element.typeImage != 'image_bon' || element.status == 'OFF');
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
              CarouselSlider(
                items: userPromotion!.data! // กรองรายการที่มีข้อมูลเท่านั้น
                    .map(
                      (item) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        width: double.infinity,
                        child: Center(
                          child: InkWell(
                            onTap: () {
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
                                    LoadingAnimationWidget.threeArchedCircle(
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
                                    height: ResponsiveHeightContext
                                            .isMobileFoldVertical(context)
                                        ? MyConstant.setMediaQueryHeight(
                                            context, 180)
                                        : ResponsiveHeightContext.isMobileSmall(
                                                context)
                                            ? MyConstant.setMediaQueryHeight(
                                                context, 190)
                                            : ResponsiveHeightContext.isMobile(
                                                    context)
                                                ? MyConstant
                                                    .setMediaQueryHeight(
                                                        context, 200)
                                                : MyConstant
                                                    .setMediaQueryHeight(
                                                        context, 210),
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
                  viewportFraction: 0.9,
                  autoPlay: false,
                  initialPage: currentIndex,
                  onPageChanged: (index, reason) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:
                    promotionController.userpromotion.data!.asMap().entries.map(
                  (entry) {
                    return GestureDetector(
                      onTap: () => carouselController.animateToPage(entry.key),
                      child: Container(
                        width: currentIndex == entry.key ? 20 : 7,
                        height: 7.0,
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
              SizedBox(
                height: ResponsiveHeightContext.isMobileFoldVertical(context)
                    ? MyConstant.setMediaQueryHeight(context, 10)
                    : ResponsiveHeightContext.isMobileSmall(context)
                        ? MyConstant.setMediaQueryHeight(context, 12)
                        : ResponsiveHeightContext.isMobile(context)
                            ? MyConstant.setMediaQueryHeight(context, 25)
                            : MyConstant.setMediaQueryHeight(context, 25),
              ),
            ],
          );
  }
}
