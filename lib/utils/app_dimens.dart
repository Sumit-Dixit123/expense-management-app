import 'package:flutter/material.dart';

/// Use fs() for font sizes — auto adjusts for mobile/tablet/desktop
/// Use hp() for horizontal padding, vp() for vertical padding
class AppDimens {
  AppDimens._();

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1024;

  static double fs(BuildContext context,
      {double mobile = 14, double tablet = 15, double desktop = 16}) {
    if (isDesktop(context)) return desktop;
    if (!isMobile(context)) return tablet;
    return mobile;
  }

  // Horizontal padding
  static double hp(BuildContext context) {
    if (isDesktop(context)) return 24;
    if (!isMobile(context)) return 20;
    return 16;
  }

  // Vertical spacing
  static double vp(BuildContext context) {
    if (isDesktop(context)) return 20;
    if (!isMobile(context)) return 16;
    return 12;
  }

  // Max content width for desktop
  static double maxWidth(BuildContext context) {
    if (isDesktop(context)) return 700;
    return double.infinity;
  }
}
