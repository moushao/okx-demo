import 'package:dio/dio.dart';
import 'package:okx_demo/model/ticker.dart';

import 'network/dio_instance.dart';

class Api {
  static Api instance = Api._();

  Api._();

  Future<List<Ticker>> getMarketInstType() async {
    Response response = await DioInstance.getInstance().get(
      path: 'api/v5/market/tickers?instType=SPOT',
    );
    return Ticker.fromJsonToList(response.data);
  }
}
