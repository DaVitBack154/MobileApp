import 'package:flutter/material.dart';

class ResponsiveWidthConstraints extends StatelessWidget {
  final Widget mobilefoldvertical;
  final Widget mobilesmall;
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  const ResponsiveWidthConstraints({
    Key? key,
    required this.mobilefoldvertical,
    required this.mobilesmall,
    required this.mobile,
    required this.tablet,
    required this.desktop,
  }) : super(key: key);

  static bool isMobileFoldVertical(BoxConstraints constraints) =>
      constraints.maxWidth < 360;

  static bool isMobileSmall(BoxConstraints constraints) =>
      constraints.maxWidth < 400 && constraints.maxWidth >= 360;

  static bool isMobile(BoxConstraints constraints) =>
      constraints.maxWidth < 700 && constraints.maxWidth >= 400;

  static bool isTablet(BoxConstraints constraints) =>
      constraints.maxWidth < 1100 && constraints.maxWidth >= 700;

  static bool isDesktop(BoxConstraints constraints) =>
      constraints.maxWidth >= 1100;

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
