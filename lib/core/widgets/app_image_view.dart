import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_ommerce_product_listing_app/core/constants/asset_names.dart';
import 'package:e_ommerce_product_listing_app/core/theme/app_colors.dart';
import 'package:e_ommerce_product_listing_app/core/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

enum ImageTypes { network, asset, svg }

class AppImageView extends StatelessWidget {
  const AppImageView({
    super.key,
    required this.url,
    this.placeHolder = AssetNames.noImageView,
    this.imageTypes = ImageTypes.asset,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.color,
    this.radius,
  });

  final String url;
  final String placeHolder;
  final ImageTypes imageTypes;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Color? color;
  final BorderRadiusGeometry? radius;

  @override
  Widget build(BuildContext context) => _buildCirculerImage();

  Widget _buildCirculerImage() {
    return ClipRRect(
      borderRadius: radius ?? BorderRadius.zero,
      child: switch (imageTypes) {
        ImageTypes.network => _buildNetworkImage(),
        ImageTypes.svg => _buildSvgImage(),
        _ => _buildAssetImage(),
      },
    );
  }

  CachedNetworkImage _buildNetworkImage() {
    return CachedNetworkImage(
      imageUrl: url,
      width: width,
      height: height,
      fit: fit,
      color: color,
      imageBuilder:
          (_, ImageProvider<Object> imageProvider) => Container(
            decoration: BoxDecoration(
              color: AppColors.greyShade200,
              image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
            ),
          ),
      placeholder: (_, __) {
        return const LoadingIndicator(type: LoadingIndicatorType.linear);
      },
      errorWidget: (_, __, ___) => _buildAssetImage(placeHolder),
    );
  }

  Image _buildAssetImage([String? assetPath]) {
    return Image.asset(
      assetPath ?? url,
      height: height,
      width: width,
      color: color,
    );
  }

  SvgPicture _buildSvgImage() {
    return SvgPicture.asset(url, height: height, width: width, fit: fit);
  }
}
