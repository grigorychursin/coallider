import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HookaThemeCubit extends Cubit<HookaThemeState> {
  final _platformDispatcher = WidgetsBinding.instance.platformDispatcher;
  HookaThemeCubit() : super(_buildThemeMode()){
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

HookaThemeState _buildThemeMode() {
  final brightness =
      WidgetsBinding.instance.platformDispatcher.platformBrightness;
  final themeMode =
      brightness == Brightness.light ? ThemeMode.light : ThemeMode.dark;
  return HookaThemeState(mode: themeMode);
}

class HookaThemeState {
  final ThemeMode mode;
  const HookaThemeState({required this.mode});
}
