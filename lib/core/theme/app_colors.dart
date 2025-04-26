import 'package:flutter/material.dart';

class AppColors {
  static const Color amber700 = Color(0xFFF59E0B);
  static const Color black900 = Color(0xFF000000);
  static const Color blueGray100 = Color(0xFFD1D5D8);
  static const Color blueGray300 = Color(0xFF9CA3AF);
  static const Color blueGray900 = Color(0xFF1F2937);
  static const Color gray50 = Color(0xFFF9FAFB);
  static const Color gray600 = Color(0xFF6B7280);
  static const Color orange900 = Color(0xFFEA580C);
  static const Color red = Color(0xFFFF3B30);
  static const Color red500 = Color(0xFFEF4444);
  static const Color white = Color(0xFFFFFFFF);

  /// Containing the supported color schemes.
  static const ColorScheme lightColorScheme = ColorScheme.light(
    primary: orange900,
    surface: white,
  );
}
