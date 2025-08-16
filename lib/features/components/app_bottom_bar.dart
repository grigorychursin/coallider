import 'package:coallider/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:coallider/core/constants/app_images.dart';
import 'package:coallider/core/extensions/build_context_extension.dart';
import 'package:coallider/core/services/navigation/app_navigator.dart';
import 'package:coallider/features/components/app_tap_animation_handler.dart';

class AppBottomBar extends StatelessWidget {
  final double topMargin;
  const AppBottomBar({super.key, required this.topMargin});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AppTapAnimationHandler(
        onTap:
            () => context.read<AppNavigator>().popUntil(
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
                    ? AppColors.purpleLight
                    : AppColors.black18,
          ),
          child: Center(
            child: SvgPicture.asset(
              AppImages.home,
              height: 16.67,
              color: context.theme.iconTheme.color,
            ),
          ),
        ),
      ),
    );
  }
}
