import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_chaseapp/screen/Menuitem/qrpay/component/bar.dart';
import 'package:mobile_chaseapp/screen/Menuitem/qrpay/component/slide_accform.dart';
import 'package:mobile_chaseapp/utils/my_constant.dart';
import 'package:mobile_chaseapp/utils/responsive_heigth__context.dart';

class PayFrom extends StatefulWidget {
  const PayFrom({super.key});

  @override
  State<PayFrom> createState() => _PayFromState();
}

class _PayFromState extends State<PayFrom> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    //double height = MediaQuery.of(context).size.height;
    final query = MediaQuery.of(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        // FocusManager.instance.primaryFocus?.unfocus();
      },
      child: MediaQuery(
        data: query.copyWith(
          // ignore: deprecated_member_use
          textScaler: TextScaler.linear(query.textScaleFactor.clamp(1.0, 1.0)),
        ),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: ResponsiveHeightContext.isMobile(context)
                        ? 270.h + kToolbarHeight
                        : 265.h + kToolbarHeight,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/image/bg.png'),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                    child: const Bar(),
                  ),
                ],
              ),
              Container(
                // height: MyConstant.setMediaQueryHeightFull(context),
                margin: const EdgeInsets.only(top: kToolbarHeight + 40).h,
                width: width,
                child: const SlideFrom(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
