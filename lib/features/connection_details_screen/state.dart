import 'package:coallider/data/ble_device_info.dart';
import 'package:coallider/data/min_max_values.dart';
import 'package:coallider/features/components/progress_widget.dart';

final class ConnectionDetailsState extends ProgressState {
  @override
  final bool inProgress;
  final String deviceName;
  final bool showEasy;
  final BleDeviceInfo deviceInfo;
  final bool isOn;
  final int targetBottomTemperature;
  final int targetSpiralPower;
  final MinMaxValues<int> spiralPowerMinMaxValues;
  final MinMaxValues<int> bottomTemperatureMinMaxValues;
  final SliderState sliderState;

  ConnectionDetailsState({
    required this.inProgress,
    required this.deviceName,
    required this.showEasy,
    required this.deviceInfo,
    required this.isOn,
    required this.targetBottomTemperature,
    required this.targetSpiralPower,
    required this.spiralPowerMinMaxValues,
    required this.bottomTemperatureMinMaxValues,
    required this.sliderState,
  });

  ConnectionDetailsState copyWith({
    bool? inProgress,
    String? deviceName,
    bool? showEasy,
    BleDeviceInfo? deviceInfo,
    bool? isOn,
    int? targetBottomTemperature,
    int? targetSpiralPower,
    SliderState? sliderState,
  }) {
    return ConnectionDetailsState(
      inProgress: inProgress ?? this.inProgress,
      deviceName: deviceName ?? this.deviceName,
      showEasy: showEasy ?? this.showEasy,
      deviceInfo: deviceInfo ?? this.deviceInfo,
      isOn: isOn ?? this.isOn,
      targetBottomTemperature:
          targetBottomTemperature ?? this.targetBottomTemperature,
      targetSpiralPower: targetSpiralPower ?? this.targetSpiralPower,
      spiralPowerMinMaxValues: spiralPowerMinMaxValues,
      bottomTemperatureMinMaxValues: bottomTemperatureMinMaxValues,
      sliderState: sliderState ?? this.sliderState,
    );
  }
}

enum SliderState { synchronized, notSynchronized }
