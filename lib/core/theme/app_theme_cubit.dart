import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppThemeCubit extends Cubit<AppThemeState> {
  final _platformDispatcher = WidgetsBinding.instance.platformDispatcher;
  AppThemeCubit() : super(_buildThemeMode()){
    initialize();
  }
  void initialize() {
    _platformDispatcher.onPlatformBrightnessChanged =
        () => _onBrightnessChanged();
  }

  void _onBrightnessChanged() {
    emit(_buildThemeMode());
  }
}

AppThemeState _buildThemeMode() {
  final brightness =
      WidgetsBinding.instance.platformDispatcher.platformBrightness;
  final themeMode =
      brightness == Brightness.light ? ThemeMode.light : ThemeMode.dark;
  return AppThemeState(mode: themeMode);
}

class AppThemeState {
  final ThemeMode mode;
  const AppThemeState({required this.mode});
}
