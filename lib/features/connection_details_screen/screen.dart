import 'package:coallider/features/components/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coallider/core/constants/app_texts.dart';
import 'package:coallider/core/extensions/build_context_extension.dart';
import 'package:coallider/core/extensions/widget_extension.dart';
import 'package:coallider/features/components/app_appbar.dart';
import 'package:coallider/features/components/app_bottom_bar.dart';
import 'package:coallider/features/components/app_outlined_button.dart';
import 'package:coallider/features/components/max_size_sroll_view.dart';
import 'package:coallider/features/components/progress_widget.dart';
import 'package:coallider/features/connection_details_screen/components/bottom_temperature_card.dart';
import 'package:coallider/features/connection_details_screen/components/connected_device_card.dart';
import 'package:coallider/features/connection_details_screen/components/details_switch.dart';
import 'package:coallider/features/connection_details_screen/components/spiral_power_card.dart';
import 'package:coallider/features/connection_details_screen/components/system_status_card.dart';
import 'package:coallider/features/connection_details_screen/cubit.dart';
import 'package:coallider/features/connection_details_screen/state.dart';

class ConnectionDetailsScreen extends StatefulWidget {
  const ConnectionDetailsScreen({super.key});

  @override
  State<ConnectionDetailsScreen> createState() =>
      _ConnectionDetailsScreenState();
}

class _ConnectionDetailsScreenState extends State<ConnectionDetailsScreen> {
  late final ConnectionDetailsCubit _cubit;
  @override
  void initState() {
    super.initState();
    _cubit = ConnectionDetailsCubit(
      bleCubit: context.read(),
      navigator: context.read(),
    )..initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: thisAppBar(context: context, applyLeading: true),
      body: BlocProvider(
        create: (_) => _cubit,
        child: BlocBuilder<ConnectionDetailsCubit, ConnectionDetailsState>(
          builder:
              (context, state) => ProgressWidget<
                ConnectionDetailsCubit,
                ConnectionDetailsState
              >(
                bloc: _cubit,
                child: MaxSizeScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DetailsSwitch(isEasy: state.showEasy),
                      ConnectedDeviceCard(
                        deviceName: state.deviceName,
                        isHiglighted: false,
                      ).paddingOnly(top: 8, bottom: 16.0),
                      Text(
                        AppTexts.heatStatus,
                        style: context.textTheme.headlineLarge,
                      ).paddingOnly(left: 4, bottom: 16.0),
                      if (state.showEasy) SystemStatusCard(),
                      if (!state.showEasy) BottomTemperatureCard(),
                      if (!state.showEasy) SpiralPowerCard(),
                      AppOutlinedButton(
                        onTap: () {},
                        onTapDown: _cubit.onWaterFlowButtonTapDown,
                        onTapUp: _cubit.onWaterFlowButtonTapUp,
                        text: AppTexts.waterFlow,
                      ).paddingOnly(bottom: 8.0),
                      AppButton(
                        onTap: _cubit.onConnectionButtonTap,
                        text:
                            state.isOn
                                ? AppTexts.turnOff
                                : AppTexts.turnOn,
                        isActive: !state.isOn,
                      ),
                      const Spacer(),
                      const AppBottomBar(topMargin: 16.0),
                    ],
                  ).paddingAll(16.0),
                ),
              ),
        ),
      ),
    );
  }
}
