import 'package:flutter/material.dart';

final List<double> _strengths = List.generate(10, (i) => 0.1 * i)..add(0.05);

MaterialColor createMaterialColor(Color color) {
  final Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  int map(int v, double ds) => v + ((ds < 0 ? v : (255 - v)) * ds).round();

  for (final strength in _strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      map(r, ds),
      map(g, ds),
      map(b, ds),
      1,
    );
  }

  return MaterialColor(color.value, swatch);
}

bool isDark(Color color) => color.computeLuminance() < .5;
