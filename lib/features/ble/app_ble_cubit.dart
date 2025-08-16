import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:coallider/core/services/logger/logger_service.dart';
import 'package:coallider/core/services/permission/permission_service.dart';
import 'package:coallider/data/ble_exceptions.dart';
import 'package:coallider/features/ble/app_ble_state.dart';

const _servicesIds = <Uuid>[];

final class AppBleCubit extends Cubit<AppBleState> {
  StreamSubscription<DiscoveredDevice>? _scanSubscription;
  final FlutterReactiveBle _ble;
  final PermissionService _permissionService;

  AppBleCubit({
    required final FlutterReactiveBle ble,
    required PermissionService permissionService,
  }) : _ble = ble,
       _permissionService = permissionService,
       super(AppBleState(devices: const []));

  Future<void> findDevices() async {
    try {
      await _handlePermissions();
    } catch (e) {
      LoggerService.logInfo(
        'error while handling permission in findDevices function ${e.toString()}',
      );
    }
    try {
      final seenDeviceIds = <String>{};
      _scanSubscription = _ble
          .scanForDevices(
            withServices: _servicesIds,
            requireLocationServicesEnabled: Platform.isAndroid,
          )
          .listen((device) {
            if (device.name.isNotEmpty && !seenDeviceIds.contains(device.id)) {
              final updatedDevices = List<DiscoveredDevice>.from(state.devices)
                ..add(device);
              seenDeviceIds.add(device.id);
              emit(state.copyWith(devices: updatedDevices));
              _addSelectedDeviceIfExists();
            }
          });
    } catch (e) {
      LoggerService.logInfo('Error while finding devices ${e.toString()}');
    }
  }

  void _addSelectedDeviceIfExists() {
    final currentDevices = List<DiscoveredDevice>.from(state.devices);
    if (state.selectedDevice != null &&
        currentDevices.where((e) => e.id == state.selectedDevice?.id).isEmpty) {
      currentDevices.add(state.selectedDevice!);
      emit(state.copyWith(devices: currentDevices));
    }
  }

  void connect({
    required final DiscoveredDevice device,
    required final VoidCallback onConnectionHappen,
    required final VoidCallback onConnectionCanceled,
  }) {
    if (state.selectedDevice == null) {
      final connectionStateStream = _ble.connectToDevice(id: device.id);
      emit(
        state.copyWith(
          connectionStateStream: connectionStateStream,
          selectedDevice: device,
        ),
      );
      _handleDisconnection(
        onConnectionHappen: onConnectionHappen,
        onConnectionCanceled: onConnectionCanceled,
      );
    }
  }

  Future<void> getDiscoveredServices() async {
    try {
      final discoveredServices = await _ble.getDiscoveredServices(
        state.selectedDevice!.id,
      );
      emit(state.copyWith(discoveredServices: discoveredServices));
    } catch (e) {
      LoggerService.logInfo('Error while discovering services ${e.toString()}');
    }
  }

  Future<Stream<List<int>>?> subscribeToManualChanges() async {
    try {
      final discoveredServices = List<Service>.from(state.discoveredServices);
      final notifyCharacteristic = discoveredServices
          .expand((service) => service.characteristics)
          .lastWhere((c) => c.isNotifiable);

      final characteristic = QualifiedCharacteristic(
        characteristicId: notifyCharacteristic.id,
        serviceId: notifyCharacteristic.service.id,
        deviceId: state.selectedDevice!.id,
      );

      return _ble.subscribeToCharacteristic(characteristic);
    } catch (e) {
      await LoggerService.logInfo(
        'Failed to listen to device messages: ${e.toString()}',
        extra: {'data': e.toString()},
      );

      return null;
    }
  }

  Future<Stream<List<int>>?> subscribeToAutomaticChanges() async {
    try {
      final discoveredServices = List<Service>.from(state.discoveredServices);
      final notifyCharacteristic = discoveredServices
          .expand((service) => service.characteristics)
          .firstWhere((c) => c.isNotifiable);

      await LoggerService.logInfo(
        'Subscribing to characteristic',
        extra: {
          'characteristicId': notifyCharacteristic.id.toString(),
          'serviceId': notifyCharacteristic.service.id.toString(),
        },
      );

      final characteristic = QualifiedCharacteristic(
        characteristicId: notifyCharacteristic.id,
        serviceId: notifyCharacteristic.service.id,
        deviceId: state.selectedDevice!.id,
      );

      return _ble.subscribeToCharacteristic(characteristic);
    } catch (e) {
      await LoggerService.logInfo(
        'Failed to listen to device messages: ${e.toString()}',
        extra: {'data': e.toString()},
      );

      return null;
    }
  }

  void _handleDisconnection({
    required final VoidCallback onConnectionHappen,
    required final VoidCallback onConnectionCanceled,
  }) {
    state.connectionStateStream?.listen((update) async {
      if (update.connectionState == DeviceConnectionState.connected) {
        await getDiscoveredServices();
        onConnectionHappen();
      } else if ([
        DeviceConnectionState.disconnected,
        DeviceConnectionState.disconnecting,
      ].contains(update.connectionState)) {
        emit(AppBleState(devices: state.devices));
        onConnectionCanceled();
      }
    });
  }

  Future<void> sendCommand(final String command) async {
    try {
      final discoveredServices = List<Service>.from(state.discoveredServices);

      QualifiedCharacteristic? characteristic;
      bool useWithResponse = false;

      // Prioritize characteristics that support withResponse
      for (final service in discoveredServices) {
        for (final c in service.characteristics) {
          if (c.isWritableWithResponse) {
            characteristic = QualifiedCharacteristic(
              characteristicId: c.id,
              serviceId: service.id,
              deviceId: state.selectedDevice!.id,
            );
            useWithResponse = true;
            break;
          } else if (c.isWritableWithoutResponse && characteristic == null) {
            characteristic = QualifiedCharacteristic(
              characteristicId: c.id,
              serviceId: service.id,
              deviceId: state.selectedDevice!.id,
            );
            useWithResponse = false;
          }
        }
        if (characteristic != null) break;
      }

      if (characteristic == null) {
        LoggerService.logInfo('No writable characteristic found.');
        return;
      }

      if (useWithResponse) {
        await _ble.writeCharacteristicWithResponse(
          characteristic,
          value: utf8.encode(command),
        );
      } else {
        await _ble.writeCharacteristicWithoutResponse(
          characteristic,
          value: utf8.encode(command),
        );
      }
    } catch (e) {
      LoggerService.logInfo('Error while sending command: ${e.toString()}');
    }
  }

  Future<void> _handlePermissions() async {
    final isPermissionGranted =
        await _permissionService.requestBlePermissions();
    if (!isPermissionGranted) {
      throw BlePermissionException();
    }
  }

  Future<void> stopScan() async {
    emit(state.copyWith(devices: const []));
    await _scanSubscription?.cancel();
    _scanSubscription = null;
  }
}
