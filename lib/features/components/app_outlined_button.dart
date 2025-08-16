import 'package:coallider/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:coallider/core/extensions/build_context_extension.dart';
import 'package:coallider/features/components/app_tap_animation_handler.dart';

class AppOutlinedButton extends StatelessWidget {
  final VoidCallback onTap;
  final VoidCallback? onTapUp;
  final VoidCallback? onTapDown;
  final String text;
  const AppOutlinedButton({
    super.key,
    required this.onTap,
    this.onTapDown,
    this.onTapUp,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return AppTapAnimationHandler(
      onTap: onTap,
      onTapDown: onTapDown,
      onTapUp: onTapUp,
      child: Container(
        height: 49,
        width: double.maxFinite,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          border: Border.all(
            color:
                context.isLightTheme
                    ? AppColors.purpleF4
                    : AppColors.grey65,
          ),
        ),
        child: Center(child: Text(text, style: context.textTheme.bodyMedium)),
      ),
    );
  }
}
