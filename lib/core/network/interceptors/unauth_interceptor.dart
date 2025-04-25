import 'package:dio/dio.dart';
import 'package:e_ommerce_product_listing_app/core/utils/logger_utils.dart';

class UnauthInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      logger.e('🔒 Unauthorized!');
    }
    super.onError(err, handler);
  }
}
