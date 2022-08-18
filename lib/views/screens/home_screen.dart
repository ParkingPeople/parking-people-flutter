import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';

import 'package:flutter_hooks/flutter_hooks.dart';

part 'home_screen.g.dart';

@hwidget
Widget homeScreen(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Home'),
    ),
    body: const Center(child: Text('homeScreen')),
  );
}
