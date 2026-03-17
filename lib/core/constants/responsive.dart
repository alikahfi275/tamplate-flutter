import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class Responsive {
  static const double designWidth = 375;
  static const double designHeight = 812;

  static double get screenWidth => Get.width;
  static double get screenHeight => Get.height;

  static bool get isTablet => screenWidth >= 600;

  static double w(double width) {
    return (width / designWidth) * screenWidth;
  }

  static double h(double height) {
    return (height / designHeight) * screenHeight;
  }

  static double sp(double size) {
    return (size / designWidth) * screenWidth;
  }

  static double size(double value) {
    return (value / designWidth) * screenWidth;
  }
}

extension ResponsiveExtension on num {
  /// width
  double get w => Responsive.w(toDouble());

  /// height
  double get h => Responsive.h(toDouble());

  /// font
  double get sp => Responsive.sp(toDouble());

  /// icon / square
  double get size => Responsive.size(toDouble());

  /// radius
  double get radius => Responsive.w(toDouble());

  /// icon
  double get icon => Responsive.w(toDouble());

  /// padding all
  EdgeInsets get padding => EdgeInsets.all(Responsive.w(toDouble()));

  /// margin all
  EdgeInsets get margin => EdgeInsets.all(Responsive.w(toDouble()));
}
