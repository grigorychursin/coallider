enum DeviceState {
  heating,
  standBy;

  factory DeviceState.fromInt(int value) {
    switch (value) {
      case 1:
        return DeviceState.heating;
      case 0:
      default:
        return DeviceState.standBy;
    }
  }
}