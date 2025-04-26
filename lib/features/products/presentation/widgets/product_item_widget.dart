import 'package:e_ommerce_product_listing_app/core/core_exports.dart'
    show
        AppColors,
        AppImageView,
        AppSizes,
        AssetNames,
        ImageTypes,
        SizeFormatExtension,
        outOfStock;
import 'package:e_ommerce_product_listing_app/features/products/domain/entities/product_entity.dart';
import 'package:e_ommerce_product_listing_app/features/products/presentation/bloc/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductItemWidget extends StatelessWidget {
  const ProductItemWidget({super.key, required this.product});

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSizes.small,
      children: <Widget>[
        Stack(
          alignment: Alignment.topRight,
          children: <Widget>[
            AppImageView(
              url: product.images?.first ?? '',
              imageTypes: ImageTypes.network,
              height: AppSizes.productImageHeight,
              width: double.maxFinite,
              radius: BorderRadius.circular(AppSizes.xSmall),
            ),
            Positioned(
              top: AppSizes.small,
              right: AppSizes.small,
              child: IconButton.filledTonal(
                style: IconButton.styleFrom(backgroundColor: AppColors.white),
                onPressed: () {
                  context.read<ProductBloc>().add(
                    ProductEventFavorite(product.id ?? -1),
                  );
                },
                icon: AppImageView(
                  url:
                      product.isFavorite
                          ? AssetNames.heartFilledIcon
                          : AssetNames.heartIcon,
                  height: AppSizes.large,
                  width: AppSizes.large,
                  imageTypes: ImageTypes.svg,
                ),
              ),
            ),
            if (product.isOutOfStock)
              Positioned(
                top: AppSizes.small,
                left: AppSizes.small,
                child: Container(
                  padding: AppSizes.xSmall.toSymmetricEdgeInsets(
                    horaizontal: AppSizes.xSmall,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.red,
                    borderRadius: AppSizes.xSmall.toRoundedBorderRadius(),
                  ),
                  child: Text(
                    outOfStock,
                    style: Theme.of(
                      context,
                    ).textTheme.labelLarge!.copyWith(color: AppColors.white),
                  ),
                ),
              ),
          ],
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
            children: <Widget>[
              Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Container(
                    width: AppSizes.large,
                    height: AppSizes.large,
                    decoration: BoxDecoration(
                      color: AppColors.amber700,
                      borderRadius: AppSizes.xxSmall.toRoundedBorderRadius(),
                    ),
                  ),
                  const Positioned(
                    child: AppImageView(
                      url: AssetNames.ratingIcon,
                      imageTypes: ImageTypes.svg,
                      height: 12,
                      width: 12,
                    ),
                  ),
                ],
              ),
              Text(
                '${product.rating}',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              Text(
                '(${product.reviews?.length ?? 0.0})',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall!.copyWith(color: AppColors.gray600),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
