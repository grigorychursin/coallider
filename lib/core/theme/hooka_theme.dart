import 'package:flutter/material.dart';
import 'package:coallider/core/constants/hooka_colors.dart';

final class HookaTheme {
  static const _fontFamily = 'SFProDisplay';
  final light = ThemeData.light().copyWith(
    scaffoldBackgroundColor: HookaColors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: HookaColors.white,
      elevation: 0.0,
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: HookaColors.purpleA3,
      strokeWidth: 2.0,
      circularTrackColor: HookaColors.purpleA3.withAlpha(50),
    ),
    colorScheme: const ColorScheme.light(
      primary: HookaColors.purpleDark,
      secondary: HookaColors.purpleMedium,
      primaryContainer: HookaColors.purpleDark,
      secondaryContainer: HookaColors.purpleMedium,
      tertiaryContainer: HookaColors.purpleLight,
      tertiary: HookaColors.purpleLight,
      surface: HookaColors.white,
      error: HookaColors.black,
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: HookaColors.purpleMedium,
      behavior: SnackBarBehavior.fixed,
      closeIconColor: HookaColors.purpleDark,
      showCloseIcon: true,
      contentTextStyle: const TextStyle(
        color: HookaColors.black,
        fontSize: 14.0,
        fontWeight: FontWeight.w300,
        fontFamily: _fontFamily,
      ),
    ),
    sliderTheme: SliderThemeData(
      activeTrackColor: HookaColors.sliderActiveLight,
      inactiveTrackColor: HookaColors.white,
      thumbColor: HookaColors.sliderActiveLight,
      trackHeight: 13.0,
      overlayColor: Colors.transparent,
      padding: EdgeInsets.zero,
      showValueIndicator: ShowValueIndicator.always,
      valueIndicatorColor: HookaColors.white,
      valueIndicatorShape: RectangularSliderValueIndicatorShape(),
      valueIndicatorTextStyle: TextStyle(color: HookaColors.purpleA3),
    ),
    iconTheme: const IconThemeData(color: HookaColors.purpleDark),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        color: HookaColors.purpleDark,
        fontWeight: FontWeight.w500,
        fontSize: 32.0,
        fontFamily: _fontFamily,
      ),
      titleMedium: TextStyle(
        color: HookaColors.textPurple,
        fontWeight: FontWeight.w500,
        fontSize: 24.0,
        fontFamily: _fontFamily,
      ),
      titleSmall: TextStyle(
        color: HookaColors.black,
        fontWeight: FontWeight.w600,
        fontSize: 16.0,
        fontFamily: _fontFamily,
      ),
      headlineLarge: TextStyle(
        color: HookaColors.textPurple,
        fontWeight: FontWeight.w500,
        fontSize: 16.0,
        fontFamily: _fontFamily,
      ),
      headlineSmall: TextStyle(
        color: HookaColors.textPurple,
        fontWeight: FontWeight.w500,
        fontSize: 14.0,
        fontFamily: _fontFamily,
      ),
      bodyLarge: TextStyle(
        color: HookaColors.black,
        fontWeight: FontWeight.w500,
        fontSize: 20.0,
        fontFamily: _fontFamily,
      ),
      bodyMedium: TextStyle(
        color: HookaColors.textPurple,
        fontWeight: FontWeight.w500,
        fontSize: 16.0,
        fontFamily: _fontFamily,
      ),
      displayLarge: TextStyle(
        color: HookaColors.white,
        fontWeight: FontWeight.w500,
        fontSize: 16.0,
        fontFamily: _fontFamily,
      ),
    ),
  );
  final dark = ThemeData(
    scaffoldBackgroundColor: HookaColors.backgroundDark,
    appBarTheme: const AppBarTheme(
      backgroundColor: HookaColors.backgroundDark,
      elevation: 0.0,
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: HookaColors.yellow,
      showCloseIcon: true,
      closeIconColor: HookaColors.black,
      contentTextStyle: const TextStyle(
        color: HookaColors.black,
        fontSize: 14.0,
        fontWeight: FontWeight.w300,
        fontFamily: _fontFamily,
      ),
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: HookaColors.yellow,
      strokeWidth: 2.0,
      circularTrackColor: HookaColors.yellow.withAlpha(50),
    ),
    colorScheme: const ColorScheme.dark(
      primary: HookaColors.yellow,
      secondary: HookaColors.sliderActiveDark,
      tertiary: HookaColors.grey35,
      primaryContainer: HookaColors.yellow,
      secondaryContainer: HookaColors.sliderActiveDark,
      tertiaryContainer: HookaColors.grey3d,
    ),
    sliderTheme: SliderThemeData(
      activeTrackColor: HookaColors.sliderActiveDark,
      inactiveTrackColor: HookaColors.grey3d,
      trackHeight: 13.0,
      overlayColor: HookaColors.sliderActiveDark,
      showValueIndicator: ShowValueIndicator.always,
      padding: EdgeInsets.zero,
      valueIndicatorColor: HookaColors.yellow,
      valueIndicatorShape: RectangularSliderValueIndicatorShape(),
      valueIndicatorTextStyle: TextStyle(color: HookaColors.grey3d),
    ),
    iconTheme: const IconThemeData(color: HookaColors.white),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        color: HookaColors.white,
        fontWeight: FontWeight.w500,
        fontSize: 32.0,
        fontFamily: _fontFamily,
      ),
      titleMedium: TextStyle(
        color: HookaColors.white,
        fontWeight: FontWeight.w500,
        fontSize: 24.0,
        fontFamily: _fontFamily,
      ),
      titleSmall: TextStyle(
        color: HookaColors.white,
        fontWeight: FontWeight.w600,
        fontSize: 16.0,
        fontFamily: _fontFamily,
      ),
      headlineLarge: TextStyle(
        color: HookaColors.white,
        fontWeight: FontWeight.w500,
        fontSize: 16.0,
        fontFamily: _fontFamily,
      ),
      headlineSmall: TextStyle(
        color: HookaColors.white,
        fontWeight: FontWeight.w500,
        fontSize: 14.0,
        fontFamily: _fontFamily,
      ),
      bodyLarge: TextStyle(
        color: HookaColors.yellow,
        fontWeight: FontWeight.w500,
        fontSize: 20.0,
        fontFamily: _fontFamily,
      ),
      bodyMedium: TextStyle(
        color: HookaColors.yellow,
        fontWeight: FontWeight.w500,
        fontSize: 16.0,
        fontFamily: _fontFamily,
      ),
      displayLarge: TextStyle(
        color: HookaColors.black,
        fontWeight: FontWeight.w500,
        fontSize: 16.0,
        fontFamily: _fontFamily,
      ),
    ),
  );
}
