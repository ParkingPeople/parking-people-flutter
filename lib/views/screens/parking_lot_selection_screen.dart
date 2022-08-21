import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_use/flutter_use.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:naver_map_plugin/naver_map_plugin.dart';
import 'package:parking_people_flutter/gen/assets.gen.dart';
import 'package:parking_people_flutter/utils/globals.dart';
import 'package:parking_people_flutter/views/components/common_scaffold.dart';

import '/utils/extensions/material_utils.dart';

import 'package:flutter_hooks/flutter_hooks.dart';

part 'parking_lot_selection_screen.g.dart';

@hwidget
Widget parkingLotSelectionScreen(BuildContext context) {
  final args = context.routeArguments;
  final String address = args['address'];
  final Location location = args['location'];

  ValueNotifier<OverlayImage?> targetPinIcon = useState<OverlayImage?>(null);
  ValueNotifier<OverlayImage?> parkingPinIcon = useState<OverlayImage?>(null);

  defaultLogger.d(args);

  const Color naverColor = Color.fromARGB(255, 100, 255, 130);

  useMount(() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      OverlayImage.fromAssetImage(
        assetName: Assets.images.location.path,
      ).then(
        (value) {
          targetPinIcon.value = value;
        },
      );
      OverlayImage.fromAssetImage(
        assetName: Assets.images.parking.path,
      ).then(
        (value) {
          parkingPinIcon.value = value;
        },
      );
    });
  });

  return CommonScaffold(
    title: '목적지',
    children: [
      Text(
        address,
        style: const TextStyle(
          fontSize: 15,
        ),
      ),
      AspectRatio(
        aspectRatio: 16 / 9,
        child: NaverMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(location.latitude, location.longitude),
          ),
          mapType: MapType.Navi,
          tiltGestureEnable: false,
          zoomGestureEnable: false,
          rotationGestureEnable: false,
          scrollGestureEnable: false,
          nightModeEnable:
              AdaptiveTheme.of(context).brightness == Brightness.dark,
          markers: [
            Marker(
              markerId: '1',
              position: LatLng(location.latitude, location.longitude),
              width: 16,
              height: 20,
              icon: targetPinIcon.value,
            ),
            Marker(
              markerId: '2',
              position: const LatLng(34.890858, 128.623559),
              width: 16,
              height: 20,
              icon: parkingPinIcon.value,
            ),
            Marker(
              markerId: '3',
              position: const LatLng(34.890767, 128.622794),
              width: 16,
              height: 20,
              icon: parkingPinIcon.value,
            ),
            Marker(
              markerId: '4',
              position: const LatLng(34.890186, 128.624471),
              width: 16,
              height: 20,
              icon: parkingPinIcon.value,
            ),
          ],
        ),
      ),
    ],
  );
}
