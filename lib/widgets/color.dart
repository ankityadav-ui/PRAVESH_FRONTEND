import 'package:flutter/material.dart';

class AppColors {
  final bool isDark;

  AppColors({required this.isDark});

  Color get green => const Color(0xff0ACF83);
  Color get greenDark => const Color(0xff368c64);
  Color get background =>
      isDark ? const Color(0xff121212) : const Color(0xFFF5F5F5);
  Color get white => isDark ? Colors.white : Colors.black;
  Color get red => Colors.red;
  Color get grey => isDark ? const Color(0xff303030) : const Color(0xffe0e0e0);
  Color get box => isDark ? const Color(0xFF1E1E1E) : const Color(0xFFF0F0F0);
  Color get hintText => isDark ? Colors.white : const Color(0xFF1E1E1E);
}

Color IntroBackground = Color(0xff121212);
Color introWhite = Colors.white;
