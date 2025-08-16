import 'package:coallider/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:coallider/core/extensions/build_context_extension.dart';
import 'package:coallider/features/components/app_tap_animation_handler.dart';

class AppButton extends StatelessWidget {
  final VoidCallback onTap;
  final VoidCallback? onTapUp;
  final VoidCallback? onTapDown;
  final String text;
  final bool isActive;

  const AppButton({
    super.key,
    required this.onTap,
    this.onTapUp,
    this.onTapDown,
    required this.text,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return AppTapAnimationHandler(
      onTap: onTap,
      onTapUp: onTapUp,
      onTapDown: onTapDown,
      child: Container(
        height: 49,
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        width: double.maxFinite,
        decoration: BoxDecoration(
          color:
              isActive
                  ? colorScheme.primaryContainer
                  : colorScheme.secondaryContainer,
          borderRadius: BorderRadius.circular(100.0),
        ),
        child: Center(
          child: Text(
            text,
            style: Theme.of(context).textTheme.displayLarge!.copyWith(
              color:
                  isActive
                      ? null
                      : context.isLightTheme
                      ? AppColors.textPurple
                      : AppColors.white,
            ),
          ),
        ),
      ),
    );
  }
}
