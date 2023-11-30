import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_chaseapp/controller/getsalehome_controll.dart';
import 'package:mobile_chaseapp/model/respon_salehome.dart';
import 'package:mobile_chaseapp/screen/homepage/component/imgnetwork.dart';
import 'package:mobile_chaseapp/screen/homepage/salehome/salehome_detail.dart';
import 'package:mobile_chaseapp/utils/responsive_heigth__context.dart';

class SaleHome extends StatefulWidget {
  const SaleHome({super.key});

  @override
  State<SaleHome> createState() => _SaleHomeState();
}

class _SaleHomeState extends State<SaleHome> {
  GetsaleHomeController getsaleHomeController = GetsaleHomeController();
  String imageUrl = ImageNetwork.url;
  bool loading = true;

  Future<void> fetchGetsaleHome() async {
    setState(() {
      loading = true;
    });
    try {
      await getsaleHomeController.fetchGetsaleHome();
      // Use the updated method that returns List<UserAccModel>
      loading = false;
      setState(() {});
    } catch (error) {
      print('Error fetching profile data: $error');
      // Handle error if fetching profile data fails
    }
  }

  @override
  void initState() {
    super.initState();
    fetchGetsaleHome(); // Fetch profile data when widget is initialized
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final query = MediaQuery.of(context);
    return MediaQuery(
      data: query.copyWith(
        textScaleFactor: query.textScaleFactor.clamp(1.0, 1.0),
      ),
      child: loading
          ? const SizedBox.shrink()
          : Scaffold(
              body: Stack(
                children: [
                  Column(
                    children: [
                      Container(
                        width: width,
                        height: 400.h + kToolbarHeight,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/image/bg.png'),
                              fit: BoxFit.cover,
                              alignment: Alignment.center),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical:
                                    ResponsiveHeightContext.isMobile(context)
                                        ? 70.h
                                        : 40.h,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                      Icons.arrow_back_ios_new,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  Text(
                                    'บ้านและที่ดิน',
                                    style: TextStyle(
                                      fontSize: 25.sp,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 40.w,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: width,
                    margin: EdgeInsets.only(
                      top: ResponsiveHeightContext.isMobile(context)
                          ? kToolbarHeight + 40.h
                          : kToolbarHeight + 30.h,
                    ),
                    child: Container(
                      // color: Colors.red,
                      height: ResponsiveHeightContext.isMobile(context)
                          ? 570.h
                          : 590.h,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 2.w,
                        ),
                        child: GridView.builder(
                          itemCount:
                              getsaleHomeController.saleHome.data!.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.62,
                          ),
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Card(
                                  clipBehavior: Clip.antiAlias,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  elevation: 5,
                                  child: SizedBox(
                                    height: ResponsiveHeightContext.isMobile(
                                            context)
                                        ? 240.h
                                        : 260.h,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: width,
                                          height: 100.h,
                                          child: Image.network(
                                            '$imageUrl/public/img_all/${getsaleHomeController.saleHome.data![index].imgAll![0]}',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 10.w,
                                            vertical: 3.h,
                                          ),
                                          child: Container(
                                            // color: Colors.black,
                                            height: 50.h,
                                            child: Text(
                                              '${getsaleHomeController.saleHome.data![index].nameHome}',
                                              style: TextStyle(
                                                fontSize: 16.sp,
                                              ),
                                              overflow: TextOverflow.visible,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 5.w,
                                          ),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.location_on,
                                                color: Colors.teal.shade800,
                                                size: 20,
                                              ),
                                              SizedBox(
                                                width: 5.w,
                                              ),
                                              Text(
                                                '${getsaleHomeController.saleHome.data![index].province}',
                                                style: TextStyle(
                                                  fontSize: 15.sp,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Divider(
                                          color: Colors.grey.shade300,
                                          thickness: 1, // ความหนาของเส้น
                                          height: 20, // ระยะห่างของเส้น
                                          indent: 10, // ระยะห่างจากขอบซ้าย
                                          endIndent: 10, // ระยะห่างจากขอบขวา
                                        ),
                                        Row(
                                          children: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => DetailHome(
                                                        data:
                                                            getsaleHomeController
                                                                .saleHome
                                                                .data![index]),
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.teal.shade900,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  border: Border.all(
                                                    width: 1,
                                                    color: Colors.grey.shade200,
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: Text(
                                                    'รายละเอียด',
                                                    style: TextStyle(
                                                      fontSize: 13.sp,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Text(
                                              ' ${getsaleHomeController.saleHome.data![index].priceHome} บาท',
                                              style: TextStyle(
                                                fontSize: 13.sp,
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
