import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

final class HookaBleState {
  final List<DiscoveredDevice> devices;
  final Stream<ConnectionStateUpdate>? connectionStateStream;
  final DiscoveredDevice? selectedDevice;
  final List<Service> discoveredServices;

  HookaBleState({
    required this.devices,
    this.connectionStateStream,
    this.selectedDevice,
    this.discoveredServices = const [],
  });

  HookaBleState copyWith({
    List<DiscoveredDevice>? devices,
    Stream<ConnectionStateUpdate>? connectionStateStream,
    DiscoveredDevice? selectedDevice,
    List<Service>? discoveredServices,
  }) {
    return HookaBleState(
      devices: devices ?? this.devices,
      connectionStateStream:
          connectionStateStream ?? this.connectionStateStream,
      selectedDevice: selectedDevice ?? this.selectedDevice,
      discoveredServices: discoveredServices ?? this.discoveredServices,
    );
  }
}
