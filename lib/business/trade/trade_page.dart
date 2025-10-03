import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TradePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TradePageState();
  }
}

class _TradePageState extends State<TradePage> {
  var refreshController = RefreshController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SmartRefresher(
          controller: refreshController,
          enablePullDown: true,
          enablePullUp: true,
          header: ClassicHeader(),
          footer: ClassicFooter(),
          onLoading: () {},
          onRefresh: () {},
          child: SingleChildScrollView(child: Column(children: [Text("TradePage")])),
        ),
      ),
    );
  }
}
