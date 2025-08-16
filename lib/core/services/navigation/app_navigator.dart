import 'package:flutter/widgets.dart';

class AppNavigator {
  final GlobalKey<NavigatorState> _navigatorKey;
  AppNavigator({required GlobalKey<NavigatorState> navigatorKey})
    : _navigatorKey = navigatorKey;

  Future<void> pushNamed(String routeName, {Object? args}) async {
    await _navigatorKey.currentState!.pushNamed(routeName, arguments: args);
  }

  void replaceNamed(String route, {Object? extra}) {
    _navigatorKey.currentState!.popAndPushNamed(route, arguments: extra);
  }

  void popUntil(bool Function(Route<dynamic>) predicate) {
    _navigatorKey.currentState!.popUntil(predicate);
  }

  Future<T?> pushNamedAndRemoveUntil<T extends Object?>(
    String route,
    bool Function(Route<dynamic>) predicate,
  ) {
    return _navigatorKey.currentState!.pushNamedAndRemoveUntil(
      route,
      predicate,
    );
  }

  void pop<T extends Object?>([T? result]) {
    _navigatorKey.currentState!.pop<T>(result);
  }

  Future<bool> maybePop<T extends Object?>([T? result]) {
    return _navigatorKey.currentState!.maybePop<T>(result);
  }
}
