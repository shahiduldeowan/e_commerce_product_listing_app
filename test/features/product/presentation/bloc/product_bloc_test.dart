import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:e_ommerce_product_listing_app/features/products/domain/entities/product_entity.dart';
import 'package:e_ommerce_product_listing_app/features/products/domain/entities/product_list_entity.dart';
import 'package:e_ommerce_product_listing_app/features/products/domain/entities/pagination_params.dart';
import 'package:e_ommerce_product_listing_app/features/products/domain/use_case/get_products_by_query_use_case.dart';
import 'package:e_ommerce_product_listing_app/core/errors/failures.dart';
import 'package:e_ommerce_product_listing_app/features/products/presentation/bloc/product_bloc.dart';

class MockGetProductsByQueryUseCase extends Mock
    implements GetProductsByQueryUseCase {}

void main() {
  group('ProductBloc', () {
    late ProductBloc productBloc;
    late MockGetProductsByQueryUseCase mockGetProductsByQueryUseCase;

    setUp(() {
      mockGetProductsByQueryUseCase = MockGetProductsByQueryUseCase();
      productBloc = ProductBloc(mockGetProductsByQueryUseCase);
    });

    tearDown(() {
      productBloc.close();
    });

    const ProductEntity tProductEntity = ProductEntity(
      id: 1,
      title: 'Test Product',
      price: 100.0,
      description: 'Test Description',
      category: 'Test Category',
      images: <String>['https://example.com/image.png'],
      isFavorite: false,
    );

    const ProductListEntity tProductListEntity = ProductListEntity(
      products: <ProductEntity>[tProductEntity],
      total: 1,
      skip: 0,
      limit: 10,
    );

    blocTest<ProductBloc, ProductState>(
      'emits [loading, success] when ProductEventFetchInit is added and fetch is successful',
      build: () {
        when(
          () => mockGetProductsByQueryUseCase(param: any(named: 'param')),
        ).thenAnswer(
          (_) async =>
              const Right<Failure, ProductListEntity>(tProductListEntity),
        );
        return productBloc;
      },
      act: (ProductBloc bloc) => bloc.add(const ProductEventFetchInit()),
      expect:
          () => <ProductState>[
            const ProductState(
              status: ProductStatus.success,
              products: <ProductEntity>[tProductEntity],
              currentPage: 1,
              totalItems: 1,
              hasReachedMax: true,
            ),
          ],
      verify: (_) {
        verify(
          () => mockGetProductsByQueryUseCase(
            param: const PaginationParams(page: 1, limit: 10),
          ),
        ).called(1);
      },
    );

    blocTest<ProductBloc, ProductState>(
      'emits [failure] when ProductEventFetchInit is added and fetch fails',
      build: () {
        when(
          () => mockGetProductsByQueryUseCase(param: any(named: 'param')),
        ).thenAnswer(
          (_) async => const Left<Failure, ProductListEntity>(
            Failure.unexpected(
              message: 'Server Error',
              stackTrace: StackTrace.empty,
            ),
          ),
        );
        return productBloc;
      },
      act: (ProductBloc bloc) => bloc.add(const ProductEventFetchInit()),
      expect:
          () => <ProductState>[
            const ProductState(
              status: ProductStatus.failure,
              errorMessage: 'Server Error',
            ),
          ],
      verify: (_) {
        verify(
          () => mockGetProductsByQueryUseCase(
            param: const PaginationParams(page: 1),
          ),
        ).called(1);
      },
    );

    blocTest<ProductBloc, ProductState>(
      'emits [loading, success] when ProductEventFetchNext is added and fetch is successful',
      build: () {
        when(
          () => mockGetProductsByQueryUseCase(param: any(named: 'param')),
        ).thenAnswer(
          (_) async =>
              const Right<Failure, ProductListEntity>(tProductListEntity),
        );
        return productBloc;
      },
      seed:
          () => const ProductState(
            products: <ProductEntity>[tProductEntity],
            currentPage: 1,
            totalItems: 2,
            hasReachedMax: false,
          ),
      act: (ProductBloc bloc) => bloc.add(const ProductEventFetchNext()),
      expect:
          () => <ProductState>[
            const ProductState(
              status: ProductStatus.loading,
              products: <ProductEntity>[tProductEntity],
              currentPage: 1,
              totalItems: 2,
              hasReachedMax: false,
            ),
            const ProductState(
              status: ProductStatus.success,
              products: <ProductEntity>[tProductEntity, tProductEntity],
              currentPage: 2,
              totalItems: 1,
              hasReachedMax: true,
            ),
          ],
    );

    blocTest<ProductBloc, ProductState>(
      'emits [refreshing, success] when ProductEventRefresh is added',
      build: () {
        when(
          () => mockGetProductsByQueryUseCase(param: any(named: 'param')),
        ).thenAnswer(
          (_) async =>
              const Right<Failure, ProductListEntity>(tProductListEntity),
        );
        return productBloc;
      },
      act: (ProductBloc bloc) => bloc.add(const ProductEventRefresh()),
      expect:
          () => <ProductState>[
            const ProductState(status: ProductStatus.refreshing),
            const ProductState(
              status: ProductStatus.success,
              products: <ProductEntity>[tProductEntity],
              currentPage: 1,
              totalItems: 1,
              hasReachedMax: true,
            ),
          ],
    );

    blocTest<ProductBloc, ProductState>(
      'toggles isFavorite for a product when ProductEventFavorite is added',
      build: () => productBloc,
      seed:
          () => const ProductState(
            products: <ProductEntity>[tProductEntity],
            status: ProductStatus.success,
          ),
      act: (ProductBloc bloc) => bloc.add(const ProductEventFavorite(1)),
      expect:
          () => <ProductState>[
            ProductState(
              status: ProductStatus.success,
              products: <ProductEntity>[
                tProductEntity.copyWith(isFavorite: true),
              ],
            ),
          ],
    );
  });
}
