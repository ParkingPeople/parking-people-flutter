import 'package:flutter/material.dart';

extension EnumValueUtils on Axis {
  static const _opposites = {
    Axis.horizontal: Axis.vertical,
    Axis.vertical: Axis.horizontal
  };
  Axis get perpendicular => _opposites[this]!;
}
