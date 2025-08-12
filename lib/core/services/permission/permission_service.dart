import 'dart:io';
import 'package:coallider/core/services/storage/permission_error_count_storage.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  final PermissionErrorCountStorage _permissionErrorCountStorage;

  const PermissionService({
    required PermissionErrorCountStorage permissionErrorCountStorage,
  }) : _permissionErrorCountStorage = permissionErrorCountStorage;

  Future<bool> requestBlePermissions() async {
    final bluetoothGranted = await _requestBluetoothPermissions();
    final locationGranted =
        Platform.isIOS ? true : await _requestLocationPermissions();

    final isAllGranted = bluetoothGranted && locationGranted;

    if (!isAllGranted) {
      await _handlePermissionError();
    }

    return isAllGranted;
  }

  Future<bool> _requestBluetoothPermissions() async {
    if (Platform.isIOS) {
      return true;
    }

    if (await Permission.bluetoothScan.isGranted &&
        await Permission.bluetoothConnect.isGranted) {
      return true;
    }

    final statuses =
        await [
          Permission.bluetoothScan,
          Permission.bluetoothConnect,
          Permission.bluetoothAdvertise,
        ].request();

    return statuses.values.every((status) => status.isGranted);
  }

  Future<bool> _requestLocationPermissions() async {
    if (await Permission.locationWhenInUse.isGranted) {
      return true;
    }

    final status = await Permission.locationWhenInUse.request();
    return status.isGranted;
  }

  Future<void> _handlePermissionError() async {
    final count = _permissionErrorCountStorage.getErrorsCount();
    final newCount = count + 1;

    await _permissionErrorCountStorage.setCount(newCount);

    if (newCount >= 2) {
      await openAppSettings();
    }
  }
}
