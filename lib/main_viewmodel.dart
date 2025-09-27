import 'package:okx_demo/Api.dart';

class MainViewModel {
  void getMarketTickers() async {
      Api().getMarketInstType();
  }
}
