import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobile_chaseapp/controller/getcompanyname.dart';
import 'package:url_launcher/url_launcher.dart';

class Contract extends StatefulWidget {
  const Contract({Key? key}) : super(key: key);

  @override
  State<Contract> createState() => _ContractState();
}

class _ContractState extends State<Contract> {
  GetCompanyname getcompanynameController = GetCompanyname();
  CameraPosition? position;
  bool statusload = false;

  Future<void> fetchCompanyname() async {
    try {
      await getcompanynameController.fetchGetcompanyname();
      statusload = true;
      setState(() {});
    } catch (error) {
      print('Error fetching profile data: $error');
      // Handle error if fetching profile data fails
    }
  }

  @override
  void initState() {
    super.initState();
    fetchCompanyname(); // Fetch profile data when widget is initialized
  }

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
    final query = MediaQuery.of(context);
    return MediaQuery(
      data: query.copyWith(
        // ignore: deprecated_member_use
        textScaler: TextScaler.linear(query.textScaleFactor.clamp(1.0, 1.0)),
      ),
      child: statusload == false
          ? const SizedBox()
          : DefaultTabController(
              length: getcompanynameController
                  .companyname.data!.length, // จำนวน Tab ที่คุณต้องการ
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
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: TabBar(
                                  indicatorColor: const Color(
                                      0xfff103533), // กำหนดสีของแท็บขณะ hover
                                  tabs: getcompanynameController
                                      .companyname.data!
                                      .map((e) {
                                    String path = '';
                                    double size = 0;
                                    switch (e.companyId) {
                                      case 'CFAA':
                                        path = 'assets/image/cfam.png';
                                        size = 17;
                                        break;
                                      case 'RWAY':
                                        path = 'assets/image/rway.png';
                                        size = 17;
                                        break;
                                      case 'CORT':
                                        path = 'assets/image/courts.png';
                                        size = 15;
                                        break;
                                      default:
                                    }
                                    return Tab(
                                      icon: Image(
                                        image: AssetImage(path),
                                        height: size,
                                        fit: BoxFit.cover,
                                      ),
                                    );
                                  }).toList(),
                                  // [
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Expanded(
                                child: TabBarView(
                                  children: getcompanynameController
                                      .companyname.data!
                                      .map((e) {
                                    return buildcompany(
                                      e.eCompanyName!,
                                      e.tCompanyName!,
                                      e.address!,
                                      e.lineAd!,
                                      e.callCenter!,
                                      double.parse(e.latitude!),
                                      double.parse(e.longitude!),
                                      e.companyId!,
                                      double.parse(e.zoom!),
                                    );
                                  }).toList(),
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
            ),
    );
  }

  Column buildcompany(String nameen, String nameth, String address, String line,
      String phone, double lat, double lng, String namecom, double zoom) {
    return Column(
      children: [
        Text(
          nameen,
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
          nameth,
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
            address,
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
                  line,
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
                  phone,
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
          child: buildBar(lat, lng, namecom, zoom),
        ),
      ],
    );
  }

  Container buildBar(double lat, double lng, String namecom, double zoom) {
    LatLng latLng = LatLng(lat, lng);
    CameraPosition? positionlatlng = CameraPosition(
      target: latLng,
      zoom: zoom,
    );
    Marker marker() {
      return Marker(
          markerId: MarkerId(namecom),
          position: latLng,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          infoWindow: const InfoWindow(title: 'บริษัทตั้งอยู่ที่นี้'),
          onTap: () {
            openlaunchUrlAppOther(
                'https://www.google.com/maps/dir/Current+Location/${latLng.latitude},${latLng.longitude}');
          });
    }

    return Container(
      margin: const EdgeInsets.all(15),
      // ignore: unnecessary_null_comparison
      child: lat == null
          ? const Text('data')
          : GoogleMap(
              myLocationButtonEnabled: false,
              initialCameraPosition: positionlatlng,
              mapType: MapType.normal,
              onMapCreated: (controller) {},
              markers: <Marker>{marker()},
            ),
    );
  }
}
