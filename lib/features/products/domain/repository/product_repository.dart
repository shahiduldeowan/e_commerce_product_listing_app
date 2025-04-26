import 'package:e_ommerce_product_listing_app/core/utils/type_defs.dart';
import 'package:e_ommerce_product_listing_app/features/products/domain/entities/pagination_params.dart';
import 'package:e_ommerce_product_listing_app/features/products/domain/entities/product_list_entity.dart';

abstract class ProductRepository {
  FutureResult<ProductListEntity> getProductsByQueryParam(
    PaginationParams params,
  );
}
