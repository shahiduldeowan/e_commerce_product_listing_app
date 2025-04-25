import 'package:e_ommerce_product_listing_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppTextStyles {
  static const String _fontFamily = 'Poppins';

  static TextTheme textTheme() {
    return TextTheme(
      bodyLarge: _textStyle(16, FontWeight.w400, color: AppColors.blueGray300),
      bodyMedium: _textStyle(14, FontWeight.w400, color: AppColors.blueGray900),
      bodySmall: _textStyle(12, FontWeight.w400, color: AppColors.blueGray900),
      labelLarge: _textStyle(12, FontWeight.w500, color: AppColors.blueGray900),
      labelMedium: _textStyle(
        10,
        FontWeight.w500,
        color: AppColors.blueGray300,
      ),
      titleMedium: _textStyle(
        16,
        FontWeight.w600,
        color: AppColors.blueGray900,
      ),
      titleSmall: _textStyle(14, FontWeight.w600, color: AppColors.blueGray900),
    );
  }

  static TextStyle _textStyle(double size, FontWeight weight, {Color? color}) {
    return TextStyle(
      color: color ?? AppColors.blueGray900,
      fontSize: size,
      fontFamily: _fontFamily,
      fontWeight: weight,
    );
  }
}
