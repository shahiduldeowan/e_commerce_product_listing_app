import 'package:dartz/dartz.dart';
import 'package:e_ommerce_product_listing_app/features/products/domain/entities/product_entity.dart';
import 'package:e_ommerce_product_listing_app/features/products/domain/use_case/get_products_by_query_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:e_ommerce_product_listing_app/features/products/domain/entities/pagination_params.dart';
import 'package:e_ommerce_product_listing_app/features/products/domain/entities/product_list_entity.dart';
import 'package:e_ommerce_product_listing_app/features/products/domain/repository/product_repository.dart';
import 'package:e_ommerce_product_listing_app/core/errors/failures.dart';

class MockProductRepository extends Mock implements ProductRepository {}

void main() {
  group('GetProductsByQueryUseCase', () {
    late GetProductsByQueryUseCase useCase;
    late MockProductRepository mockRepository;

    setUp(() {
      mockRepository = MockProductRepository();
      useCase = GetProductsByQueryUseCase(mockRepository);
    });

    const PaginationParams tPaginationParams = PaginationParams(page: 1);
    const ProductListEntity tProductListEntity = ProductListEntity(
      products: <ProductEntity>[],
      total: 0,
    );

    test('should return ProductListEntity when repository succeeds', () async {
      // arrange
      when(
        () => mockRepository.getProductsByQueryParam(tPaginationParams),
      ).thenAnswer(
        (_) async =>
            const Right<Failure, ProductListEntity>(tProductListEntity),
      );

      // act
      final Either<Failure, ProductListEntity> result = await useCase(
        param: tPaginationParams,
      );

      // assert
      expect(
        result,
        equals(const Right<Failure, ProductListEntity>(tProductListEntity)),
      );
      verify(
        () => mockRepository.getProductsByQueryParam(tPaginationParams),
      ).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('should return Failure when repository fails', () async {
      const Failure tFailure = Failure.unexpected(
        message: 'Server Error',
        stackTrace: StackTrace.empty,
      );

      when(
        () => mockRepository.getProductsByQueryParam(tPaginationParams),
      ).thenAnswer(
        (_) async => const Left<Failure, ProductListEntity>(tFailure),
      );

      // act
      final Either<Failure, ProductListEntity> result = await useCase(
        param: tPaginationParams,
      );

      // assert
      expect(result, equals(const Left<Failure, ProductListEntity>(tFailure)));
      verify(
        () => mockRepository.getProductsByQueryParam(tPaginationParams),
      ).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
