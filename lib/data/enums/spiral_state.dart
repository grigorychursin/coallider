enum SpiralState {
  underheated,
  ok,
  overheated;

  factory SpiralState.fromInt(int value) {
    switch (value) {
      case 1:
        return SpiralState.ok;
      case 2:
        return SpiralState.overheated;
      case 0:
      default:
        return SpiralState.underheated;
    }
  }
}

extension SpiralStateExt on SpiralState {
  bool get isOk => this == SpiralState.ok;
}
