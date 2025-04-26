part of 'product_bloc.dart';

enum ProductStatus { initial, loading, success, failure, refreshing }

@freezed
abstract class ProductState with _$ProductState {
  const factory ProductState({
    @Default(ProductStatus.initial) ProductStatus status,
    @Default(<ProductEntity>[]) List<ProductEntity> products,
    @Default(0) int currentPage,
    @Default(false) bool hasReachedMax,
    @Default(10) int limit,
    int? totalItems,
    String? errorMessage,
  }) = _ProductState;
}
