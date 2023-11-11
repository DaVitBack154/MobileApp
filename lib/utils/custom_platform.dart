import 'dart:io';

import 'package:flutter/material.dart';

class CustomPlatform {
  CustomPlatform._();

  static TargetPlatform? _targetPlatform;

  static void setPlatform(TargetPlatform targetPlatform) {
    _targetPlatform = targetPlatform;
  }

  static bool get isIOS {
    return _targetPlatform == TargetPlatform.iOS;
  }

  static bool get isAndroid {
    return _targetPlatform == TargetPlatform.android;
  }

  static T switchPlatform<T>({required T iOS, required T android}) {
    assert(_targetPlatform != null);
    if (isIOS) {
      return iOS;
    }
    return android;
  }

  static bool get isTest {
    return Platform.environment.containsKey('FLUTTER_TEST');
  }
}
