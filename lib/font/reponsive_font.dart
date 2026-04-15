import 'package:flutter/material.dart';

class ResponsiveFont {
  static double getFontSizeForSplashTitle(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width >= 1600) return 64;
    if (width >= 1200) return 50;
    if (width >= 800) return 48;
    if (width >= 480) return 40;
    return 35;
  }

  static double getFontSizeForHeader(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width >= 1600) return 50;
    if (width >= 480) return 50;
    return 38;
  }

  static double getFontsizeSub(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width >= 1600) return 16;
    if (width >= 480) return 14;
    return 12;
  }
}
