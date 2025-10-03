import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:okx_demo/business/assets/assets_page.dart';
import 'package:okx_demo/business/explore/explore_page.dart';
import 'package:okx_demo/business/main/main_page.dart';
import 'package:okx_demo/business/market/market_page.dart';
import 'package:okx_demo/business/trade/trade_page.dart';
import '../bar/navigation_bar_widget.dart';

class TabPage extends StatefulWidget {
  const TabPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TabPageState();
  }
}

class _TabPageState extends State<TabPage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return NavigationBarWidget(
      pages: [
        MainPage(),
        MarketPage(),
        TradePage(),
        ExplorePage(),
        AssetsPage(),
      ],
      currentIndex: currentIndex,
      onTapChange: (index) {
        setState(() {
          currentIndex = index;
        });
      },
    );
  }
}
