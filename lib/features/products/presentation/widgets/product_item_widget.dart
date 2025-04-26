import 'package:e_ommerce_product_listing_app/core/core_exports.dart'
    show
        AppColors,
        AppImageView,
        AppSizes,
        AssetNames,
        ImageTypes,
        SizeFormatExtension;
import 'package:e_ommerce_product_listing_app/features/products/domain/entities/product_entity.dart';
import 'package:flutter/material.dart';

class ProductItemWidget extends StatelessWidget {
  const ProductItemWidget({super.key, required this.product});

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSizes.small,
      children: <Widget>[
        AppImageView(
          url: product.images?.first ?? '',
          imageTypes: ImageTypes.network,
          height: AppSizes.productImageHeight,
          width: double.maxFinite,
          radius: BorderRadius.circular(AppSizes.xSmall),
        ),
        Text(
          product.title ?? '',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(height: 1.50),
        ),
        SizedBox(
          width: double.maxFinite,
          child: Row(
            spacing: AppSizes.xSmall,
            children: <Widget>[
              Text(
                '\$${product.price ?? 0.0}',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  '\$${product.price ?? 0.0}',
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  '${product.discountPercentage?.toStringAsFixed(0)}% OFF',
                  style: Theme.of(
                    context,
                  ).textTheme.labelMedium!.copyWith(color: AppColors.orange900),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: double.maxFinite,
          child: Row(
            spacing: AppSizes.xSmall,
            children: [
              Container(
                width: AppSizes.large,
                height: AppSizes.large,
                decoration: BoxDecoration(
                  color: AppColors.amber700,
                  borderRadius: AppSizes.xxSmall.toRoundedBorderRadius(),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    AppImageView(
                      url: AssetNames.ratingIcon,
                      imageTypes: ImageTypes.svg,
                      height: 12,
                      width: 12,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
