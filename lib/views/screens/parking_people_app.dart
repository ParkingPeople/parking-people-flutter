import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

part 'parking_people_app.g.dart';

@hwidget
Widget parkingPeopleApp() => MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('ParkingPeople'),
        ),
        body: const SafeArea(
          child: Center(
            child: Text('Hello ParkingPeople'),
          ),
        ),
      ),
    );
