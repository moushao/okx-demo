import 'package:dio/dio.dart';

import '../constants/constants.dart';
import 'dio_interceptor.dart';
import 'http_method.dart';
import 'interceptor/cookie_interceptor.dart';
import 'interceptor/response_interceptor.dart';

class DioInstance {
  static DioInstance? _instance;

  DioInstance._();

  static DioInstance getInstance() {
    return _instance ??= DioInstance._();
  }

  final _defaultDuration = Duration(seconds: 30);

  Options _defaultOptions(String method) {
    return Options(
      method: method,
      receiveTimeout: _defaultDuration,
      sendTimeout: _defaultDuration,
      responseType: ResponseType.json,
    );
  }

  final _dio = Dio();

  void initDio({
    String? baseUrl = Constants.BASE_URL,
    String? httpMethod = HttpMethod.get,
    ResponseType? responseType = ResponseType.json,
    String? contentType,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
  }) {
    _dio.options = BaseOptions(
      method: httpMethod,
      baseUrl: baseUrl ?? Constants.BASE_URL,
      connectTimeout: connectTimeout ?? _defaultDuration,
      receiveTimeout: receiveTimeout ?? _defaultDuration,
      sendTimeout: sendTimeout ?? _defaultDuration,
      responseType: responseType,
      contentType: contentType,
      headers: {
        'User-Agent': 'Mozilla/5.0 (Linux; Android 10; SM-G975F) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.120 Mobile Safari/537.36',
        'Accept': 'application/json, text/plain, */*',
        'Accept-Language': 'en-US,en;q=0.9',
        'Accept-Encoding': 'gzip, deflate, br',
        'Connection': 'keep-alive',
        'DNT': '1',
        'Upgrade-Insecure-Requests': '1',
      },
    );
    // _dio.interceptors.add(CookieInterceptor());
    _dio.interceptors.add(DioLogInterceptor());
    _dio.interceptors.add(ResponseInterceptor());
  }

  Future<Response> get({
    required String path,
    Map<String, dynamic>? param,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    return await _dio.get(
      path,
      queryParameters: param,
      options: options ?? _defaultOptions(HttpMethod.get),
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
    );
  }

  Future<Response> post({
    required String path,
    Object? data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    Options? options,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    return await _dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options ?? _defaultOptions(HttpMethod.post),
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }
}
