import 'package:flutter/material.dart';
import 'package:hookaapp/core/constants/hooka_colors.dart';
import 'package:hookaapp/core/extensions/build_context_extension.dart';
import 'package:hookaapp/features/components/hooka_tap_animation_handler.dart';

class HookaOutlinedButton extends StatelessWidget {
  final VoidCallback onTap;
  final VoidCallback? onTapUp;
  final VoidCallback? onTapDown;
  final String text;
  const HookaOutlinedButton({
    super.key,
    required this.onTap,
    this.onTapDown,
    this.onTapUp,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return HookaTapAnimationHandler(
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
                    ? HookaColors.purpleF4
                    : HookaColors.grey65,
          ),
        ),
        child: Center(child: Text(text, style: context.textTheme.bodyMedium)),
      ),
    );
  }
}
