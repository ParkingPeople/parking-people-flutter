import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';

part 'common_text_style_scope.g.dart';

@swidget
Widget commonTextStyleScope(
  BuildContext context, {
  required TextStyle style,
  required Widget child,
}) {
  return DefaultTextStyle(
    style: (Theme.of(context).textTheme.bodyText2 ?? const TextStyle())
        .merge(style),
    child: child,
  );
}
