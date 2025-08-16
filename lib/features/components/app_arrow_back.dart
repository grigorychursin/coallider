import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coallider/core/extensions/build_context_extension.dart';
import 'package:coallider/core/services/navigation/app_navigator.dart';
import 'package:coallider/features/components/app_tap_animation_handler.dart';

class AppArrowBack extends StatelessWidget {
  const AppArrowBack({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return AppTapAnimationHandler(
      onTap: () => context.read<AppNavigator>().pop(),
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
