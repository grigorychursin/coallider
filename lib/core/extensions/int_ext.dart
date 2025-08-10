extension IntExt on int {
  String get toStringWithDegreeSign => '${toString()}\u00b0С';
  String get toStringWithPercentSign => '${toString()}%';
}
