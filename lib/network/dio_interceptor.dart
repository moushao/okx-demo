import 'dart:developer';

import 'package:dio/dio.dart';

class DioLogInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log("\nrequest---");
    options.headers?.forEach((key, value) {
      log("请求头信息:key=$key value=${value.toString()}");
    });
    log("path:${options.uri}");
    log("method:${options.method}");
    log("data:${options.data}");
    log("queryParameters:${options.queryParameters.toString()}");
    log("<--------request\n");
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log("\nresponse---");
    log("realUri:${response.realUri}");
    log("headers:${response.headers.toString()}");
    log("statusMessage:${response.statusMessage}");
    log("statusCode:${response.statusCode}");
    log("extra:${response.extra}");
    log("data:${response.data}");
    log("<--------response\n");
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    log("\nerror---");
    log("realUri:${err.toString()}");
    log("<--------error\n");
    return super.onError(err, handler);
  }
}
