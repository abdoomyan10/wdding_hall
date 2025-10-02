import 'package:flutter/material.dart';

class AppColors {
  static const Color curvedNavBarBackground = Color(0xFF0066FF);
  static const Color curvedNavBarActiveColor = Color(0xFFFFFFFF);
  static const Color curvedNavBarInactiveColor = Color(0xFFB3D1FF);

  // Primary Colors
  static const Color primary = Color(0xFF0066FF);
  static const Color primaryDark = Color(0xFF0052CC);
  static const Color primaryLight = Color(0xFF4D94FF);

  // Neutral Colors
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color gray100 = Color(0xFFF5F5F5);
  static const Color gray200 = Color(0xFFEEEEEE);
  static const Color gray500 = Color(0xFF9E9E9E);
  static const Color gray800 = Color(0xFF424242);

  // Semantic Colors
  static const Color success = Color(0xFF00C853);
  static const Color warning = Color(0xFFFFAB00);
  static const Color error = Color(0xFFD32F2F);
  static const Color info = Color(0xFF2979FF);

  // Background Colors
  static const Color scaffoldBackground = Color(0xFFFAFAFA);
  static const Color cardBackground = white;
}

// امتداد لتسهيل الاستخدام
extension AppColorsExtension on BuildContext {
  AppColors get colors => AppColors();
}