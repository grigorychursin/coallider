import 'package:coallider/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:coallider/core/constants/app_images.dart';
import 'package:coallider/core/constants/app_texts.dart';
import 'package:coallider/core/extensions/build_context_extension.dart';
import 'package:coallider/core/extensions/widget_extension.dart';
import 'package:coallider/features/components/app_tap_animation_handler.dart';

class ConnectedDeviceCard extends StatelessWidget {
  final String deviceName;
  final bool isHiglighted;
  const ConnectedDeviceCard({
    super.key,
    required this.deviceName,
    required this.isHiglighted,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    final colorScheme = context.colorScheme;
    return AppTapAnimationHandler(
      onTap: () {},
      child: Container(
        width: double.maxFinite,
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color:
              isHiglighted
                  ? colorScheme.primary
                  : colorScheme.tertiaryContainer,
          borderRadius: BorderRadius.circular(24.0),
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppTexts.connectedDevice,
                  style: textTheme.headlineSmall,
                ).paddingOnly(bottom: 10),
                Row(
                  children: [
                    SvgPicture.asset(
                      AppImages.bluetooth,
                      height: 24.0,
                    ).paddingOnly(right: 8),
                    Text(deviceName, style: textTheme.bodyLarge).expanded(),
                  ],
                ),
              ],
            ).expanded(),
            if (isHiglighted)
              SvgPicture.asset(
                AppImages.check,
                height: 28,
                width: 28,
                color:
                    context.isLightTheme
                        ? AppColors.white
                        : AppColors.black,
              ),
          ],
        ),
      ),
    );
  }
}
