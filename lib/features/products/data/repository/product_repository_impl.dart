import 'package:dartz/dartz.dart';
import 'package:e_ommerce_product_listing_app/core/core_exports.dart'
    show ErrorHandler, Failure;
import 'package:e_ommerce_product_listing_app/core/utils/type_defs.dart';
import 'package:e_ommerce_product_listing_app/features/products/data/data_source/product_remote_data_source.dart';
import 'package:e_ommerce_product_listing_app/features/products/data/models/product_list_model.dart';
import 'package:e_ommerce_product_listing_app/features/products/domain/entities/pagination_params.dart';
import 'package:e_ommerce_product_listing_app/features/products/domain/entities/product_list_entity.dart';
import 'package:e_ommerce_product_listing_app/features/products/domain/repository/product_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ProductRepository)
class ProductRepositoryImpl implements ProductRepository {
  ProductRepositoryImpl(this._productRemoteDataSource);

  final ProductRemoteDataSource _productRemoteDataSource;

  @override
  FutureResult<ProductListEntity> getProductsByQueryParam(
    PaginationParams params,
  ) async {
    try {
      final ProductListModel result = await _productRemoteDataSource
          .getProductsByQueryParam(params.limit, params.calculatedSkip);
      return Right<Failure, ProductListEntity>(result.toEntity());
    } catch (e) {
      final Failure failure = ErrorHandler.handleError(e);
      return Left<Failure, ProductListEntity>(failure);
    }
  }
}
