import 'package:flutter/material.dart';

extension RouteArguments on BuildContext {
  Map<String, dynamic> get routeArguments {
    final args = ModalRoute.of(this)?.settings.arguments;

    return args is Map<String, dynamic> ? args : {};
  }
}
