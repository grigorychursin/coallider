import 'package:di/di.dart';
import 'package:flutter/material.dart';
import 'package:coallider/core/services/navigation/hooka_navigator.dart';
import 'package:coallider/core/theme/hooka_theme_cubit.dart';
import 'package:provider/provider.dart';

extension BuildContextExtension on BuildContext {
  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => Theme.of(this).textTheme;

  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  MediaQueryData get mediaQuery => MediaQuery.of(this);

  bool get isLightTheme =>
      watch<HookaThemeCubit>().state.mode == ThemeMode.light;
  void hideKeyboard() {
    final focusNode = FocusScope.of(this);
    if (!focusNode.hasPrimaryFocus) {
      focusNode.unfocus();
    }
  }
}

extension ResovlerExt on BuildContext {
  Resolver get resolver => Provider.of<Resolver>(this, listen: false);

  T resolve<T>([String? name]) =>
      Provider.of<Resolver>(this, listen: false).resolve<T>(name);

  HookaNavigator get navigator => read<HookaNavigator>();
}
