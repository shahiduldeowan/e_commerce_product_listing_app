import 'package:e_ommerce_product_listing_app/features/products/domain/entities/product_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'dimensions_model.dart';
import 'product_meta_model.dart';
import 'review_model.dart';

part 'product_model.freezed.dart';
part 'product_model.g.dart';

@freezed
abstract class ProductModel with _$ProductModel {
  const factory ProductModel({
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
    DimensionsModel? dimensions,
    String? warrantyInformation,
    String? shippingInformation,
    String? availabilityStatus,
    List<ReviewModel>? reviews,
    String? returnPolicy,
    int? minimumOrderQuantity,
    ProductMetaModel? meta,
    List<String>? images,
    String? thumbnail,
  }) = _ProductModel;

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);
}

extension ProductModelX on ProductModel {
  ProductEntity toEntity() => ProductEntity(
    id: id,
    title: title,
    description: description,
    category: category,
    price: price,
    discountPercentage: discountPercentage,
    rating: rating,
    stock: stock,
    tags: tags,
    brand: brand,
    sku: sku,
    weight: weight,
    dimensions: dimensions?.toEntity(),
    warrantyInformation: warrantyInformation,
    shippingInformation: shippingInformation,
    availabilityStatus: availabilityStatus,
    reviews: reviews?.map((ReviewModel e) => e.toEntity()).toList(),
    returnPolicy: returnPolicy,
    minimumOrderQuantity: minimumOrderQuantity,
    meta: meta?.toEntity(),
    images: images,
    thumbnail: thumbnail,
  );
}
