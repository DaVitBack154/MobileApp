import 'package:flutter/material.dart';

class AppNavigator {
  AppNavigator._();

  static final navigatorKey = GlobalKey<NavigatorState>();

  static NavigatorState get _currentState => navigatorKey.currentState!;

  @optionalTypeArgs
  static Future<T?> pushNamed<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) {
    return _currentState.pushNamed<T>(routeName, arguments: arguments);
  }

  @optionalTypeArgs
  static Future<T?> pushReplacementNamed<T extends Object?, TO extends Object?>(
    String routeName, {
    TO? result,
    Object? arguments,
  }) {
    return _currentState.pushReplacementNamed<T, TO>(
      routeName,
      result: result,
      arguments: arguments,
    );
  }

  @optionalTypeArgs
  static Future<T?> pushNamedAndRemoveUntil<T extends Object?>(
    String newRouteName,
    RoutePredicate predicate, {
    Object? arguments,
  }) {
    return _currentState.pushNamedAndRemoveUntil(
      newRouteName,
      predicate,
      arguments: arguments,
    );
  }

  @optionalTypeArgs
  static void pop<T extends Object?>([T? result]) {
    _currentState.pop<T>(result);
  }

  static void popUntil(RoutePredicate predicate) {
    _currentState.popUntil(predicate);
  }

  static bool canPop() {
    return _currentState.canPop();
  }
}
