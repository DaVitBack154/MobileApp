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

  //set ความยาวทุกขนาดจอ
  static double setMediaQueryWidth(BuildContext context, double setint) {
    //ส่วน Mobile ทั้งหมด=========================================//
    if (ResponsiveWidthContext.isMobileFoldVertical(context)) {
      return ((setint / MediaQuery.of(context).size.width) *
              MediaQuery.of(context).size.width) -
          ((((setint * 15) / 100) / MediaQuery.of(context).size.width) *
              MediaQuery.of(context).size.width);
    } else if (ResponsiveWidthContext.isMobileSmall(context)) {
      return ((setint / MediaQuery.of(context).size.width) *
              MediaQuery.of(context).size.width) -
          ((((setint * 5) / 100) / MediaQuery.of(context).size.width) *
              MediaQuery.of(context).size.width);
    } else if (ResponsiveWidthContext.isMobile(context)) {
      return ((setint / MediaQuery.of(context).size.width) *
              MediaQuery.of(context).size.width) +
          ((((setint * 5) / 100) / MediaQuery.of(context).size.width) *
              MediaQuery.of(context).size.width);
      //ส่วน Mobile ทั้งหมด=========================================//
      //======================กั้น=================================//
      //ส่วน Tablet ทั้งหมด=========================================//
    } else if (ResponsiveWidthContext.isTablet(context)) {
      return ((setint / MediaQuery.of(context).size.width) *
              MediaQuery.of(context).size.width) +
          ((((setint * 55) / 100) / MediaQuery.of(context).size.width) *
              MediaQuery.of(context).size.width);
    } else if (ResponsiveWidthContext.isTablet11(context)) {
      return ((setint / MediaQuery.of(context).size.width) *
              MediaQuery.of(context).size.width) +
          ((((setint * 40) / 100) / MediaQuery.of(context).size.width) *
              MediaQuery.of(context).size.width);
    } else if (ResponsiveWidthContext.isTabletMini(context)) {
      return ((setint / MediaQuery.of(context).size.width) *
              MediaQuery.of(context).size.width) +
          ((((setint * 30) / 100) / MediaQuery.of(context).size.width) *
              MediaQuery.of(context).size.width);
      //ส่วน Tablet ทั้งหมด=========================================//
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

  //set ความกว้างทุกขนาดจอ
  static double setMediaQueryHeight(BuildContext context, double setint) {
    if (ResponsiveWidthContext.isMobileFoldVertical(context)) {
      return ((setint / MediaQuery.of(context).size.height) *
              MediaQuery.of(context).size.height) +
          ((((setint * 15) / 100) / MediaQuery.of(context).size.height) *
              MediaQuery.of(context).size.height);
    } else if (ResponsiveWidthContext.isMobileSmall(context)) {
      return ((setint / MediaQuery.of(context).size.height) *
              MediaQuery.of(context).size.height) -
          ((((setint * 5) / 100) / MediaQuery.of(context).size.height) *
              MediaQuery.of(context).size.height);
    } else if (ResponsiveWidthContext.isMobile(context)) {
      return ((setint / MediaQuery.of(context).size.height) *
              MediaQuery.of(context).size.height) +
          ((((setint * 5) / 100) / MediaQuery.of(context).size.height) *
              MediaQuery.of(context).size.height);
    } else if (ResponsiveWidthContext.isTabletMini(context)) {
      return ((setint / MediaQuery.of(context).size.height) *
              MediaQuery.of(context).size.height) -
          ((((setint * 15) / 100) / MediaQuery.of(context).size.height) *
              MediaQuery.of(context).size.height);
    } else if (ResponsiveWidthContext.isTablet11(context)) {
      return ((setint / MediaQuery.of(context).size.height) *
              MediaQuery.of(context).size.height) -
          ((((setint * 5) / 100) / MediaQuery.of(context).size.height) *
              MediaQuery.of(context).size.height);
    } else if (ResponsiveWidthContext.isTablet(context)) {
      return ((setint / MediaQuery.of(context).size.height) *
              MediaQuery.of(context).size.height) +
          ((((setint * 5) / 100) / MediaQuery.of(context).size.height) *
              MediaQuery.of(context).size.height);
    } else {
      return ((setint / MediaQuery.of(context).size.height) *
          MediaQuery.of(context).size.height);
    }
  }
}
