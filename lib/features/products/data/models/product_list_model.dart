import 'package:e_ommerce_product_listing_app/features/products/data/models/product_model.dart';
import 'package:e_ommerce_product_listing_app/features/products/domain/entities/product_list_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_list_model.freezed.dart';
part 'product_list_model.g.dart';

@freezed
abstract class ProductListModel with _$ProductListModel {
  const factory ProductListModel({
    List<ProductModel>? products,
    int? total,
    int? skip,
    int? limit,
  }) = _ProductListModel;

  factory ProductListModel.fromJson(Map<String, dynamic> json) =>
      _$ProductListModelFromJson(json);
}

extension ProductListModelX on ProductListModel {
  ProductListEntity toEntity() => ProductListEntity(
        products: products?.map((ProductModel e) => e.toEntity()).toList(),
        total: total,
        skip: skip,
        limit: limit,
      );
}
