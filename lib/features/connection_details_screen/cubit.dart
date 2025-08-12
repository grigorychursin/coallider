import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coallider/core/services/logger/logger_service.dart';
import 'package:coallider/core/services/navigation/hooka_navigator.dart';
import 'package:coallider/data/ble_device_info.dart';
import 'package:coallider/data/enums/bottom_state.dart';
import 'package:coallider/data/enums/device_state.dart';
import 'package:coallider/data/enums/spiral_state.dart';
import 'package:coallider/data/min_max_values.dart';
import 'package:coallider/features/connection_details_screen/state.dart';
import 'package:coallider/features/hooka_ble/hooka_ble_cubit.dart';
import 'package:coallider/features/hooka_ble/hooka_ble_state.dart';

class ConnectionDetailsCubit extends Cubit<ConnectionDetailsState> {
  final HookaBleCubit _bleCubit;
  StreamSubscription<List<int>>? _manualChangesStreamSubscription;
  StreamSubscription<List<int>>? _automaticChangesStreamSubscription;
  Timer? _timer;
  int _elapsedSeconds = 0;

  ConnectionDetailsCubit({
    required final HookaBleCubit bleCubit,
    required HookaNavigator navigator,
  }) : _bleCubit = bleCubit,
       super(_buildInitialState(bleCubit.state));

  void initialize() async {
    try {
      final autoChangesStream = await _bleCubit.subscribeToAutomaticChanges();

      _automaticChangesStreamSubscription = autoChangesStream!.listen(
        _onAutomaticChangesData,
      );
      final manualChangesStream = await _bleCubit.subscribeToManualChanges();

      _manualChangesStreamSubscription = manualChangesStream!.listen(
        _onManualChangesData,
      );
    } catch (e) {
      await LoggerService.logInfo(
        'Error when initializing connection details cubit ${e.toString()}',
      );
    } finally {
      emit(state.copyWith(inProgress: true));
    }
  }

  void _onAutomaticChangesData(List<int> data) async {
    if (isClosed) {
      return;
    }
    emit(state.copyWith(inProgress: false));
    final encodedAnswer = String.fromCharCodes(data);

    final parsedBody = encodedAnswer.split(',');
    final isSynchronized = state.sliderState == SliderState.synchronized;
    emit(
      state.copyWith(
        deviceInfo: state.deviceInfo.copyWith(
          spiralState: SpiralState.fromInt(int.tryParse(parsedBody[4])!),
          bottomState: BottomState.fromInt(int.tryParse(parsedBody[2])!),
          bottomTemperatue: int.tryParse(parsedBody[1])!,
          spiralPower: int.tryParse(parsedBody[3])!,
        ),
        targetBottomTemperature:
            isSynchronized ? null : int.tryParse(parsedBody[1])!,
        targetSpiralPower: isSynchronized ? null : int.tryParse(parsedBody[1])!,
        isHookahOn: int.tryParse(parsedBody[0]) == 1,
        sliderState: !isSynchronized ? SliderState.synchronized : null,
      ),
    );
  }

  void _onManualChangesData(List<int> data) async {
    try {
      if (isClosed) {
        return;
      }
      final encodedAnswer = String.fromCharCodes(data);
      final deviceInfo = state.deviceInfo.copyWithUpdates(encodedAnswer);
      emit(
        state.copyWith(
          deviceInfo: deviceInfo,
          targetBottomTemperature: deviceInfo.bottomTemperatue,
          targetSpiralPower: deviceInfo.spiralPower,
        ),
      );
      LoggerService.logInfo('Received message: $encodedAnswer');
    } catch (e) {
      LoggerService.logInfo(
        'Received Error while decoding answer: ${e.toString}',
        extra: {'data': e.toString()},
      );
    }
  }

  void toogleSwitch(final bool isEasy) {
    emit(state.copyWith(showEasy: isEasy));
  }

  void onBottomTemperatureChangeEnd(double? value) async {
    await _bleCubit.sendCommand(state.buildCommand());
  }

  void onBottomTemperatureChange(double? value) {
    emit(state.copyWith(targetBottomTemperature: value?.floor()));
  }

  void onSpiralPowerChanged(double? value) {
    emit(state.copyWith(targetSpiralPower: value?.floor()));
  }

  void onSpiralPowerChangeEnd(double? value) {
    _bleCubit.sendCommand(state.buildCommand());
  }

  void onWaterFlowButtonTapUp() async {
    _timer!.cancel();
    _timer = null;
    final command = state.buildCommand(waterFlow: _elapsedSeconds >= 2 ? 0 : 1);
    _elapsedSeconds = 0;
    await _bleCubit.sendCommand(command);
  }

  void onWaterFlowButtonTapDown() async {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) async {
      _elapsedSeconds++;
      if (_elapsedSeconds == 2) {
        final command = state.buildCommand(waterFlow: 2);
        await _bleCubit.sendCommand(command);
      }
    });
  }

  void onConnectionButtonTap() async {
    emit(state.copyWith(isHookahOn: !state.isHookahOn));
    await _bleCubit.sendCommand(state.buildCommand());
  }

  @override
  Future<void> close() async {
    await _manualChangesStreamSubscription?.cancel();
    _manualChangesStreamSubscription = null;
    await _automaticChangesStreamSubscription?.cancel();
    _automaticChangesStreamSubscription = null;
    return super.close();
  }
}

ConnectionDetailsState _buildInitialState(final HookaBleState bleState) {
  final selectedDevice = bleState.devices.firstWhere(
    (device) => device.id == bleState.selectedDevice!.id,
  );
  return ConnectionDetailsState(
    inProgress: true,
    deviceName: selectedDevice.name,
    showEasy: true,
    deviceInfo: BleDeviceInfo(
      deviceState: DeviceState.standBy,
      bottomTemperatue: _bottomTemperatureMinMaxValues.min,
      bottomState: BottomState.underheated,
      spiralPower: _spiralPowerMinMaxValues.min,
      spiralState: SpiralState.underheated,
      timeSinceStart: 0,
      heatingTime: 0,
    ),
    isHookahOn: false,
    targetBottomTemperature: _bottomTemperatureMinMaxValues.min,
    targetSpiralPower: _spiralPowerMinMaxValues.min,
    spiralPowerMinMaxValues: _spiralPowerMinMaxValues,
    bottomTemperatureMinMaxValues: _bottomTemperatureMinMaxValues,
    sliderState: SliderState.notSynchronized,
  );
}

extension ConnectionDetailsStateCommandExtension on ConnectionDetailsState {
  String buildCommand({
    int? waterFlow,
    int? bottomTemperature,
    int? spiralPower,
  }) {
    final deviceState = isHookahOn ? 1 : 0;
    final waterFlowValue = waterFlow ?? 0;
    final command =
        'com:$deviceState,$targetBottomTemperature,$targetSpiralPower,${waterFlowValue}end';
    return command;
  }
}

const _spiralPowerMinMaxValues = MinMaxValues<int>(min: 60, max: 100);
const _bottomTemperatureMinMaxValues = MinMaxValues<int>(min: 200, max: 310);
