import 'package:coallider/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:coallider/core/constants/app_texts.dart';
import 'package:coallider/core/extensions/build_context_extension.dart';
import 'package:coallider/core/extensions/widget_extension.dart';
import 'package:coallider/features/components/app_tap_animation_handler.dart';
import 'package:coallider/features/connection_details_screen/cubit.dart';

class DetailsSwitch extends StatelessWidget {
  final bool isEasy;
  const DetailsSwitch({super.key, required this.isEasy});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ConnectionDetailsCubit>();
    final borderColor = context.colorScheme.tertiary;
    final fillColor =
        context.isLightTheme ? AppColors.purpleLight : Colors.transparent;
    return Container(
      height: 40.0,
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 2.0),
      decoration: BoxDecoration(
        color: fillColor,
        borderRadius: BorderRadius.circular(24.0),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        children: [
          _SwitchItem(
            isActive: isEasy,
            text: AppTexts.easy,
            onTap: () {
              cubit.toogleSwitch(true);
            },
          ).expanded(),
          _SwitchItem(
            isActive: !isEasy,
            text: AppTexts.full,
            onTap: () {
              cubit.toogleSwitch(false);
            },
          ).expanded(),
        ],
      ),
    );
  }
}

class _SwitchItem extends StatelessWidget {
  final bool isActive;
  final String text;
  final VoidCallback onTap;
  const _SwitchItem({
    required this.isActive,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final inactiveFillColor =
        context.isLightTheme ? AppColors.purpleLight : Colors.transparent;
    final activeTextColor =
        context.isLightTheme ? AppColors.white : Colors.black;
    final inactiveTextColor =
        context.isLightTheme ? AppColors.textPurple : AppColors.white;
    return AppTapAnimationHandler(
      onTap: onTap,
      child: Container(
        height: 34.0,
        decoration: BoxDecoration(
          color: isActive ? context.colorScheme.primary : inactiveFillColor,
          borderRadius: BorderRadius.circular(24.0),
        ),
        child: Center(
          child: Text(
            text,
            style: context.textTheme.displayLarge!.copyWith(
              color: isActive ? activeTextColor : inactiveTextColor,
            ),
          ),
        ),
      ),
    );
  }
}
