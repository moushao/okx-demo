import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart' show SvgPicture;
import 'package:get/get.dart';

import '../l10n/app_localizations.dart';

class NavigationBarWidget extends StatefulWidget {
  final List<Widget> pages;
  ValueChanged<int>? onTapChange;
  int currentIndex = 0;

  NavigationBarWidget({super.key,
    required this.pages,
    this.currentIndex = 0,
    this.onTapChange,
  });

  @override
  State<StatefulWidget> createState() {
    return _NavigationBarState();
  }
}

class _NavigationBarState extends State<NavigationBarWidget> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.currentIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(index: _currentIndex, children: widget.pages),
      ),
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.fixed,
        color: Colors.grey.shade400,
        activeColor: Colors.grey.shade900,
        backgroundColor: Colors.transparent,
        items: _buildItems(context),
        initialActiveIndex: _currentIndex,
        onTap: (index){
          setState(() {
            _currentIndex = index;
          });
          widget.onTapChange?.call(index);
        },
      ),
    );
  }
}



List<TabItem> _buildItems(BuildContext context) {
  var items = <TabItem>[];
  // items.add(_buildTabItem('icon_main_grey.svg', 'icon_main.svg', "欧易"));
  // items.add(_buildTabItem('icon_markets_grey.svg', 'icon_markets.svg', "市场"));
  // items.add(_buildTabItem('icon_exchange_grey.svg', 'icon_exchange.svg', "交易"));
  // items.add(_buildTabItem('icon_explore_grey.svg', 'icon_explore.svg', "探索"));
  // items.add(_buildTabItem('icon_assets_grey.svg', 'icon_assets.svg', "资产"));

  items.add(_buildTabItem('icon_main_grey.svg', 'icon_main.svg', AppLocalizations.of(Get.context!)!.okx));
  items.add(_buildTabItem('icon_markets_grey.svg', 'icon_markets.svg', AppLocalizations.of(context)!.market));
  items.add(_buildTabItem('icon_exchange_grey.svg', 'icon_exchange.svg', AppLocalizations.of(context)!.exchange));
  items.add(_buildTabItem('icon_explore_grey.svg', 'icon_explore.svg', AppLocalizations.of(context)!.explore));
  items.add(_buildTabItem('icon_assets_grey.svg', 'icon_assets.svg', AppLocalizations.of(context)!.assets));
  print("okx的中文是:${AppLocalizations.of(context)!.okx}");
  return items;
}

TabItem _buildTabItem(String activeIcon, String icon, String title) {
  return TabItem(
    icon: SvgPicture.asset("assets/svg/$activeIcon", width: 24, height: 24),
    activeIcon: SvgPicture.asset("assets/svg/$icon", width: 24, height: 24),
    title: title,
  );
}
