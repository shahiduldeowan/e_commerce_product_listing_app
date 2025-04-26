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
    final TextTheme textTheme = Theme.of(context).textTheme;
    final String imageUrl = product.images?.firstOrNull ?? '';
    final int productId = product.id ?? -1;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSizes.small,
      children: <Widget>[
        _buildProductImage(context, imageUrl, productId),
        _buildProductTitle(textTheme),
        _buildPriceSection(textTheme),
        _buildRatingSection(textTheme),
      ],
    );
  }

  Widget _buildProductImage(
    BuildContext context,
    String imageUrl,
    int productId,
  ) {
    return Stack(
      alignment: Alignment.topRight,
      children: <Widget>[
        AppImageView(
          url: imageUrl,
          imageTypes: ImageTypes.network,
          height: AppSizes.productImageHeight,
          width: double.maxFinite,
          radius: BorderRadius.circular(AppSizes.xSmall),
        ),
        _buildFavoriteButton(context, productId),
        if (product.isOutOfStock) _buildOutOfStockBadge(),
      ],
    );
  }

  Widget _buildFavoriteButton(BuildContext context, int productId) {
    return Positioned(
      top: AppSizes.small,
      right: AppSizes.small,
      child: IconButton.filledTonal(
        style: IconButton.styleFrom(backgroundColor: AppColors.white),
        onPressed:
            () => context.read<ProductBloc>().add(
              ProductEventFavorite(productId),
            ),
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
    );
  }

  Widget _buildOutOfStockBadge() {
    return Positioned(
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
        child: const Text(
          outOfStock,
          style: TextStyle(
            color: AppColors.white,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildProductTitle(TextTheme textTheme) {
    return SizedBox(
      height: AppSizes.productTitleHeight,
      child: Text(
        product.title ?? '',
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: textTheme.bodySmall?.copyWith(height: 1.5),
      ),
    );
  }

  Widget _buildPriceSection(TextTheme textTheme) {
    return SizedBox(
      width: double.maxFinite,
      child: Wrap(
        spacing: AppSizes.xSmall,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: <Widget>[
          Text(product.getDiscountPriceAsString, style: textTheme.titleSmall),
          if (product.hasDiscount) ...<Widget>[
            Text(
              product.getPriceAsString,
              style: textTheme.labelMedium?.copyWith(
                decoration: TextDecoration.lineThrough,
              ),
            ),
            Text(
              product.getDiscountPercentageAsString,
              style: textTheme.labelMedium?.copyWith(
                color: AppColors.orange900,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildRatingSection(TextTheme textTheme) {
    return SizedBox(
      width: double.maxFinite,
      child: Wrap(
        spacing: AppSizes.xSmall,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: <Widget>[
          _buildRatingIcon(),
          Text('${product.getRating}', style: textTheme.labelLarge),
          Text(
            '(${product.getReviewLength})',
            style: textTheme.bodySmall?.copyWith(color: AppColors.gray600),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingIcon() {
    return Stack(
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
        const AppImageView(
          url: AssetNames.ratingIcon,
          imageTypes: ImageTypes.svg,
          height: 12,
          width: 12,
        ),
      ],
    );
  }
}
