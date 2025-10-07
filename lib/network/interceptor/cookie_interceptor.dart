import 'dart:io';

import 'package:dio/dio.dart';

import '../../constants/constants.dart';
import '../../utils/sp_utils.dart';

class CookieInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    try {
      final cookies = await SpUtils.getStringList(Constants.SP_KEY_COOKIES);
      // if (cookies.isNotEmpty) {
      //   options.headers[HttpHeaders.cookieHeader] = cookies;
      // }
    } catch (e) {
      print('Failed to get cookies: $e');
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.requestOptions.path.contains("user/login")) {
      dynamic list = response.headers[HttpHeaders.setCookieHeader];
      List<String> cookies = [];
      if (list is List) {
        for (String? item in list) {
          cookies.add(item ?? "");
          // print("CookieInterceptor cookie = ${item.toString()}");
        }
      }
      saveUserInfo(cookies.toString());
      SpUtils.saveStringList(Constants.SP_KEY_COOKIES, cookies);
    }

    if (response.requestOptions.path.contains("user/logout/json")) {
      SpUtils.removeAll();
    }
    return super.onResponse(response, handler);
  }

  void saveUserInfo(String input) {
    final cleaned = input.substring(1, input.length - 1);
    final cookies = cleaned.split(',');
    for (var cookie in cookies) {
      cookie = cookie.trim();
      if (cookie.startsWith(Constants.SP_KEY_USER_NAME)) {
        final parts = cookie.split('=');
        if (parts.length >= 2) {
          SpUtils.saveString(Constants.SP_KEY_USER_NAME,  parts[1].split(';')[0]);
          break;
        }
      }
    }
  }
}
