import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

final class AppBleState {
  final List<DiscoveredDevice> devices;
  final Stream<ConnectionStateUpdate>? connectionStateStream;
  final DiscoveredDevice? selectedDevice;
  final List<Service> discoveredServices;

  AppBleState({
    required this.devices,
    this.connectionStateStream,
    this.selectedDevice,
    this.discoveredServices = const [],
  });

  AppBleState copyWith({
    List<DiscoveredDevice>? devices,
    Stream<ConnectionStateUpdate>? connectionStateStream,
    DiscoveredDevice? selectedDevice,
    List<Service>? discoveredServices,
  }) {
    return AppBleState(
      devices: devices ?? this.devices,
      connectionStateStream:
          connectionStateStream ?? this.connectionStateStream,
      selectedDevice: selectedDevice ?? this.selectedDevice,
      discoveredServices: discoveredServices ?? this.discoveredServices,
    );
  }
}
