import 'package:flutter/material.dart';
import 'package:hookaapp/core/constants/hooka_colors.dart';
import 'package:hookaapp/core/extensions/build_context_extension.dart';
import 'package:hookaapp/features/components/hooka_tap_animation_handler.dart';

class HookaButton extends StatelessWidget {
  final VoidCallback onTap;
  final VoidCallback? onTapUp;
  final VoidCallback? onTapDown;
  final String text;
  final bool isActive;

  const HookaButton({
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

    return HookaTapAnimationHandler(
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
                      ? HookaColors.textPurple
                      : HookaColors.white,
            ),
          ),
        ),
      ),
    );
  }
}
