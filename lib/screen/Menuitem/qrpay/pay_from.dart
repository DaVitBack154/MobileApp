import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_chaseapp/model/respon_accuser.dart';
import 'package:mobile_chaseapp/screen/Menuitem/qrpay/component/bar.dart';
import 'package:mobile_chaseapp/screen/Menuitem/qrpay/component/slide_accform.dart';
import 'package:mobile_chaseapp/utils/my_constant.dart';
import 'package:mobile_chaseapp/utils/responsive_heigth__context.dart';
import 'package:mobile_chaseapp/utils/responsive_width__context.dart';

class PayFrom extends StatefulWidget {
  final int currentIndex;
  const PayFrom({Key? key, required this.currentIndex}) : super(key: key);

  // const PayFrom({Key? key, required this.data}) : super(key: key);

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
                    height: ResponsiveWidthContext.isMobileFoldVertical(context)
                        ? 285.h + kToolbarHeight
                        : ResponsiveWidthContext.isMobile(context) ||
                                ResponsiveWidthContext.isMobileSmall(context)
                            ? 280.h + kToolbarHeight
                            : ResponsiveWidthContext.isTablet(context)
                                ? MyConstant.setMediaQueryWidth(context, 370) +
                                    kToolbarHeight
                                : MyConstant.setMediaQueryWidth(context, 355) +
                                    kToolbarHeight,
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
                margin: EdgeInsets.only(top: kToolbarHeight + 40).h,
                width: width,
                child: SlideFrom(currentIndex: widget.currentIndex),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
