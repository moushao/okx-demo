import 'package:flutter/material.dart';

import '../business/trade/trade_page.dart';
import '../tap/tab_pages.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePath.tab:
        return pageRoute(TabPage(), settings: settings);
      case RoutePath.webViewPage:
        return pageRoute(TradePage(), settings: settings);
      default:
        return pageRoute(
          Scaffold(
            body: SafeArea(
              child: Center(
                child: Text("route path: ${settings.name} not exist"),
              ),
            ),
          ),
        );
    }
  }

  static MaterialPageRoute pageRoute(
    Widget widget, {
    RouteSettings? settings,
    bool? fullscreenDialog,
    bool? maintainState,
    bool? allowSnapshotting,
  }) {
    return MaterialPageRoute(
      builder: (context) {
        return widget;
      },
      settings: settings,
      fullscreenDialog: fullscreenDialog ?? false,
      maintainState: maintainState ?? true,
      allowSnapshotting: allowSnapshotting ?? true,
    );
  }
}

class RoutePath {
  static const String tab = "/";
  static const String webViewPage = "/web_view_page";
}
