// ignore_for_file: file_names
import 'package:flutter/material.dart';

class ResponsiveWidthContext extends StatelessWidget {
  final Widget mobilefoldvertical;
  final Widget mobilesmall;
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  const ResponsiveWidthContext({
    Key? key,
    required this.mobilefoldvertical,
    required this.mobilesmall,
    required this.mobile,
    required this.tablet,
    required this.desktop,
  }) : super(key: key);

  static bool isMobileFoldVertical(BuildContext context) =>
      MediaQuery.of(context).size.width < 360;

  static bool isMobileSmall(BuildContext context) =>
      MediaQuery.of(context).size.width < 400 &&
      MediaQuery.of(context).size.width >= 360;

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 700 &&
      MediaQuery.of(context).size.width >= 400;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 1100 &&
      MediaQuery.of(context).size.width >= 700;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1100;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    if (size.width >= 1100) {
      return desktop;
    } else if (size.width >= 700) {
      return tablet;
    } else if (size.width >= 400) {
      return mobile;
    } else if (size.width >= 360) {
      return mobilesmall;
    } else {
      return mobilefoldvertical;
    }
  }
}
