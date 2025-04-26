import 'package:freezed_annotation/freezed_annotation.dart';

part 'pagination_params.freezed.dart';

@freezed
abstract class PaginationParams with _$PaginationParams {
  const factory PaginationParams({required int page, @Default(10) int limit}) =
      _PaginationParams;
}

extension PaginationParamsExt on PaginationParams {
  int get calculatedSkip => page * limit;
}
