import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:parking_people_flutter/views/components/common/empty.dart';

part 'conditional.g.dart';

@swidget
Widget conditional<T>(
  BuildContext context, {
  required T value,
  required bool Function(T) condition,
  required Widget Function(T) builder,
}) {
  if (condition(value)) {
    return builder(value);
  } else {
    return const Empty();
  }
}
