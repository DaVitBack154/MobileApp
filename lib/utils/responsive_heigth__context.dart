// ignore_for_file: file_names
import 'package:flutter/material.dart';

class ResponsiveHeightContext extends StatelessWidget {
  final Widget mobilefoldvertical;
  final Widget mobilesmall;
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  const ResponsiveHeightContext({
    Key? key,
    required this.mobilefoldvertical,
    required this.mobilesmall,
    required this.mobile,
    required this.tablet,
    required this.desktop,
  }) : super(key: key);

  // static bool isMobileFoldVertical(BuildContext context) =>
  //     MediaQuery.of(context).size.height < 360;

  static bool isMobileSmall(BuildContext context) =>
      MediaQuery.of(context).size.height < 700;

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.height < 1100 &&
      MediaQuery.of(context).size.height >= 700;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.height < 1300 &&
      MediaQuery.of(context).size.height >= 1100;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.height >= 1300;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    if (size.height >= 1300) {
      return desktop;
    } else if (size.height >= 1100) {
      return tablet;
    } else if (size.height >= 700) {
      return mobile;
    } else {
      return mobilesmall;
    }
  }
}
