import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mobile_chaseapp/controller/getsalehome_controll.dart';
import 'package:mobile_chaseapp/model/respon_salehome.dart';
import 'package:mobile_chaseapp/screen/homepage/component/imgnetwork.dart';
import 'package:mobile_chaseapp/screen/homepage/salehome/slishowfull.dart';
import 'package:mobile_chaseapp/utils/responsive_heigth__context.dart';

class DetailHome extends StatefulWidget {
  final Datum? data;
  const DetailHome({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<DetailHome> createState() => _DetailHomeState();
}

class _DetailHomeState extends State<DetailHome> {
  String imageUrl = ImageNetwork.url;
  bool loading = true;
  Datum? data;
  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;

  @override
  void initState() {
    fetchGetsaleHome();
    super.initState();
  }

  Future<void> fetchGetsaleHome() async {
    setState(() {
      loading = true;
    });
    try {
      data = widget.data;
      // Use the updated method that returns List<UserAccModel>
      loading = false;
      setState(() {});
    } catch (error) {
      print('Error fetching profile data: $error');
      // Handle error if fetching profile data fails
    }
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
        appBar: AppBar(
          title: Text(
            'รายละเอียด',
            style: TextStyle(
              fontSize: 20.sp,
            ),
          ),
          foregroundColor: Colors.white,
          flexibleSpace: Image.asset(
            'assets/image/bg.png',
            fit: BoxFit.cover,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              CarouselSlider(
                items: data!.imgAll!
                    .map(
                      (item) => Center(
                        child: InkWell(
                          onTap: () async {
                            currentIndex = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                allowSnapshotting: false,
                                builder: (context) => SlishowFull(
                                    imgAll: data!.imgAll!,
                                    currentIndex: currentIndex),
                              ),
                            );
                            carouselController.jumpToPage(currentIndex);
                          },
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
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height:
                                      ResponsiveHeightContext.isMobile(context)
                                          ? 200.h
                                          : 180.h,
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
                carouselController: carouselController,
                options: CarouselOptions(
                    autoPlay: false,
                    aspectRatio: 2.0,
                    enlargeCenterPage: true,
                    onPageChanged: (index, reason) {
                      setState(() {
                        currentIndex = index;
                      });
                    }),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: data!.imgAll!.asMap().entries.map(
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
                              ? Colors.teal.shade800
                              : Colors.grey.shade400,
                        ),
                      ),
                    );
                  },
                ).toList(),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.w,
                  vertical: 10.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'รายละเอียด',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${data!.nameHome}',
                      style: TextStyle(
                        fontSize: 18.sp,
                      ),
                    ),
                    Text(
                      '${data!.detailHome}',
                      style: TextStyle(
                        fontSize: 15.sp,
                      ),
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.visible,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    const Text(
                      'นัดเข้าชมโครงการ',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'ติดต่อ : คุณวรรณรัตน์ เกยานนท์',
                      style: TextStyle(
                        fontSize: 16.sp,
                      ),
                    ),
                    Text(
                      'Line : @cfam',
                      style: TextStyle(
                        fontSize: 16.sp,
                      ),
                    ),
                    Text(
                      'Call : 081-642-7488',
                      style: TextStyle(
                        fontSize: 16.sp,
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 25,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'ที่ตั้งและทำเล',
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '${data!.locationHome}',
                      style: TextStyle(
                        fontSize: 15.sp,
                      ),
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.visible,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
