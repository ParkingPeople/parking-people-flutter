import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:parking_people_flutter/views/components/common_scaffold.dart';

import '/utils/extensions/material_utils.dart';

part 'parking_lot_selection_screen.g.dart';

@swidget
Widget parkingLotSelectionScreen(BuildContext context) {
  final address = context.routeArguments['address']!;

  return CommonScaffold(
    title: '목적지',
    children: [
      Text(
        address,
        style: const TextStyle(
          fontSize: 15,
        ),
      ),
    ],
  );
}
