import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:parking_people_flutter/views/components/common/empty.dart';
import 'package:parking_people_flutter/views/routes/routes.dart';

part 'initial_route.g.dart';

@hwidget
Widget initialRouteWidget(BuildContext context) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    Navigator.of(context).pushReplacementNamed(Routes.intro);
  });

  return Scaffold(
    appBar: AppBar(
      title: const Text('ParkingPeopleApp'),
    ),
    body: const Center(
      child: Text('Hello world'),
    ),
  );
}
