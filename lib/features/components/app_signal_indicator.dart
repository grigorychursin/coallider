import 'package:coallider/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:coallider/core/extensions/build_context_extension.dart';
import 'package:signal_strength_indicator/signal_strength_indicator.dart';

class AppSignalIndicator extends StatelessWidget {
  final int value;
  const AppSignalIndicator({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    final barColor =
        context.isLightTheme ? AppColors.black : AppColors.white;
    return SignalStrengthIndicator.bars(
      value: value,
      minValue: 0,
      maxValue: 4.0,
      barCount: 4,
      spacing: 0.3,
      radius: Radius.circular(1.0),
      inactiveColor: barColor.withAlpha(80),
      activeColor: barColor,
      size: 14.0,
    );
  }
}
