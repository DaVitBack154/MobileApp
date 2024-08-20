import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mobile_chaseapp/screen/homepage/component/imgnetwork.dart';

class SlishowFull extends StatefulWidget {
  final List<String> imgAll;
  final int currentIndex;
  const SlishowFull({
    Key? key,
    required this.imgAll,
    required this.currentIndex,
  }) : super(key: key);

  @override
  State<SlishowFull> createState() => _SlishowFullState();
}

class _SlishowFullState extends State<SlishowFull> {
  List<String> imgAll = [];
  int currentIndex = 0;
  CarouselSliderController carouselController = CarouselSliderController();
  String imageUrl = ImageNetwork.url;

  @override
  void initState() {
    imgAll = widget.imgAll;
    currentIndex = widget.currentIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(76, 255, 255, 255),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CarouselSlider(
                items: imgAll
                    .map(
                      (item) => Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            placeholder: (context, url) =>
                                LoadingAnimationWidget.threeArchedCircle(
                              color: Colors.teal,
                              size: 35.w,
                            ),
                            fit: BoxFit.cover,
                            imageUrl: '$imageUrl/public/img_all/$item',
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
                                fit: BoxFit.contain,
                              );
                            },
                          ),
                        ),
                      ),
                    )
                    .toList(),
                carouselController: carouselController,
                options: CarouselOptions(
                    initialPage: currentIndex,
                    height: 500.h,
                    autoPlay: false,
                    viewportFraction: 1.0,
                    aspectRatio: 2.0,
                    enlargeCenterPage: true,
                    onPageChanged: (index, reason) {
                      setState(() {
                        currentIndex = index;
                      });
                    }),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 40.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: imgAll.asMap().entries.map(
                    (entry) {
                      return GestureDetector(
                        onTap: () =>
                            carouselController.animateToPage(entry.key),
                        child: Container(
                          width: currentIndex == entry.key ? 20 : 7,
                          height: 7.0,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 3.0,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: currentIndex == entry.key
                                ? Colors.teal.shade800
                                : Colors.grey.shade400,
                          ),
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 40.h, right: 15.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).pop(currentIndex);
                        },
                        icon: Icon(
                          Icons.close,
                          size: 35.w,
                          color: Colors.white,
                        ))
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
