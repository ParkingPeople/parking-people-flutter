import 'package:flutter/material.dart';

final List<double> _strengths = List.generate(10, (i) => 0.1 * i)..add(0.05);

MaterialColor createMaterialColor(Color color) {
  final Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (final strength in _strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }

  return MaterialColor(color.value, swatch);
}

bool isDark(Color color) => color.computeLuminance() < .5;
