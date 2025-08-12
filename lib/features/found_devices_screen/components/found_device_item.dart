import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:flutter_svg/svg.dart';
import 'package:coallider/core/constants/hooka_texts.dart';
import 'package:coallider/core/extensions/discovered_device_ext.dart';
import 'package:coallider/features/components/hooka_signal_indicator.dart';
import 'package:coallider/core/constants/hooka_colors.dart';
import 'package:coallider/core/constants/hooka_images.dart';
import 'package:coallider/core/extensions/build_context_extension.dart';
import 'package:coallider/core/extensions/widget_extension.dart';
import 'package:coallider/features/components/hooka_tap_animation_handler.dart';
import 'package:coallider/features/found_devices_screen/cubit.dart';
import 'package:provider/provider.dart';

class FoundDeviceItem extends StatelessWidget {
  final DiscoveredDevice device;
  final bool isSelected;
  const FoundDeviceItem({
    super.key,
    required this.device,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return HookaTapAnimationHandler(
      onTap: () => context.read<FoundDevicesCubit>().onConnect(device),
      child: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.0),
          color:
              context.isLightTheme
                  ? HookaColors.purpleLight
                  : HookaColors.grey3d,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isSelected)
              Text(
                HookaTexts.isConnected,
                style: context.textTheme.headlineSmall,
              ),
            Row(
              children: [
                SvgPicture.asset(HookaImages.bluetooth, height: 24.0),
                Text(
                  device.name,
                  style: context.textTheme.bodyLarge,
                ).paddingSymmetric(h: 8.0).expanded(),
                HookaSignalIndicator(
                  value: device.signalStrength,
                ).paddingOnly(right: 10.0),
                Container(
                  height: 40.0,
                  width: 40.0,
                  padding: EdgeInsets.symmetric(horizontal: 13.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: context.colorScheme.primary,
                  ),
                  child: SvgPicture.asset(
                    HookaImages.arrowRight,
                    color:
                        context.isLightTheme
                            ? HookaColors.white
                            : HookaColors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
