import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hookaapp/core/constants/hooka_colors.dart';
import 'package:hookaapp/core/constants/hooka_images.dart';
import 'package:hookaapp/core/extensions/build_context_extension.dart';
import 'package:hookaapp/core/services/navigation/hooka_navigator.dart';
import 'package:hookaapp/features/components/hooka_tap_animation_handler.dart';

class HookaBottomBar extends StatelessWidget {
  final double topMargin;
  const HookaBottomBar({super.key, required this.topMargin});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: HookaTapAnimationHandler(
        onTap:
            () => context.read<HookaNavigator>().popUntil(
              (route) => route.isFirst,
            ),
        child: Container(
          width: 103.0,
          height: 48.0,
          margin: EdgeInsets.only(top: topMargin),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24.0),
            color:
                context.isLightTheme
                    ? HookaColors.purpleLight
                    : HookaColors.black18,
          ),
          child: Center(
            child: SvgPicture.asset(
              HookaImages.home,
              height: 16.67,
              color: context.theme.iconTheme.color,
            ),
          ),
        ),
      ),
    );
  }
}
