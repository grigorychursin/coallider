import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hookaapp/core/constants/hooka_colors.dart';
import 'package:hookaapp/core/constants/hooka_texts.dart';
import 'package:hookaapp/core/extensions/build_context_extension.dart';
import 'package:hookaapp/core/extensions/widget_extension.dart';
import 'package:hookaapp/data/enums/device_state.dart';
import 'package:hookaapp/features/connection_details_screen/cubit.dart';

class SystemStatusCard extends StatelessWidget {
  const SystemStatusCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isLightTheme = context.isLightTheme;
    final state = context.read<ConnectionDetailsCubit>().state;
    final deviceState = state.deviceInfo.deviceState;
    return Container(
      margin: EdgeInsets.only(bottom: 29.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.0),
        color: isLightTheme ? HookaColors.purpleLight : Colors.transparent,
        border: isLightTheme ? null : Border.all(color: HookaColors.grey45),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            HookaTexts.systemStatus,
            style: context.textTheme.headlineLarge!.copyWith(fontSize: 14.0),
          ),
          _StatusWidget(
            progress: 5,
            status: deviceState.getStringInterpretation(),
          ),
        ],
      ),
    );
  }
}

class _StatusWidget extends StatelessWidget {
  final String status;
  final double progress;
  const _StatusWidget({required this.status, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.5),
      decoration: BoxDecoration(
        color: context.isLightTheme ? null : HookaColors.white.withAlpha(20),
        borderRadius: BorderRadius.circular(100.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            status,
            style: context.textTheme.bodyMedium!.copyWith(fontSize: 12.0),
          ).paddingOnly(right: 4.0, left: 3.5),
          SizedBox(
            width: 17.0,
            height: 17.0,
            child: CircularProgressIndicator(),
          ),
        ],
      ),
    );
  }
}

extension on DeviceState {
  String getStringInterpretation() {
    switch (this) {
      case DeviceState.heating:
        return HookaTexts.heating;
      case DeviceState.standBy:
        return HookaTexts.standBy;
    }
  }
}
