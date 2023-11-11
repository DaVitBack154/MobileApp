import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_chaseapp/controller/getpromotion.dart';
import 'package:mobile_chaseapp/model/respon_promotion.dart';
import 'package:mobile_chaseapp/screen/homepage/component/imgnetwork.dart';
import 'package:mobile_chaseapp/screen/homepage/promotion/knowledge_content_bon.dart';

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
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                '$imageUrl/public/image/${item.image ?? ''}',
                                width: double.infinity,
                                fit: BoxFit.cover,
                                height: 160.h,
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
                height: 15.h,
              ),
            ],
          );
  }
}
