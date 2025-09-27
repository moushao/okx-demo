import 'dart:ffi';

import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

Widget MainBottomBar = ConvexAppBar(
  style: TabStyle.fixed,
  backgroundColor: Colors.transparent,
  items: _buildItems(),
  initialActiveIndex: 1,
  onTap: (int i) => print('click index=$i'),
);

List<TabItem> _buildItems() {
  var items = <TabItem>[];
  items.add(_buildTabItem('assets/png/icon_main_grey.png','assets/png/icon_main.png',"欧易"));
  items.add(_buildTabItem('assets/png/icon_markets_grey.png','assets/png/icon_markets.png',"市场"));
  items.add(_buildTabItem('assets/png/icon_trade_grey.png','assets/png/icon_trade.png',"交易"));
  items.add(_buildTabItem('assets/png/icon_explore_grey.png','assets/png/icon_explore.png',"探索"));
  items.add(_buildTabItem('assets/png/icon_assets_grey.png','assets/png/icon_assets.png',"资产"));
  return items;
}

TabItem _buildTabItem(String activeIcon, String icon, String title) {
  return TabItem(
    icon: Image.asset(
      icon,
      width: 24,
      height: 24,
    ),
    activeIcon: Image.asset(
      activeIcon,
      width: 24,
      height: 24,
    ),
    title: title,
  );
}
