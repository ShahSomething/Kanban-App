// ignore_for_file: library_prefixes, only_throw_errors, strict_raw_type

import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:http_parser/http_parser.dart' as http_parser;
import 'package:kanban/core/errors/failures.dart';
import 'package:kanban/core/services/network/dio_error_handler.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

abstract class IDioWrapper {
  Future<Response<dynamic>> onPost({
    required String api,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  });

  Future<Response<dynamic>> onPostImageData({
    required String api,
    required String data,
  });

  Future<Response<dynamic>> onPatch({
    required String api,
    required dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  });

  Future<Response<dynamic>> onGet({
    required String api,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    bool isPullToRefresh = false,
  });

  void resolveAPIMetadata({
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  });

  void onCancel();

  Future<String> downloadFile(String path);
}

class DioWrapperImpl extends IDioWrapper {
  DioWrapperImpl({
    required Dio dio,
    required DioErrorHandler dioErrorHandler,
    required Logger logger,
    required HiveCacheStore cacheStore,
  })  : _dio = dio,
        _dioErrorHandler = dioErrorHandler,
        _logger = logger,
        _cacheStore = cacheStore;
  final Dio _dio;
  final DioErrorHandler _dioErrorHandler;
  final Logger _logger;
  CancelToken? _cancelToken;
  final HiveCacheStore _cacheStore;

  @override
  Future<Response<dynamic>> onPost({
    required String api,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    _cancelToken = CancelToken();
    try {
      resolveAPIMetadata(queryParameters: queryParameters, headers: headers);
      return await _dio.post(
        api,
        data: data,
        cancelToken: _cancelToken,
        onSendProgress: (int sent, int total) {},
      );
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        throw const DioTimeoutError(
          message: 'Timeout Error',
        );
      }
      if (e.response != null) {
        _logger.f('[ON POST | DIO ERROR | API $api] ${e.response}');
        throw _dioErrorHandler.resolveErrors(response: e.response!);
      }
      if (e.type == DioExceptionType.cancel) {
        throw _dioErrorHandler.handleCancelRequestFailure();
      } else {
        throw _dioErrorHandler.throwDefaultFailure();
      }
    } catch (e) {
      _logger.f('[ON POST | SOMETHING GOES WRONG IN API CALL] $e');
      throw _dioErrorHandler.throwDefaultFailure();
    }
  }

  @override
  Future<Response> onPostImageData({
    required String api,
    required String data,
  }) async {
    try {
      final extensionType = data.split('/').last.split('.').last;
      resolveAPIMetadata();
      final formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(
          data,
          filename: data.split('/').last,
          contentType: http_parser.MediaType('image', extensionType),
        ),
      });
      return await _dio.post(api, data: formData);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        throw const DioTimeoutError(message: 'Timeout Error');
      }
      if (e.response != null) {
        _logger.f('[ON POST | DIO ERROR | API $api] ${e.response}');
        throw _dioErrorHandler.resolveErrors(response: e.response!);
      }
      throw _dioErrorHandler.throwDefaultFailure();
    } catch (e) {
      _logger.f('[ON POST | SOMETHING GOES WRONG IN API CALL] $e');
      throw _dioErrorHandler.throwDefaultFailure();
    }
  }

  @override
  Future<Response<dynamic>> onPatch({
    required String api,
    required dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      resolveAPIMetadata(queryParameters: queryParameters, headers: headers);
      return await _dio.patch(api, data: data);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        throw const DioTimeoutError(message: 'Timeout Error');
      }
      if (e.response != null) {
        _logger.f('[ON PATCH | DIO ERROR | API $api] ${e.response}');
        throw _dioErrorHandler.resolveErrors(response: e.response!);
      }
      throw _dioErrorHandler.throwDefaultFailure();
    } catch (e) {
      _logger.f('[ON PATCH | SOMETHING GOES WRONG IN API CALL] $e');
      throw _dioErrorHandler.throwDefaultFailure();
    }
  }

  @override
  Future<Response<dynamic>> onGet({
    required String api,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    bool isPullToRefresh = false,
  }) async {
    _cancelToken = CancelToken();
    try {
      //For caching the response
      _dio.interceptors
          .removeWhere((element) => element is DioCacheInterceptor);
      _dio.interceptors.add(
        DioCacheInterceptor(
          options: getCacheOptions(api, isPullToRefresh: isPullToRefresh),
        ),
      );

      resolveAPIMetadata(queryParameters: queryParameters, headers: headers);
      return await _dio.get(api, cancelToken: _cancelToken);
    } on DioException catch (e) {
      _logger.f('[ON GET | DIO ERROR | API $api] $e');
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        throw const DioTimeoutError(
          message: 'Timeout Error',
        );
      }
      if (e.response != null) {
        throw _dioErrorHandler.resolveErrors(response: e.response!);
      }
      throw _dioErrorHandler.throwDefaultFailure();
    } catch (e) {
      _logger.f('[ON GET | SOMETHING GOES WRONG IN API CALL] $e');
      throw _dioErrorHandler.throwDefaultFailure();
    }
  }

  @override
  void resolveAPIMetadata({
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) {
    _dio.options.queryParameters.clear();
    if (queryParameters != null) {
      _dio.options.queryParameters.addAll(queryParameters);
    }
    if (headers != null) {
      _dio.options.headers.addAll(headers);
    }
  }

  @override
  void onCancel() {
    _cancelToken?.cancel('Replacing with a new request');
  }

  CacheOptions getCacheOptions(String api, {bool isPullToRefresh = false}) {
    var policy = CachePolicy.noCache;
    const cacheDuration = 120;

    if (isPullToRefresh) {
      policy = CachePolicy.refreshForceCache;
    } else {
      policy = CachePolicy.forceCache;
    }

    return CacheOptions(
      store: _cacheStore,
      policy: policy,
      priority: CachePriority.high,
      maxStale: const Duration(seconds: cacheDuration),
      hitCacheOnErrorExcept: [401, 404],
      keyBuilder: (request) {
        return request.uri.toString();
      },
    );
  }

  @override
  Future<String> downloadFile(String path) async {
    try {
      final appDir = await getApplicationDocumentsDirectory();
      final fileExtension = path.substring(path.lastIndexOf('.'));
      final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      final filename = 'Kanban_$timestamp$fileExtension';
      final savePath = '${appDir.path}/$filename';
      final extensions = ['png', 'jpg', 'jpeg'];
      var headers = <String, dynamic>{};
      if (extensions.contains(path.split('.').last)) {
        headers = {'Accept': 'image/jpeg,image/png'};
      } else {
        headers = {'Accept': 'application/pdf'};
      }

      await Dio().download(
        path,
        savePath,
        options: Options(
          headers: headers,
        ),
      );
      return savePath;
      // ignore: deprecated_member_use
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        throw const DioTimeoutError(message: 'Timeout Error');
      }
      if (e.type == DioExceptionType.connectionError) {
        throw const ServerFailure('No Internet Connection');
      } else {
        if (e.response != null) {
          throw _dioErrorHandler.resolveErrors(response: e.response!);
        }
      }
      throw _dioErrorHandler.throwDefaultFailure();
    } catch (e) {
      throw _dioErrorHandler.throwDefaultFailure();
    }
  }
}
