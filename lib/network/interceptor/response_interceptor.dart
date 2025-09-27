import 'package:dio/dio.dart';

import '../model/base_model.dart';

class ResponseInterceptor extends InterceptorsWrapper {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.statusCode == 200) {
      try {
        var res = BaseModel.fromJson(response.data);
        /// 0成功
        if (res.code == "0") {
          if (res.data == null) {
            handler.next(Response(requestOptions: response.requestOptions, data: true));
          } else if (res.code  == "-1001") {
            // showToast("请先登录");
            handler.reject(DioException(requestOptions: response.requestOptions,message: "请先登录"));
          }
          else {
            handler.next(Response(requestOptions: response.requestOptions, data: res.data));
          }
        }
      } catch (e) {
        handler.reject(DioException(requestOptions: response.requestOptions,message: e.toString()));
      }
    }else{
      handler.reject(DioException(requestOptions: response.requestOptions,message: response.statusMessage?? ""));
    }
  }
}
