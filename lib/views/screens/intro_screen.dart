import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:parking_people_flutter/views/components/common/common_scaffold.dart';

import 'package:flutter_hooks/flutter_hooks.dart';

part 'intro_screen.g.dart';

@hwidget
Widget introScreen() {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    FlutterNativeSplash.remove();
  });

  return Scaffold(
    appBar: AppBar(
      title: const Text('intro'),
    ),
    body: const Text('hello world'),
  );
}
