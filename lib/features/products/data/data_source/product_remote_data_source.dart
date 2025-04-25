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
  Future<ProductListModel> getProducts();
}
