import 'package:freezed_annotation/freezed_annotation.dart';
import 'product_entity.dart';

part 'product_list_entity.freezed.dart';

@freezed
abstract class ProductListEntity with _$ProductListEntity {
  const factory ProductListEntity({
    List<ProductEntity>? products,
    int? total,
    int? skip,
    int? limit,
  }) = _ProductListEntity;
}
