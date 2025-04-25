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
  }) = _ProductEntity;
}
