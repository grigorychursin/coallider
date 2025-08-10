enum BottomState {
  underheated,
  ok,
  overheated;

  factory BottomState.fromInt(int value) {
    switch (value) {
      case 1:
        return BottomState.ok;
      case 2:
        return BottomState.overheated;
      case 0:
      default:
        return BottomState.underheated;
    }
  }
}

extension BottomStateExt on BottomState {
  bool get isOk => this == BottomState.ok;
}
