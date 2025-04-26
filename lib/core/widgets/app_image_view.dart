import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_ommerce_product_listing_app/core/constants/asset_names.dart';
import 'package:e_ommerce_product_listing_app/core/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';

enum ImageTypes { network, asset }

class AppImageView extends StatelessWidget {
  const AppImageView({
    super.key,
    required this.url,
    this.placeHolder = AssetNames.noImageView,
    this.imageTypes = ImageTypes.asset,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
  });

  final String url;
  final String placeHolder;
  final ImageTypes imageTypes;
  final double? width;
  final double? height;
  final BoxFit fit;
  @override
  Widget build(BuildContext context) {
    if (imageTypes == ImageTypes.network) {
      return CachedNetworkImage(
        imageUrl: url,
        width: width,
        height: height,
        fit: fit,
        placeholder: (_, __) {
          return const LoadingIndicator(type: LoadingIndicatorType.linear);
        },
        errorWidget: (_, __, ___) => _buildAssetImage(placeHolder),
      );
    }

    return _buildAssetImage();
  }

  Image _buildAssetImage([String? assetPath]) {
    return Image.asset(assetPath ?? url, height: height, width: width);
  }
}
