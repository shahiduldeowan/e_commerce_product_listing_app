import 'package:dio/dio.dart';
import 'package:e_ommerce_product_listing_app/features/products/data/models/product_list_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'product_remote_data_source.g.dart';

@lazySingleton
@RestApi(baseUrl: '/')
abstract class ProductRemoteDataSource {
  @factoryMethod
  factory ProductRemoteDataSource(@Named('Unauthorized') Dio dio) =
      _ProductRemoteDataSource;

  @GET('products')
  /// Fetches a list of products from the remote data source.
  ///
  /// Returns a [Future] that completes with a [ProductListModel]
  /// containing the list of products.
  Future<ProductListModel> getProducts();

  @GET('products')
  /// Get products by query parameters
  ///
  /// [limit] is the maximum number of products to return.
  /// [skip] is the number of products to skip before returning the result.
  ///
  Future<ProductListModel> getProductsByQueryParam(
    @Query('limit') int limit,
    @Query('skip') int skip,
  );
}
