// ignore_for_file: file_names
import 'package:flutter/material.dart';

class ResponsiveHeightContext extends StatelessWidget {
  final Widget mobilefoldvertical;
  final Widget mobilesmall;
  final Widget mobile;
  final Widget tablet;
  final Widget tabletsmall;
  final Widget desktop;

  const ResponsiveHeightContext({
    Key? key,
    required this.mobilefoldvertical,
    required this.mobilesmall,
    required this.mobile,
    required this.tablet,
    required this.tabletsmall,
    required this.desktop,
  }) : super(key: key);

  static bool isMobileFoldVertical(BuildContext context) =>
      MediaQuery.of(context).size.height < 700;

  static bool isMobileSmall(BuildContext context) =>
      MediaQuery.of(context).size.height < 800 &&
      MediaQuery.of(context).size.height >= 700;

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.height < 1000 &&
      MediaQuery.of(context).size.height >= 800;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.height < 1300 &&
      MediaQuery.of(context).size.height >= 1000;

  static bool isTabletSmall(BuildContext context) =>
      MediaQuery.of(context).size.height < 750 &&
      MediaQuery.of(context).size.height >= 700;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.height >= 1300;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    if (size.height >= 1300) {
      return desktop;
    } else if (size.height >= 1000) {
      return tablet;
    } else if (size.height >= 700) {
      return tabletsmall;
    } else if (size.height >= 800) {
      return mobile;
    } else if (size.height >= 700) {
      return mobilesmall;
    } else {
      return mobilefoldvertical;
    }
  }
}
