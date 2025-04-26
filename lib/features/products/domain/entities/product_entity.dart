import 'package:freezed_annotation/freezed_annotation.dart';
import 'dimensions_entity.dart';
import 'product_meta_entity.dart';
import 'review_entity.dart';

part 'product_entity.freezed.dart';

@freezed
abstract class ProductEntity with _$ProductEntity {
  const factory ProductEntity({
    int? id,
    String? title,
    String? description,
    String? category,
    double? price,
    double? discountPercentage,
    double? rating,
    int? stock,
    List<String>? tags,
    String? brand,
    String? sku,
    double? weight,
    DimensionsEntity? dimensions,
    String? warrantyInformation,
    String? shippingInformation,
    String? availabilityStatus,
    List<ReviewEntity>? reviews,
    String? returnPolicy,
    int? minimumOrderQuantity,
    ProductMetaEntity? meta,
    List<String>? images,
    String? thumbnail,
    @Default(false) bool isFavorite,
  }) = _ProductEntity;
}

extension ProductEntityX on ProductEntity {
  double get getDiscountPercentage => discountPercentage ?? 0;

  double get getPrice => price ?? 0;

  double get getRating => rating ?? 0;

  int get getReviewLength => reviews?.length ?? 0;

  bool get isOutOfStock => stock == null || stock == 0;

  bool get hasDiscount => getDiscountPercentage > 0;

  String get getDiscountPercentageAsString =>
      getDiscountPercentage.toStringAsFixed(0);

  String get getDiscountPriceAsString {
    double amount =
        hasDiscount
            ? (getPrice * (1 - (getDiscountPercentage / 100)))
            : getPrice;
    return '\$${amount.toStringAsFixed(2)}';
  }
}
