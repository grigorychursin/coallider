import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

extension DiscoveredDeviceExt on DiscoveredDevice {
  int get signalStrength {
    if (rssi >= -50) {
      return 4;
    } else if (rssi >= -65) {
      return 3;
    } else if (rssi >= -80) {
      return 2;
    } else if (rssi >= -90) {
      return 1;
    } else {
      return 0;
    }
  }
}
