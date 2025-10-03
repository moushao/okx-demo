import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RouteUtils {
  RouteUtils._();

  static final navigatorKey = GlobalKey<NavigatorState>();

  static BuildContext get context => navigatorKey.currentContext!;

  static NavigatorState get navigator => navigatorKey.currentState!;

  ///普通动态跳转-->page
  static Future push(
    BuildContext context,
    Widget page, {
    bool? fullscreenDialog,
    RouteSettings? settings,
    bool maintainState = true,
  }) {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => page,
        fullscreenDialog: fullscreenDialog ?? false,
        settings: settings,
        maintainState: maintainState,
      ),
    );
  }

  ///根据路径跳转
  static Future pushForNamed(
    BuildContext context,
    String name, {
    Object? arguments,
  }) {
    return Navigator.pushNamed(context, name, arguments: arguments);
  }

  ///自定义route动态跳转
  static Future pushForPageRoute(BuildContext context, Route route) {
    return Navigator.push(context, route);
  }

  ///清空栈,只留目标页面
  static Future pushNamedAndRemoveUntil(
    BuildContext context,
    String name, {
    Object? arguments,
  }) {
    return Navigator.pushNamedAndRemoveUntil(
      context,
      name,
      (route) => false,
      arguments: arguments,
    );
  }

  ///清空栈,只留目标页面
  static Future pushAndRemoveUntil(
    BuildContext context,
    Widget page, {
    bool? fullscreenDialog,
    RouteSettings? settings,
    bool maintainState = true,
  }) {
    return Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => page,
        fullscreenDialog: fullscreenDialog ?? false,
        settings: settings,
        maintainState: maintainState,
      ),
      (route) => false,
    );
  }

  ///用新的路由替换当路由
  static Future pushReplacement(
    BuildContext context,
    Route route, {
    Object? result,
  }) {
    return Navigator.pushReplacement(context, route, result: result);
  }

  ///用新的路由替换当路由
  static Future pushReplacementNamed(
    BuildContext context,
    String name, {
    Object? result,
    Object? arguments,
  }) {
    return Navigator.pushReplacementNamed(
      context,
      name,
      arguments: arguments,
      result: result,
    );
  }
}
