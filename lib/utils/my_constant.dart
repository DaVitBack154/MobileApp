import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mobile_chaseapp/utils/responsive_heigth__context.dart';
import 'package:mobile_chaseapp/utils/responsive_width__context.dart';

class MyConstant {
  static String appname = '';
  static String folderimgper = '';
  static String hoot = '';
  static String apigetworktime = 'https://$hoot/api/';
  static String routeinternetspeddtest = '/....';
  static String saklogoblue = 'as.../...';
  static Color dark1 = const Color(0xFF374352);
  static Color red = Color.fromARGB(255, 82, 55, 55);

  static double setMediaQueryWidthFull(BuildContext context) =>
      MediaQuery.of(context).size.width;
  static double setMediaQueryHeightFull(BuildContext context) =>
      MediaQuery.of(context).size.height;
  static double setMediaQueryWidth(BuildContext context, double setint) {
    if (ResponsiveWidthContext.isMobileFoldVertical(context)) {
      return ((setint / MediaQuery.of(context).size.width) *
              MediaQuery.of(context).size.width) -
          ((((setint * 25) / 100) / MediaQuery.of(context).size.width) *
              MediaQuery.of(context).size.width);
    } else if (ResponsiveWidthContext.isMobileSmall(context)) {
      return ((setint / MediaQuery.of(context).size.width) *
              MediaQuery.of(context).size.width) -
          ((((setint * 15) / 100) / MediaQuery.of(context).size.width) *
              MediaQuery.of(context).size.width);
    } else {
      return ((setint / MediaQuery.of(context).size.width) *
          MediaQuery.of(context).size.width);
    }
  }

  static double setMediaQueryWidthRowText(BuildContext context, double setint) {
    if (ResponsiveWidthContext.isMobileFoldVertical(context)) {
      return ((setint / MediaQuery.of(context).size.width) *
              MediaQuery.of(context).size.width) -
          ((((setint * 25) / 100) / MediaQuery.of(context).size.width) *
              MediaQuery.of(context).size.width);
    } else if (ResponsiveWidthContext.isMobileSmall(context)) {
      return ((setint / MediaQuery.of(context).size.width) *
              MediaQuery.of(context).size.width) -
          ((((setint * 15) / 100) / MediaQuery.of(context).size.width) *
              MediaQuery.of(context).size.width);
    } else {
      return ((setint / MediaQuery.of(context).size.width) *
              MediaQuery.of(context).size.width) +
          (MediaQuery.of(context).size.width > 400
              ? MediaQuery.of(context).size.width - 400
              : 0);
    }
  }

  static double setMediaQueryHeight(BuildContext context, double setint) {
    // if (ResponsiveHeightContext.isMobileSmall(context)) {
    //   return ((setint / MediaQuery.of(context).size.height) *
    //           MediaQuery.of(context).size.height) -
    //       ((((setint * 15) / 100) / MediaQuery.of(context).size.height) *
    //           MediaQuery.of(context).size.height);
    // } else {
    return ((setint / MediaQuery.of(context).size.height) *
        MediaQuery.of(context).size.height);
    // }
  }

  TextStyle stylePrimary() => TextStyle(
      // color: primary,
      // fontWeight: fontweight,
      // fontFamily: fontfamily,
      );

  // TextStyle h0_5StyleBown1Thin(BoxConstraints constraints) => TextStyle(
  //   fontSize: setConstraintsMaxWidth(constraints, h0_5),
  //   color: bown1,
  //   fontFamily: fontfamily,
  //   fontWeight: fontnormal,
  // );

  //  ButtonStyle myButtonStyleWhile25(BoxConstraints constraints) =>
  // ElevatedButton.styleFrom(
  //   shadowColor: grey,
  //   backgroundColor: white,
  //   shape: RoundedRectangleBorder(
  //     borderRadius: borderRadiusCircularSet25(constraints),
  //   ),
  // );
}
