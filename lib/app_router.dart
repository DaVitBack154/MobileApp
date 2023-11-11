import 'package:flutter/material.dart';
import 'package:mobile_chaseapp/component/bottombar.dart';
import 'package:mobile_chaseapp/load.dart';
import 'package:mobile_chaseapp/screen/homepage/notify.dart';
import 'package:mobile_chaseapp/screen/piccode/pincode.dart';
import 'package:mobile_chaseapp/utils/custom_page_route_builder.dart';

class AppRouter {
  static const initialRouterName = Loadding.routeName;

  static Route<dynamic>? router(RouteSettings settings) {
    switch (settings.name) {
      case Loadding.routeName:
        return CustomPageRouteBuilder.route(
          name: Loadding.routeName,
          builder: (ctx) => const Loadding(),
          transitionType: RouteTransition.fade,
        );

      case PinCode.routeName:
        assert(
          settings.arguments is PinCodeArgs || settings.arguments == null,
          'arguments must be PinCodeArgs or null',
        );

        final args = settings.arguments as PinCodeArgs?;

        return CustomPageRouteBuilder.route(
          name: PinCode.routeName,
          builder: (ctx) => PinCode(args: args),
          transitionType: RouteTransition.fade,
        );

      case Notify.routeName:
        return CustomPageRouteBuilder.route(
          name: Notify.routeName,
          builder: (ctx) => const Notify(),
          transitionType: RouteTransition.fade,
        );

      case Bottombar.routeName:
        return CustomPageRouteBuilder.route(
          name: Bottombar.routeName,
          builder: (ctx) => const Bottombar(),
          transitionType: RouteTransition.fade,
        );

      default:
        return null;
    }
  }
}
