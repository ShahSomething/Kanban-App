// ignore_for_file: strict_raw_type

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DioCustomInterceptors extends Interceptor {
  DioCustomInterceptors({
    required this.dio,
  });
  final Dio dio;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    const accessToken =
        ""; // TODO: Get the access token from the shared preference
    options.headers['Authorization'] = 'Bearer $accessToken';

    super.onRequest(options, handler);
  }

  @override
  Future<void> onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    debugPrint(
      'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}',
    );
    super.onResponse(response, handler);
  }

  @override
  void onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) {
    handler.next(err);
    return;
  }
}
