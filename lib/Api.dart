import 'package:dio/dio.dart';

import 'network/dio_instance.dart';

class Api {

  void getMarketInstType() async {
    await DioInstance.getInstance().get(
      path: 'api/v5/market/tickers?instType=SPOT',
    );
  }
}
