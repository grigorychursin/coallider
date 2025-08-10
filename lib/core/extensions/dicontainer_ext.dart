import 'package:di/di.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:hookaapp/core/services/permission/permission_service.dart';
import 'package:hookaapp/core/services/storage/permission_error_count_storage.dart';
import 'package:hookaapp/core/services/storage/privacy_and_terms_storage.dart';

extension DicontainerExt on DiContainer {
  Future<DiContainer> initApp() async {
    await _registerStorages(this);
    _registerPermissionService(this);
    _registerBle(this);
    return this;
  }
}

void _registerBle(DiContainer container) {
  container.registerSingleton<FlutterReactiveBle>(FlutterReactiveBle());
}

void _registerPermissionService(DiContainer container) {
  container.registerSingleton<PermissionService>(
    PermissionService(permissionErrorCountStorage: container.resolve()),
  );
}

Future<void> _registerStorages(DiContainer container) async {
  final privacyAndTermsStorage = PrivacyAndTermsStorage();
  await privacyAndTermsStorage.init();
  container.registerSingleton<PrivacyAndTermsStorage>(privacyAndTermsStorage);
  final permissionErrorCountStorage = PermissionErrorCountStorage();
  await permissionErrorCountStorage.init();
  container.registerSingleton<PermissionErrorCountStorage>(
    permissionErrorCountStorage,
  );
}
