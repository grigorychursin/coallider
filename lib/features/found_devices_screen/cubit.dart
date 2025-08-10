import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:hookaapp/core/services/logger/logger_service.dart';
import 'package:hookaapp/core/services/navigation/hooka_navigator.dart';
import 'package:hookaapp/core/services/navigation/hooka_routes.dart';
import 'package:hookaapp/features/found_devices_screen/state.dart';
import 'package:hookaapp/features/hooka_ble/hooka_ble_cubit.dart';

final class FoundDevicesCubit extends Cubit<FoundDevicesState> {
  final HookaBleCubit _bleCubit;
  final HookaNavigator _navigator;
  FoundDevicesCubit({
    required HookaBleCubit bleCubit,
    required HookaNavigator navigator,
  }) : _bleCubit = bleCubit,
       _navigator = navigator,
       super(FoundDevicesState(devices: const [], inProgress: false));

  void onDevicesListChanged() {
    emit(state.copyWith(devices: _bleCubit.state.devices));
  }

  void onConnect(final DiscoveredDevice device) async {
    if (_bleCubit.state.selectedDevice != null) {
      _navigateToConnectionDetailsScreen();
      return;
    }
    try {
      emit(state.copyWith(inProgress: true));
      _bleCubit.connect(
        device: device,
        onConnectionHappen: _navigateToConnectionDetailsScreen,
        onConnectionCanceled: _onConnectionCanceled,
      );
    } catch (e) {
      await LoggerService.logInfo('Error while connecting ${e.toString()}');
    }
  }

  void _navigateToConnectionDetailsScreen() async {
    emit(state.copyWith(inProgress: false));
    await _navigator.pushNamed(HookaRoutes.connectionDetails);
  }

  void _onConnectionCanceled() {
    _navigator.popUntil((r) => r.isFirst);
  }

  void onRetry() async {
    try {
      emit(state.copyWith(inProgress: true));
      await _bleCubit.stopScan();
      await _bleCubit.findDevices();
      emit(state.copyWith(inProgress: false));
    } catch (e) {
      await LoggerService.logInfo('Error while retrying ${e.toString()}');
    }
  }
}
