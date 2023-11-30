import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class Contract extends StatefulWidget {
  const Contract({Key? key}) : super(key: key);

  @override
  State<Contract> createState() => _ContractState();
}

class _ContractState extends State<Contract> {
  //cfam
  double latc1 = 13.9392016;
  double lngc2 = 100.6251760;
  // CameraPosition? position;
  //Rway
  double lat2 = 13.8889879;
  double lng2 = 100.5831677;
  CameraPosition? position;


  Future<void> openlaunchUrlAppOther(String url) async {
    if (mounted) {
      if (await canLaunch(url)
          .timeout(
        const Duration(seconds: 20),
      )
          .catchError(
        (error) {
          if (kDebugMode) {
            print(
              'error ===>> $error',
            );
          }
          return false;
        },
      )) {
        if (!await launch(url)
            .timeout(
          const Duration(seconds: 20),
        )
            .catchError(
          (error) {
            if (kDebugMode) {
              print(
                'error ===>> $error',
              );
            }
            return false;
          },
        )) {
          if (kDebugMode) {
            print(
              'Could not launch $url',
            );
          }
        }
      } else {
        if (kDebugMode) {
          print(
            'Could not launch $url',
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 2, // จำนวน Tab ที่คุณต้องการ
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                Container(
                  width: width,
                  height: 250.h + kToolbarHeight,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/image/bg.png'),
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 70.h,
                        ),
                        child: Text(
                          'CONTRACT ',
                          style: TextStyle(
                            fontSize: 28.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              width: width,
              margin: const EdgeInsets.only(top: kToolbarHeight + 50).h,
              // decoration: BoxDecoration(color: Colors.amber),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.w,
                  vertical: 10.h,
                ),
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 1,
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(10),
                        child: TabBar(
                          indicatorColor:
                              Color(0xFFF103533), // กำหนดสีของแท็บขณะ hover
                          // indicatorWeight: 2.0, // กำหนดขนาดของแท็บขณะ hover
                          tabs: [
                            Tab(
                              icon: Image(
                                image: AssetImage('assets/image/cfam.png'),
                                height: 20,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Tab(
                              icon: Image(
                                image: AssetImage('assets/image/rway.png'),
                                height: 20,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            Column(
                              children: [
                                Text(
                                  'CF Asia Assets Management CO.,LTD.',
                                  style: TextStyle(
                                    fontSize: 19.sp,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFFF103533),
                                  ),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Text(
                                  'บริษัท บริหารสินทรัพย์ ซีเอฟ เอเชีย จำกัด',
                                  style: TextStyle(
                                    fontSize: 19.sp,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFFF103533),
                                  ),
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 20.w,
                                  ),
                                  child: Text(
                                    '1/755 หมู่ที่ 17 ซอยพหลโยธิน 60 ถนนพหลโยธิน ต.คูคต อ.ลำลูกกา จ.ปทุมธานี 12130',
                                    style: TextStyle(
                                      fontSize: 17.sp,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                Container(
                                  height: 1,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1,
                                      color: Colors.grey.shade300,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 10.h,
                                    horizontal: 20.w,
                                  ),
                                  child: Column(children: [
                                    Row(
                                      children: [
                                        Text(
                                          'Line : ',
                                          style: TextStyle(
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.grey.shade500,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 30.w,
                                        ),
                                        Text(
                                          '@CFAM',
                                          style: TextStyle(
                                            fontSize: 20.sp,
                                            color: Color(0xFFF103533),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Phone : ',
                                          style: TextStyle(
                                            fontSize: 19.sp,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.grey.shade500,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20.w,
                                        ),
                                        Text(
                                          '02-234-5467',
                                          style: TextStyle(
                                            fontSize: 20.sp,
                                            color: Color(0xFFF103533),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ]),
                                ),
                                Container(
                                  height: 1,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1,
                                      color: Colors.grey.shade300,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: showMapCFAM(),
                                ),
                              ],
                            ),

                            // เพิ่มเนื้อหาของ Tab 2 ที่นี่
                            Column(
                              children: [
                                Text(
                                  'Resolution Way CO.,LTD.',
                                  style: TextStyle(
                                    fontSize: 19.sp,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFFF103533),
                                  ),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Text(
                                  'บริษัท รีโซลูชั่น เวย์ จำกัด',
                                  style: TextStyle(
                                    fontSize: 19.sp,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFFF103533),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 20.w,
                                  ),
                                  child: Text(
                                    '102/10 ถนน กำแพงเพชร 6 ซอย 5 แยก 1 ถนน วิภาวดีรังสิต แขวงตลาดบางเขน เขตหลักสี่ กรุงเทพมหานคร 10210',
                                    style: TextStyle(
                                      fontSize: 17.sp,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                Container(
                                  height: 1,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1,
                                      color: Colors.grey.shade300,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 10.h,
                                    horizontal: 20.w,
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            'Line : ',
                                            style: TextStyle(
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.grey.shade500,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 30.w,
                                          ),
                                          Text(
                                            '@RWAY',
                                            style: TextStyle(
                                              fontSize: 20.sp,
                                              color: Color(0xFFF103533),
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Phone : ',
                                            style: TextStyle(
                                              fontSize: 19.sp,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.grey.shade500,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 20.w,
                                          ),
                                          Text(
                                            '02-234-5989',
                                            style: TextStyle(
                                              fontSize: 20.sp,
                                              color: Color(0xFFF103533),
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 1,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1,
                                      color: Colors.grey.shade300,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: showMapRWAY(),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container showMapCFAM() {
    LatLng latLng1 = LatLng(latc1, lngc2);
    position = CameraPosition(
      target: latLng1,
      zoom: 16.0,
    );
    Marker cfamMarker() {
      return Marker(
        markerId: const MarkerId('cfam'),
        position: LatLng(latc1, lngc2),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        infoWindow: const InfoWindow(title: 'บริษัทตั้งอยู่ที่นี้'),
        onTap: () {
          openlaunchUrlAppOther('https://www.google.com/maps/dir/Current+Location/$latc1,$lngc2');
        }
      );
    }

    return Container(
      margin: const EdgeInsets.all(15),
      // ignore: unnecessary_null_comparison
      child: latc1 == null
          ? const Text('data')
          : GoogleMap(
              myLocationButtonEnabled: false,
              initialCameraPosition: position!,
              mapType: MapType.normal,
              onMapCreated: (controller) {},
              markers: <Marker>{cfamMarker()},
            ),
    );
  }

  Container showMapRWAY() {
    LatLng latLng2 = LatLng(lat2, lng2);
    position = CameraPosition(
      target: latLng2,
      zoom: 40.0,
    );
    Marker userMarker() {
      return Marker(
        markerId: const MarkerId('valuerway'),
        position: LatLng(lat2, lng2),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        infoWindow: const InfoWindow(title: 'ที่ตั้งบริษัท'),
         onTap: () {
          openlaunchUrlAppOther('https://www.google.com/maps/dir/Current+Location/$lat2,$lng2');
        }
      );
    }

    return Container(
      margin: const EdgeInsets.all(15),
      // ignore: unnecessary_null_comparison
      child: lat2 == null
          ? const Text('data')
          : GoogleMap(
              myLocationButtonEnabled: false,
              initialCameraPosition: position!,
              mapType: MapType.normal,
              onMapCreated: (controller) {},
              markers: <Marker>{userMarker()},
            ),
    );
  }
}
