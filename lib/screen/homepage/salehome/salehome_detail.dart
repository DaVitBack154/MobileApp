import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';

class DetailHome extends StatefulWidget {
  const DetailHome({super.key});

  @override
  State<DetailHome> createState() => _DetailHomeState();
}

class _DetailHomeState extends State<DetailHome> {
  List imgList = [
    {"id": 1, "path": 'assets/image/sin1.jpeg'},
    {"id": 2, "path": 'assets/image/sin2.jpeg'},
    {"id": 3, "path": 'assets/image/sin3.jpeg'},
  ];
  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('รายการบ้าน'),
        backgroundColor: Colors.teal.shade800,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          CarouselSlider(
            items: imgList
                .map(
                  (item) => Center(
                    child: InstaImageViewer(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          item["path"],
                          fit: BoxFit.cover,
                          width: double.infinity,
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
                SizedBox(
                  height: 5,
                ),
                Text(
                  'ดิเอกเซล รัชดา 18',
                  style: TextStyle(
                    fontSize: 18.sp,
                  ),
                ),
                Text(
                    'พร้อมเข้าอยู่แบบคนช่างเลือก ตอบโจทย์เจ้าของธุรกิจ คุ้มค่าทั้งอยู่อาศัยและออฟฟิศ4 ชั้น 4 ห้องนอน 5 ห้องน้ำ 2 โถงใหญ่กว้าง เริ่มต้นเพียง 8.9 ล้าน เท่านั้น!!จอดรถได้ 2 คัน 1 กม. ถึง MRT ใกล้ทางด่วน เพียง 5 นาที !'),
                Text(
                    ' ✅ มั่นใจ การก่อสร้างที่มีมาตรฐานสูงวัสดุพรีเมี่ยมเจ้าของโครงการใส่ใจคิดมาแล้วอย่างดี'),
                Text(
                    ' ✅ ทำเลดี ใจกลางเมือง ใกล้ MRT สระว่ายน้ำสนามฟุตซอลห้างสรรพสินค้าและร้านกาแฟ'),
                Text(
                    ' ✅ ย่านที่อยู่อาศัย ถนนส่วนบุคคล เงียบ สงบ ไร้ปัญหาเพื่อนบ้านกวนใจ'),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'นัดเข้าชมโครงการ',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Line : @CFAM',
                  style: TextStyle(
                    fontSize: 16.sp,
                  ),
                ),
                Text(
                  'Call : 02-090-0090',
                  style: TextStyle(
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
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
                SizedBox(
                  height: 5,
                ),
                Text(
                  'รัชดา 18 ซอย 20-21 มิถุนายน',
                  style: TextStyle(
                    fontSize: 16.sp,
                  ),
                ),
                Text(
                  'เขต: ห้วยขวาง แขวง: ห้วยขวาง',
                  style: TextStyle(
                    fontSize: 16.sp,
                  ),
                ),
                Text(
                  'กรุงเทพมหานคร',
                  style: TextStyle(
                    fontSize: 16.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
