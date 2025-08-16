import 'package:flutter/material.dart';
import 'package:coallider/core/constants/app_colors.dart';

final class AppTheme {
  static const _fontFamily = 'SFProDisplay';
  final light = ThemeData.light().copyWith(
    scaffoldBackgroundColor: AppColors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.white,
      elevation: 0.0,
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: AppColors.purpleA3,
      strokeWidth: 2.0,
      circularTrackColor: AppColors.purpleA3.withAlpha(50),
    ),
    colorScheme: const ColorScheme.light(
      primary: AppColors.purpleDark,
      secondary: AppColors.purpleMedium,
      primaryContainer: AppColors.purpleDark,
      secondaryContainer: AppColors.purpleMedium,
      tertiaryContainer: AppColors.purpleLight,
      tertiary: AppColors.purpleLight,
      surface: AppColors.white,
      error: AppColors.black,
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.purpleMedium,
      behavior: SnackBarBehavior.fixed,
      closeIconColor: AppColors.purpleDark,
      showCloseIcon: true,
      contentTextStyle: const TextStyle(
        color: AppColors.black,
        fontSize: 14.0,
        fontWeight: FontWeight.w300,
        fontFamily: _fontFamily,
      ),
    ),
    sliderTheme: SliderThemeData(
      activeTrackColor: AppColors.sliderActiveLight,
      inactiveTrackColor: AppColors.white,
      thumbColor: AppColors.sliderActiveLight,
      trackHeight: 13.0,
      overlayColor: Colors.transparent,
      padding: EdgeInsets.zero,
      showValueIndicator: ShowValueIndicator.always,
      valueIndicatorColor: AppColors.white,
      valueIndicatorShape: RectangularSliderValueIndicatorShape(),
      valueIndicatorTextStyle: TextStyle(color: AppColors.purpleA3),
    ),
    iconTheme: const IconThemeData(color: AppColors.purpleDark),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        color: AppColors.purpleDark,
        fontWeight: FontWeight.w500,
        fontSize: 32.0,
        fontFamily: _fontFamily,
      ),
      titleMedium: TextStyle(
        color: AppColors.textPurple,
        fontWeight: FontWeight.w500,
        fontSize: 24.0,
        fontFamily: _fontFamily,
      ),
      titleSmall: TextStyle(
        color: AppColors.black,
        fontWeight: FontWeight.w600,
        fontSize: 16.0,
        fontFamily: _fontFamily,
      ),
      headlineLarge: TextStyle(
        color: AppColors.textPurple,
        fontWeight: FontWeight.w500,
        fontSize: 16.0,
        fontFamily: _fontFamily,
      ),
      headlineSmall: TextStyle(
        color: AppColors.textPurple,
        fontWeight: FontWeight.w500,
        fontSize: 14.0,
        fontFamily: _fontFamily,
      ),
      bodyLarge: TextStyle(
        color: AppColors.black,
        fontWeight: FontWeight.w500,
        fontSize: 20.0,
        fontFamily: _fontFamily,
      ),
      bodyMedium: TextStyle(
        color: AppColors.textPurple,
        fontWeight: FontWeight.w500,
        fontSize: 16.0,
        fontFamily: _fontFamily,
      ),
      displayLarge: TextStyle(
        color: AppColors.white,
        fontWeight: FontWeight.w500,
        fontSize: 16.0,
        fontFamily: _fontFamily,
      ),
    ),
  );
  final dark = ThemeData(
    scaffoldBackgroundColor: AppColors.backgroundDark,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.backgroundDark,
      elevation: 0.0,
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.yellow,
      showCloseIcon: true,
      closeIconColor: AppColors.black,
      contentTextStyle: const TextStyle(
        color: AppColors.black,
        fontSize: 14.0,
        fontWeight: FontWeight.w300,
        fontFamily: _fontFamily,
      ),
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: AppColors.yellow,
      strokeWidth: 2.0,
      circularTrackColor: AppColors.yellow.withAlpha(50),
    ),
    colorScheme: const ColorScheme.dark(
      primary: AppColors.yellow,
      secondary: AppColors.sliderActiveDark,
      tertiary: AppColors.grey35,
      primaryContainer: AppColors.yellow,
      secondaryContainer: AppColors.sliderActiveDark,
      tertiaryContainer: AppColors.grey3d,
    ),
    sliderTheme: SliderThemeData(
      activeTrackColor: AppColors.sliderActiveDark,
      inactiveTrackColor: AppColors.grey3d,
      trackHeight: 13.0,
      overlayColor: AppColors.sliderActiveDark,
      showValueIndicator: ShowValueIndicator.always,
      padding: EdgeInsets.zero,
      valueIndicatorColor: AppColors.yellow,
      valueIndicatorShape: RectangularSliderValueIndicatorShape(),
      valueIndicatorTextStyle: TextStyle(color: AppColors.grey3d),
    ),
    iconTheme: const IconThemeData(color: AppColors.white),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        color: AppColors.white,
        fontWeight: FontWeight.w500,
        fontSize: 32.0,
        fontFamily: _fontFamily,
      ),
      titleMedium: TextStyle(
        color: AppColors.white,
        fontWeight: FontWeight.w500,
        fontSize: 24.0,
        fontFamily: _fontFamily,
      ),
      titleSmall: TextStyle(
        color: AppColors.white,
        fontWeight: FontWeight.w600,
        fontSize: 16.0,
        fontFamily: _fontFamily,
      ),
      headlineLarge: TextStyle(
        color: AppColors.white,
        fontWeight: FontWeight.w500,
        fontSize: 16.0,
        fontFamily: _fontFamily,
      ),
      headlineSmall: TextStyle(
        color: AppColors.white,
        fontWeight: FontWeight.w500,
        fontSize: 14.0,
        fontFamily: _fontFamily,
      ),
      bodyLarge: TextStyle(
        color: AppColors.yellow,
        fontWeight: FontWeight.w500,
        fontSize: 20.0,
        fontFamily: _fontFamily,
      ),
      bodyMedium: TextStyle(
        color: AppColors.yellow,
        fontWeight: FontWeight.w500,
        fontSize: 16.0,
        fontFamily: _fontFamily,
      ),
      displayLarge: TextStyle(
        color: AppColors.black,
        fontWeight: FontWeight.w500,
        fontSize: 16.0,
        fontFamily: _fontFamily,
      ),
    ),
  );
}
