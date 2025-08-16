import 'package:coallider/features/components/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coallider/core/constants/app_texts.dart';
import 'package:coallider/core/extensions/build_context_extension.dart';
import 'package:coallider/core/extensions/widget_extension.dart';
import 'package:coallider/features/components/app_appbar.dart';
import 'package:coallider/features/components/app_bottom_bar.dart';
import 'package:coallider/features/components/progress_widget.dart';
import 'package:coallider/features/found_devices_screen/components/found_device_item.dart';
import 'package:coallider/features/found_devices_screen/cubit.dart';
import 'package:coallider/features/found_devices_screen/state.dart';
import 'package:coallider/features/ble/app_ble_cubit.dart';
import 'package:coallider/features/ble/app_ble_state.dart';

class FoundDevicesScreen extends StatefulWidget {
  const FoundDevicesScreen({super.key});

  @override
  State<FoundDevicesScreen> createState() => _FoundDevicesScreenState();
}

class _FoundDevicesScreenState extends State<FoundDevicesScreen> {
  late final FoundDevicesCubit _cubit;
  @override
  void initState() {
    _cubit = FoundDevicesCubit(
      bleCubit: context.read(),
      navigator: context.navigator,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bleCubit = context.read<AppBleCubit>();
    return ProgressWidget<FoundDevicesCubit, FoundDevicesState>(
      bloc: _cubit,
      child: BlocListener<AppBleCubit, AppBleState>(
        listener: (_, __) {
          _cubit.onDevicesListChanged();
        },
        child: BlocProvider.value(
          value: _cubit,
          child: BlocBuilder<FoundDevicesCubit, FoundDevicesState>(
            bloc: _cubit,
            builder: (context, state) {
              return Scaffold(
                appBar: thisAppBar(
                  context: context,
                  applyLeading: true,
                  applyTitle: false,
                ),
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppTexts.foundDevices,
                      style: context.textTheme.titleMedium,
                    ),
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        itemCount: state.devices.length,
                        itemBuilder:
                            (context, i) => FoundDeviceItem(
                              device: state.devices[i],
                              isSelected:
                                  state.devices[i].id ==
                                  bleCubit.state.selectedDevice?.id,
                            ).paddingOnly(bottom: 8.0),
                      ),
                    ),

                    AppButton(
                      onTap: _cubit.onRetry,
                      text: AppTexts.tryAgain,
                      isActive: true,
                    ).paddingOnly(top: 16.0, bottom: 20.0),
                    const AppBottomBar(topMargin: 20.0),
                    SizedBox(height: 16.0),
                  ],
                ).paddingSymmetric(h: 16.0),
              );
            },
          ),
        ),
      ),
    );
  }
}
