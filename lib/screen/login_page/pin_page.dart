import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_chaseapp/screen/login_page/component/create_pin.dart';
import 'package:mobile_chaseapp/utils/key_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import '../../component/bottombar.dart';

class Pin_page extends StatefulWidget {
  const Pin_page({super.key, this.onBack = true});

  final bool onBack;

  @override
  State<Pin_page> createState() => _Pin_pageState();
}

class _Pin_pageState extends State<Pin_page> {
  // bool forgetpinFirst = false;
  bool varifiy = false;

  // onChageRepin() async {
  //   forgetpinFirst = true;
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    //double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                width: double.infinity,
                height: 160.h + kToolbarHeight,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/image/bgpin.jpg'),
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    varifiy == true
                        ? IconButton(
                            onPressed: () async {
                              varifiy = false;
                              final prefs =
                                  await SharedPreferences.getInstance();
                              await prefs.remove(KeyStorage.pin);
                              setState(() {});
                            },
                            icon: const Padding(
                              padding: EdgeInsets.only(
                                left: 10,
                              ),
                              child: Icon(
                                Icons.arrow_back_ios,
                                size: 30,
                              ),
                            ),
                          )
                        : SizedBox(
                            width: 55.w,
                          ),
                    Image.asset(
                      'assets/image/g_logo.png',
                      fit: BoxFit.cover,
                      height: 90.h,
                      width: 80.w,
                    ),
                    SizedBox(
                      width: 55.w,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: kToolbarHeight + 120).h,
            width: width,
            decoration: const BoxDecoration(
              color: Color(0xfff395d5d),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Create_pin(
              value: varifiy,
              onchanged: (value) {
                if (mounted) {
                  varifiy = value;
                  if (mounted) {
                    setState(
                      () {},
                    );
                  }
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
