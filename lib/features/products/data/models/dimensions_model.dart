import 'package:e_ommerce_product_listing_app/features/products/domain/entities/dimensions_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'dimensions_model.freezed.dart';
part 'dimensions_model.g.dart';

@freezed
abstract class DimensionsModel with _$DimensionsModel {
  const factory DimensionsModel({
    double? width,
    double? height,
    double? depth,
  }) = _DimensionsModel;

  factory DimensionsModel.fromJson(Map<String, dynamic> json) =>
      _$DimensionsModelFromJson(json);
}

extension DimensionsModelX on DimensionsModel {
  DimensionsEntity toEntity() {
    return DimensionsEntity(width: width, height: height, depth: depth);
  }
}
