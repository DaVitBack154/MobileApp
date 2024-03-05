import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_chaseapp/controller/getsalehome_controll.dart';
import 'package:mobile_chaseapp/screen/homepage/component/imgnetwork.dart';
import 'package:mobile_chaseapp/screen/homepage/salehome/salehome_detail.dart';
import 'package:mobile_chaseapp/utils/my_constant.dart';
import 'package:mobile_chaseapp/utils/responsive_heigth__context.dart';
import 'package:mobile_chaseapp/utils/responsive_width__context.dart';

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
    // double height = MediaQuery.of(context).size.height;
    final query = MediaQuery.of(context);
    return MediaQuery(
      data: query.copyWith(
        // ignore: deprecated_member_use
        textScaler: TextScaler.linear(query.textScaleFactor.clamp(1.0, 1.0)),
      ),
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                Container(
                  width: width,
                  height: 430.h + kToolbarHeight,
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
                      Container(
                        margin: EdgeInsets.only(top: 50.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 40.w,
                              height: 35.h,
                              margin: EdgeInsets.only(left: 20.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.black.withOpacity(.1),
                              ),
                              child: IconButton(
                                icon: Icon(
                                  Icons.arrow_back,
                                  size: MyConstant.setMediaQueryWidth(
                                      context, 25),
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                            Text(
                              'บ้านและที่ดิน',
                              style: TextStyle(
                                fontSize:
                                    MyConstant.setMediaQueryWidth(context, 30),
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: 50.w,
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
                    ? kToolbarHeight + 45.h
                    : ResponsiveWidthContext.isTablet(context)
                        ? kToolbarHeight + 70.h
                        : kToolbarHeight + 65.h,
              ),
              child: Container(
                // color: Colors.red,
                height: 590.h,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 3.w,
                  ),
                  child: loading
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 80.h),
                              width: 40.w,
                              height: 35.h,
                              child: CircularProgressIndicator(
                                color: Colors.teal.shade800,
                              ),
                            ),
                          ],
                        )
                      : GridView.builder(
                          // padding: const EdgeInsets.all(17.0),

                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 0.0,
                            crossAxisSpacing: 2.9,
                            childAspectRatio: ResponsiveWidthContext
                                    .isMobileFoldVertical(context)
                                ? 0.61
                                : ResponsiveWidthContext.isMobile(context) ||
                                        ResponsiveWidthContext.isMobileSmall(
                                            context)
                                    ? 0.56
                                    : 0.82,
                          ),
                          itemCount:
                              getsaleHomeController.saleHome.data!.length,

                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                InkWell(
                                  child: Card(
                                    clipBehavior: Clip.antiAlias,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    elevation: 3,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: width,
                                          height: ResponsiveWidthContext
                                                  .isMobileFoldVertical(context)
                                              ? MyConstant.setMediaQueryWidth(
                                                  context, 150)
                                              : ResponsiveWidthContext.isTablet(
                                                      context)
                                                  ? MyConstant
                                                      .setMediaQueryWidth(
                                                          context, 160)
                                                  : MyConstant
                                                      .setMediaQueryWidth(
                                                          context, 140),
                                          child: Image.network(
                                            '$imageUrl/public/img_all/${getsaleHomeController.saleHome.data![index].imgAll![0]}',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        //รอใส่ paddding
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 15.h),
                                          child: Container(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  margin:
                                                      EdgeInsets.only(left: 10),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'รหัสทรัพย์ ${getsaleHomeController.saleHome.data![index].numberHome}',
                                                        style: TextStyle(
                                                          fontSize: ResponsiveWidthContext
                                                                  .isMobileFoldVertical(
                                                                      context)
                                                              ? 13.sp
                                                              : 14.sp,
                                                          color: Colors
                                                              .grey.shade600,
                                                        ),
                                                      ),
                                                      Text(
                                                        '${getsaleHomeController.saleHome.data![index].nameHome}',
                                                        style: TextStyle(
                                                          fontSize: 16.sp,
                                                        ),
                                                        overflow: TextOverflow
                                                            .visible,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  margin:
                                                      EdgeInsets.only(left: 5),
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.location_on,
                                                        color: Colors
                                                            .teal.shade800,
                                                        size: MyConstant
                                                            .setMediaQueryWidth(
                                                                context, 25),
                                                      ),
                                                      SizedBox(
                                                        width: 5.w,
                                                      ),
                                                      Text(
                                                        '${getsaleHomeController.saleHome.data![index].province}',
                                                        style: TextStyle(
                                                          fontSize: MyConstant
                                                              .setMediaQueryWidth(
                                                                  context, 22),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Divider(
                                                  color: Colors.grey.shade300,
                                                  thickness: 1,
                                                  height: 20,
                                                  indent: 10,
                                                  endIndent: 10,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      width: 35.w,
                                                      margin: EdgeInsets.only(
                                                        left: 5.w,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        color: Colors.red,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          'Sale',
                                                          style: TextStyle(
                                                            fontSize: MyConstant
                                                                .setMediaQueryWidth(
                                                                    context,
                                                                    21),
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                        right: 7.w,
                                                      ),
                                                      child: Text(
                                                        ' ${getsaleHomeController.saleHome.data![index].priceHome} บาท',
                                                        style: TextStyle(
                                                          fontSize: ResponsiveWidthContext
                                                                  .isMobileFoldVertical(
                                                                      context)
                                                              ? MyConstant
                                                                  .setMediaQueryWidth(
                                                                      context,
                                                                      21)
                                                              : MyConstant
                                                                  .setMediaQueryWidth(
                                                                      context,
                                                                      21),
                                                          // color: Colors.red,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailHome(
                                            data: getsaleHomeController
                                                .saleHome.data![index]),
                                      ),
                                    );
                                  },
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
