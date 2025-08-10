import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hookaapp/core/constants/hooka_colors.dart';
import 'package:hookaapp/core/constants/hooka_texts.dart';
import 'package:hookaapp/core/extensions/build_context_extension.dart';
import 'package:hookaapp/core/extensions/widget_extension.dart';
import 'package:hookaapp/features/components/hooka_tap_animation_handler.dart';
import 'package:hookaapp/features/connection_details_screen/cubit.dart';

class DetailsSwitch extends StatelessWidget {
  final bool isEasy;
  const DetailsSwitch({super.key, required this.isEasy});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ConnectionDetailsCubit>();
    final borderColor = context.colorScheme.tertiary;
    final fillColor =
        context.isLightTheme ? HookaColors.purpleLight : Colors.transparent;
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
            text: HookaTexts.easy,
            onTap: () {
              cubit.toogleSwitch(true);
            },
          ).expanded(),
          _SwitchItem(
            isActive: !isEasy,
            text: HookaTexts.full,
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
        context.isLightTheme ? HookaColors.purpleLight : Colors.transparent;
    final activeTextColor =
        context.isLightTheme ? HookaColors.white : Colors.black;
    final inactiveTextColor =
        context.isLightTheme ? HookaColors.textPurple : HookaColors.white;
    return HookaTapAnimationHandler(
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
