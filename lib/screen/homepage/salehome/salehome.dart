import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_chaseapp/screen/homepage/salehome/salehome_detail.dart';

class SaleHome extends StatefulWidget {
  const SaleHome({super.key});

  @override
  State<SaleHome> createState() => _SaleHomeState();
}

class _SaleHomeState extends State<SaleHome> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: Text('บ้านมากมาย'),
          backgroundColor: Colors.red,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 15.w,
                      vertical: 5.h,
                    ),
                    child: Text(
                      'รายการบ้านทั้งหมด',
                      style: TextStyle(
                        fontSize: 18.sp,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: height,
                  // decoration: BoxDecoration(color: Colors.amber),
                  child: GridView.builder(
                    itemCount: 6,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, childAspectRatio: 0.6),
                    itemBuilder: (context, index) => cardSaleHome(),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Widget cardSaleHome() {
    return Column(
      children: [
        Card(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 5,
          child: Column(
            children: [
              Image.asset(
                'assets/image/salehome.jpeg',
                width: 200,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.w,
                  vertical: 10.h,
                ),
                child: Text(
                  'หมู่บ้าน ดิเอกเซล รัชดากกกกกกกกกกกกกddddddddddกก',
                  style: TextStyle(
                    fontSize: 16.sp,
                  ),
                  overflow: TextOverflow.visible,
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
                      'กรุงเทพมหานคร',
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
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 10,
                    ),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DetailHome(),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.teal.shade900,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            width: 1,
                            color: Colors.grey.shade200,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            'รายละเอียด',
                            style: TextStyle(
                              fontSize: 15.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Text('2,000,000'),
                      SizedBox(
                        width: 5.w,
                      ),
                      Text('บาท'),
                      SizedBox(
                        width: 10.w,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        )
      ],
    );
  }
}
