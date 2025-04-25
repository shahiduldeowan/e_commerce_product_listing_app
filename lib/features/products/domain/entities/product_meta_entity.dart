import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_meta_entity.freezed.dart';

@freezed
abstract class ProductMetaEntity with _$ProductMetaEntity {
  const factory ProductMetaEntity({
    DateTime? createdAt,
    DateTime? updatedAt,
    String? barcode,
    String? qrCode,
  }) = _ProductMetaEntity;
}
