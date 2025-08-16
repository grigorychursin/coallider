import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:coallider/core/services/logger/logger_service.dart';
import 'package:coallider/core/services/navigation/app_navigator.dart';
import 'package:coallider/core/services/navigation/app_routes.dart';
import 'package:coallider/features/found_devices_screen/state.dart';
import 'package:coallider/features/ble/app_ble_cubit.dart';

final class FoundDevicesCubit extends Cubit<FoundDevicesState> {
  final AppBleCubit _bleCubit;
  final AppNavigator _navigator;
  FoundDevicesCubit({
    required AppBleCubit bleCubit,
    required AppNavigator navigator,
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
    await _navigator.pushNamed(AppRoutes.connectionDetails);
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
