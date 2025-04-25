import 'package:freezed_annotation/freezed_annotation.dart';

part 'dimensions_entity.freezed.dart';

@freezed
abstract class DimensionsEntity with _$DimensionsEntity {
  const factory DimensionsEntity({
    double? width,
    double? height,
    double? depth,
  }) = _DimensionsEntity;
}
