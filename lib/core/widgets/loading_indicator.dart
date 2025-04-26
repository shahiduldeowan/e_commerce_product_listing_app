import 'package:e_ommerce_product_listing_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

enum LoadingIndicatorType { circular, linear }

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({
    super.key,
    this.value,
    this.type = LoadingIndicatorType.circular,
    this.height = 30,
    this.width = 30,
  });

  final double? value;
  final LoadingIndicatorType type;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    if (type == LoadingIndicatorType.circular) {
      return Center(
        child: CircularProgressIndicator(
          value: value,
          color: AppColors.greyShade200,
          backgroundColor: AppColors.greyShade100,
        ),
      );
    }

    return SizedBox(
      height: height,
      width: width,
      child: LinearProgressIndicator(
        value: value,
        color: AppColors.greyShade200,
        backgroundColor: AppColors.greyShade100,
      ),
    );
  }
}
