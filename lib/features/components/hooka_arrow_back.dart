import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hookaapp/core/extensions/build_context_extension.dart';
import 'package:hookaapp/core/services/navigation/hooka_navigator.dart';
import 'package:hookaapp/features/components/hooka_tap_animation_handler.dart';

class HookaArrowBack extends StatelessWidget {
  const HookaArrowBack({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return HookaTapAnimationHandler(
      onTap: () => context.read<HookaNavigator>().pop(),
      child: Container(
        height: 40.0,
        width: 40.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: colorScheme.tertiary,
        ),
        child: Icon(
          Icons.arrow_back_ios_new,
          color: context.theme.iconTheme.color,
          size: 15,
        ),
      ),
    );
  }
}
