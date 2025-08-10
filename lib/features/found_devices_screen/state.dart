import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:hookaapp/features/components/progress_widget.dart';

final class FoundDevicesState implements ProgressState {
  @override
  final bool inProgress;
  final List<DiscoveredDevice> devices;

  FoundDevicesState({required this.devices, required this.inProgress});

  FoundDevicesState copyWith({
    List<DiscoveredDevice>? devices,
    bool? inProgress,
  }) {
    return FoundDevicesState(
      devices: devices ?? this.devices,
      inProgress: inProgress ?? this.inProgress,
    );
  }
}
