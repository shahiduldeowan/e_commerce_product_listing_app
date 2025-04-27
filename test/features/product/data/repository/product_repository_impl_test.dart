import 'package:dartz/dartz.dart';
import 'package:e_ommerce_product_listing_app/core/errors/failures.dart';
import 'package:e_ommerce_product_listing_app/features/products/data/models/product_model.dart';
import 'package:e_ommerce_product_listing_app/features/products/domain/entities/product_list_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:e_ommerce_product_listing_app/features/products/data/models/product_list_model.dart';
import 'package:e_ommerce_product_listing_app/features/products/domain/entities/pagination_params.dart';
import 'package:e_ommerce_product_listing_app/features/products/domain/repository/product_repository.dart';
import 'package:e_ommerce_product_listing_app/features/products/data/repository/product_repository_impl.dart';
import 'package:e_ommerce_product_listing_app/features/products/data/data_source/product_remote_data_source.dart';

class MockProductRemoteDataSource extends Mock
    implements ProductRemoteDataSource {}

void main() {
  group('ProductRepositoryImpl', () {
    late ProductRepository repository;
    late MockProductRemoteDataSource mockRemoteDataSource;

    setUp(() {
      mockRemoteDataSource = MockProductRemoteDataSource();
      repository = ProductRepositoryImpl(mockRemoteDataSource);
    });

    const PaginationParams tPaginationParams = PaginationParams(
      page: 1,
      limit: 10,
    );
    const ProductListModel tProductListModel = ProductListModel(
      products: <ProductModel>[],
      total: 0,
    );
    test(
      'should return Right(ProductListEntity) when remote call succeeds',
      () async {
        when(
          () => mockRemoteDataSource.getProductsByQueryParam(10, 10),
        ).thenAnswer((_) async => tProductListModel);

        final Either<Failure, ProductListEntity> result = await repository
            .getProductsByQueryParam(tPaginationParams);

        expect(result.isRight(), true);
        verify(
          () => mockRemoteDataSource.getProductsByQueryParam(10, 10),
        ).called(1);
      },
    );

    test('should return Left(Failure) when remote call throws error', () async {
      when(
        () => mockRemoteDataSource.getProductsByQueryParam(10, 10),
      ).thenThrow(Exception('Network error'));

      final Either<Failure, ProductListEntity> result = await repository
          .getProductsByQueryParam(tPaginationParams);

      expect(result.isLeft(), true);
      verify(
        () => mockRemoteDataSource.getProductsByQueryParam(10, 10),
      ).called(1);
    });
  });
}
