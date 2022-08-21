import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:naver_map_plugin/naver_map_plugin.dart';
import 'package:parking_people_flutter/utils/globals.dart';
import 'package:parking_people_flutter/views/components/common_scaffold.dart';

import '/utils/extensions/material_utils.dart';

part 'parking_lot_selection_screen.g.dart';

@swidget
Widget parkingLotSelectionScreen(BuildContext context) {
  final args = context.routeArguments;
  final String address = args['address'];
  final Location location = args['location'];

  defaultLogger.d(args);

  return CommonScaffold(
    title: '목적지',
    children: [
      Text(
        address,
        style: const TextStyle(
          fontSize: 15,
        ),
      ),
      NaverMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(location.latitude, location.longitude),
        ),
        nightModeEnable: true,
      ),
    ],
  );
}
