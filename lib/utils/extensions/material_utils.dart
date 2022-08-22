import 'package:flutter/material.dart';

extension RouteArguments on BuildContext {
  Map<String, dynamic> get routeArguments =>
      ModalRoute.of(this)?.settings.arguments as Map<String, dynamic>? ?? {};
}
