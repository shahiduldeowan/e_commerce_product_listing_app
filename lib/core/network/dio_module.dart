import 'package:dio/dio.dart';
import 'package:e_ommerce_product_listing_app/core/network/interceptors/logger_interceptor.dart';
import 'package:e_ommerce_product_listing_app/core/network/interceptors/unauth_interceptor.dart';
import 'package:e_ommerce_product_listing_app/core/utils/environments.dart';
import 'package:injectable/injectable.dart';

final String _baseUrl = Environments.appBaseUrl;
const Duration _requestTimeoutInSeconds = Duration(seconds: 30);

@module
abstract class DioModule {
  @Named('Unauthorized')
  @singleton
  Dio createUnauthorizedDioClient() {
    final Dio dioClient = _dioClient();
    dioClient.interceptors.addAll(<Interceptor>[
      UnauthInterceptor(),
      LoggingInterceptor(),
    ]);

    return dioClient;
  }

  Dio _dioClient() {
    final BaseOptions baseOptions = BaseOptions(
      baseUrl: _baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: _requestTimeoutInSeconds,
      receiveTimeout: _requestTimeoutInSeconds,
    );
    return Dio(baseOptions);
  }
}
