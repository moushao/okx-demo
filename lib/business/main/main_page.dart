import 'dart:math';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:okx_demo/business/main/banner/main_banner.dart';
import 'package:okx_demo/business/main/sopt_list.dart';
import 'package:okx_demo/business/main/tabbar/sopt_bar.dart';
import 'package:okx_demo/model/ticker.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

import '../../main_viewmodel.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MainPageState();
  }
}

class _MainPageState extends State<MainPage> {
  var refreshController = RefreshController();
  var mv = MainViewModel();

  @override
  void initState() {
    super.initState();
    mv.getMarketTickers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ChangeNotifierProvider<MainViewModel>(
          create: (context) => mv,
          child: SmartRefresher(
            controller: refreshController,
            enablePullDown: true,
            enablePullUp: true,
            header: ClassicHeader(),
            footer: ClassicFooter(),
            onLoading: () {
              mv.getMarketTickers();
              refreshController.loadComplete();
            },
            onRefresh: () {
              mv.getMarketTickers();
              refreshController.refreshCompleted();
            },
            child: DefaultTabController(
              length: 3,
              initialIndex: 0,
              child: Column(
                children: [
                  MainBanner(),
                  SpotBar(),
                  Expanded(
                    child: TabBarView(
                      children: [
                        _buildTabContent([]), // 热门榜
                        _buildTabContent([]), // 涨幅榜
                        _buildTabContent([]), // 新币榜
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent(List<Ticker> tickers) {
    return Consumer<MainViewModel>(
      builder: (context, viewModel, child) {
        if (viewModel.tickers.isEmpty) {
          return Center(
            child: Text('暂无数据', style: TextStyle(color: Colors.grey)),
          );
        }

        return _buildTickerList(viewModel.tickers);
      },
    );
  }

  Widget _buildTickerList(List<Ticker> tickers) {
    return SpotList();
  }
}
