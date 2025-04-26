import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:e_ommerce_product_listing_app/core/errors/failures.dart';
import 'package:e_ommerce_product_listing_app/features/products/domain/entities/pagination_params.dart';
import 'package:e_ommerce_product_listing_app/features/products/domain/entities/product_list_entity.dart';
import 'package:e_ommerce_product_listing_app/features/products/domain/use_case/get_products_by_query_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_ommerce_product_listing_app/features/products/domain/entities/product_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'product_event.dart';
part 'product_state.dart';
part 'product_bloc.freezed.dart';

@injectable
class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProductsByQueryUseCase _getProductsByQueryUseCase;

  ProductBloc(this._getProductsByQueryUseCase) : super(const ProductState()) {
    on<ProductEventFetchInit>(_onProductEventFetchInit);
    on<ProductEventFetchNext>(_onProductEventFetchNext);
    on<ProductEventRefresh>(_onProductEventRefresh);
    on<ProductEventFavorite>(_onProductEventFavorite);
  }

  Future<void> _onProductEventFetchInit(
    ProductEventFetchInit event,
    Emitter<ProductState> emit,
  ) async => _fetchProductPage(emit, page: 1, isInitial: true);

  Future<void> _onProductEventFetchNext(
    ProductEventFetchNext event,
    Emitter<ProductState> emit,
  ) async {
    if (state.hasReachedMax) return;
    await _fetchProductPage(emit, page: state.currentPage + 1);
  }

  Future<void> _onProductEventRefresh(
    ProductEventRefresh event,
    Emitter<ProductState> emit,
  ) async {
    emit(state.copyWith(status: ProductStatus.refreshing));
    await _fetchProductPage(emit, page: 1, isRefresh: true);
  }

  Future<void> _onProductEventFavorite(
    ProductEventFavorite event,
    Emitter<ProductState> emit,
  ) async {
    final List<ProductEntity> newProducts =
        state.products.map((ProductEntity product) {
          if (product.id == event.id) {
            return product.copyWith(isFavorite: !product.isFavorite);
          }
          return product;
        }).toList();
    emit(state.copyWith(products: newProducts));
  }

  Future<void> _fetchProductPage(
    Emitter<ProductState> emit, {
    required int page,
    bool isInitial = false,
    bool isRefresh = false,
  }) async {
    if (!isInitial && !isRefresh) {
      emit(state.copyWith(status: ProductStatus.loading));
    }

    final Either<Failure, ProductListEntity> result =
        await _getProductsByQueryUseCase(
          param: PaginationParams(page: page, limit: state.limit),
        );

    result.fold(
      (Failure failure) => emit(
        state.copyWith(
          status: ProductStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (ProductListEntity productList) {
        final int? totalItems = productList.total;
        final List<ProductEntity>? newProducts =
            isRefresh
                ? productList.products
                : <ProductEntity>[
                  ...state.products,
                  if (productList.products?.isNotEmpty ?? false)
                    ...productList.products!,
                ];

        emit(
          state.copyWith(
            status: ProductStatus.success,
            products: newProducts ?? <ProductEntity>[],
            currentPage: page,
            totalItems: totalItems,
            hasReachedMax: _calculateHasReachedMax(
              newProducts?.length ?? 0,
              totalItems,
            ),
          ),
        );
      },
    );
  }

  bool _calculateHasReachedMax(int currentLength, [int? totalItems]) {
    return totalItems != null && currentLength >= totalItems;
  }
}
