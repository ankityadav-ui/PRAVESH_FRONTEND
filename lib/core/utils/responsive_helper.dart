import 'package:flutter/material.dart';

class ResponsiveHelper {
  static bool isSmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < 600;
  }

  static bool isTablet(BuildContext context) {
    return MediaQuery.of(context).size.width >= 600 &&
        MediaQuery.of(context).size.width < 900;
  }

  static bool isLargeScreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= 900;
  }

  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static EdgeInsets getResponsivePadding(BuildContext context) {
    double width = getScreenWidth(context);
    if (width < 600) {
      return EdgeInsets.all(16.0);
    } else if (width < 900) {
      return EdgeInsets.all(24.0);
    } else {
      return EdgeInsets.all(32.0);
    }
  }

  static double getResponsiveFontSize(BuildContext context,
      {double baseFontSize = 16}) {
    double width = getScreenWidth(context);
    if (width < 600) {
      return baseFontSize;
    } else if (width < 900) {
      return baseFontSize * 1.2;
    } else {
      return baseFontSize * 1.4;
    }
  }
}
