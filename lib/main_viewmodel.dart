import 'package:flutter/cupertino.dart';
import 'package:okx_demo/Api.dart';
import 'package:okx_demo/model/ticker.dart';

class MainViewModel with ChangeNotifier {
  List<Ticker> tickers = [];

  void getMarketTickers() async {
    await Api.instance.getMarketInstType().then((tickers) {
      this.tickers = tickers;
      print("tickers size: ${this.tickers.length}");
      notifyListeners();
    });
  }
}
