import 'package:flutter/material.dart';
import 'package:coallider/core/constants/app_colors.dart';
import 'package:coallider/core/constants/app_texts.dart';
import 'package:coallider/core/extensions/build_context_extension.dart';
import 'package:coallider/core/extensions/int_ext.dart';
import 'package:coallider/core/extensions/widget_extension.dart';
import 'package:coallider/data/enums/spiral_state.dart';
import 'package:coallider/features/components/app_value_displayer.dart';
import 'package:coallider/features/connection_details_screen/cubit.dart';
import 'package:provider/provider.dart';

class SpiralPowerCard extends StatelessWidget {
  const SpiralPowerCard({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ConnectionDetailsCubit>();
    final state = cubit.state;
    final textTheme = context.textTheme;
    return Container(
      margin: EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        color:
            context.isLightTheme ? AppColors.purpleLight : Colors.transparent,
        border: Border.all(
          color:
              context.isLightTheme
                  ? AppColors.purpleLight
                  : AppColors.grey45,
        ),
        borderRadius: BorderRadius.circular(24.0),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(AppTexts.spiralPower, style: textTheme.headlineSmall),
              AppValueDisplayer(
                value: state.deviceInfo.spiralPower.toStringWithPercentSign,
                inProgress: !state.deviceInfo.spiralState.isOk,
              ),
            ],
          ).paddingOnly(top: 16.0, left: 16.0, right: 16.0),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                state.spiralPowerMinMaxValues.min.toStringWithPercentSign,
                style: textTheme.bodyMedium!.copyWith(fontSize: 12.0),
              ),
              Text(
                state.spiralPowerMinMaxValues.max.toStringWithPercentSign,
                style: textTheme.bodyMedium!.copyWith(fontSize: 12.0),
              ),
            ],
          ).paddingOnly(top: 16.0, left: 16.0, right: 16.0, bottom: 12.0),
          Container(
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: context.theme.sliderTheme.inactiveTrackColor,
              borderRadius: BorderRadius.circular(100.0),
            ),
            child: Slider(
              value: state.targetSpiralPower.toDouble(),
              min: state.spiralPowerMinMaxValues.min.toDouble(),
              max: state.spiralPowerMinMaxValues.max.toDouble(),
              onChanged: cubit.onSpiralPowerChanged,
              allowedInteraction: SliderInteraction.tapAndSlide,
              label: state.targetSpiralPower.round().toString(),
              onChangeEnd: cubit.onSpiralPowerChangeEnd,
            ),
          ).paddingOnly(left: 14.0, right: 14, bottom: 16.0),
        ],
      ),
    );
  }
}
