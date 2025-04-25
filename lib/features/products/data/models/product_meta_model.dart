import 'package:e_ommerce_product_listing_app/features/products/domain/entities/product_meta_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_meta_model.freezed.dart';
part 'product_meta_model.g.dart';

@freezed
abstract class ProductMetaModel with _$ProductMetaModel {
  const factory ProductMetaModel({
    DateTime? createdAt,
    DateTime? updatedAt,
    String? barcode,
    String? qrCode,
  }) = _ProductMetaModel;

  factory ProductMetaModel.fromJson(Map<String, dynamic> json) =>
      _$ProductMetaModelFromJson(json);
}

extension ProductMetaModelX on ProductMetaModel {
  ProductMetaEntity toEntity() => ProductMetaEntity(
    createdAt: createdAt,
    updatedAt: updatedAt,
    barcode: barcode,
    qrCode: qrCode,
  );
}
