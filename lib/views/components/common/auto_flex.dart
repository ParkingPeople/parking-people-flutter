import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:parking_people_flutter/utils/extensions/enum_utils.dart';
import 'package:parking_people_flutter/views/components/common/conditional.dart';

part 'auto_flex.g.dart';

@swidget
Widget autoFlex(
  BuildContext context, {
  required List<Widget> children,
  bool perpendicular = false,
}) {
  final Element element = context as Element;
  final AbstractNode? parent = element.renderObject?.parent;
  return Conditional<AbstractNode?>(
    value: parent,
    condition: (parent) {
      return parent is RenderFlex;
    },
    builder: (parent) {
      final Axis parentDirection = (parent as RenderFlex).direction;
      return Flex(
        mainAxisSize: MainAxisSize.min,
        direction:
            perpendicular ? parentDirection.perpendicular : parentDirection,
        children: children,
      );
    },
  );
}
