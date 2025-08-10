import 'package:flutter/material.dart';

extension WidgetExtension on Widget {
  Widget padding([EdgeInsetsGeometry value = const EdgeInsets.all(16)]) {
    return Padding(padding: value, child: this);
  }

  Padding paddingAll(double value) {
    return Padding(padding: EdgeInsets.all(value), child: this);
  }

  Padding paddingSymmetric({double v = 0, double h = 0}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: v, horizontal: h),
      child: this,
    );
  }

  Padding paddingOnly({
    double left = 0,
    double right = 0,
    double top = 0,
    double bottom = 0,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        left: left,
        right: right,
        top: top,
        bottom: bottom,
      ),
      child: this,
    );
  }

  Padding paddingLTRB(double left, double top, double right, double bottom) {
    return Padding(
      padding: EdgeInsets.fromLTRB(left, top, right, bottom),
      child: this,
    );
  }

  Align align(AlignmentGeometry alignment) {
    return Align(alignment: alignment, child: this);
  }

  Align alignAtStart() {
    return Align(alignment: Alignment.centerLeft, child: this);
  }

  Widget positioned({
    double? left,
    double? top,
    double? right,
    double? bottom,
  }) {
    return Positioned(
      left: left,
      top: top,
      right: right,
      bottom: bottom,
      child: this,
    );
  }

  Widget positionedAll(double value) {
    return Positioned(
      left: value,
      top: value,
      right: value,
      bottom: value,
      child: this,
    );
  }

  Widget positionedAtBottom({double? left, double? right}) {
    return Positioned(left: left, right: right, bottom: 0, child: this);
  }

  Widget expanded({int flex = 1}) {
    return Expanded(flex: flex, child: this);
  }
}
