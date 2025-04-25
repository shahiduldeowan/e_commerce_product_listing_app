import 'package:e_ommerce_product_listing_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppThemes {
  static ThemeData lightTheme() {
    return ThemeData(
      visualDensity: VisualDensity.standard,
      colorScheme: AppColors.lightColorScheme,
    );
  }
}
