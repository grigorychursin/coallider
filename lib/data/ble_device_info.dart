import 'package:coallider/data/enums/bottom_state.dart';
import 'package:coallider/data/enums/device_state.dart';
import 'package:coallider/data/enums/spiral_state.dart';

class BleDeviceInfo {
  final DeviceState deviceState;

  final int bottomTemperatue;

  final BottomState bottomState;

  final int spiralPower;

  final SpiralState spiralState;

  final int timeSinceStart;

  final int heatingTime;

  const BleDeviceInfo({
    required this.deviceState,
    required this.bottomTemperatue,
    required this.bottomState,
    required this.spiralPower,
    required this.spiralState,
    required this.timeSinceStart,
    required this.heatingTime,
  });

  BleDeviceInfo copyWith({
    DeviceState? deviceState,
    int? bottomTemperatue,
    BottomState? bottomState,
    int? spiralPower,
    SpiralState? spiralState,
    int? timeSinceStart,
    int? heatingTime,
  }) {
    return BleDeviceInfo(
      deviceState: deviceState ?? this.deviceState,
      bottomTemperatue: bottomTemperatue ?? this.bottomTemperatue,
      bottomState: bottomState ?? this.bottomState,
      spiralPower: spiralPower ?? this.spiralPower,
      spiralState: spiralState ?? this.spiralState,
      timeSinceStart: timeSinceStart ?? this.timeSinceStart,
      heatingTime: heatingTime ?? this.heatingTime,
    );
  }

  BleDeviceInfo copyWithUpdates(String data) {
    data = data.replaceAll('end', '');
    data = data.replaceAll('com:', '');
    final parts = data.split(',').map((e) => int.tryParse(e.trim())).toList();

    return BleDeviceInfo(
      deviceState: DeviceState.fromInt(parts[0]!),
      bottomTemperatue: parts[1]!,
      bottomState: bottomState,
      spiralPower: parts[2]!,
      spiralState: spiralState,
      timeSinceStart: timeSinceStart,
      heatingTime: heatingTime,
    );
  }
}
