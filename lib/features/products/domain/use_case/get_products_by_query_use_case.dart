import 'package:e_ommerce_product_listing_app/core/core_exports.dart';
import 'package:e_ommerce_product_listing_app/core/utils/type_defs.dart';
import 'package:e_ommerce_product_listing_app/features/products/domain/entities/pagination_params.dart';
import 'package:e_ommerce_product_listing_app/features/products/domain/entities/product_list_entity.dart';
import 'package:e_ommerce_product_listing_app/features/products/domain/repository/product_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetProductsByQueryUseCase
    extends UseCase<ProductListEntity, PaginationParams> {
  GetProductsByQueryUseCase(this._productRepository);

  final ProductRepository _productRepository;

  @override
  FutureResult<ProductListEntity> call({PaginationParams? param}) {
    return _productRepository.getProductsByQueryParam(param!);
  }
}
