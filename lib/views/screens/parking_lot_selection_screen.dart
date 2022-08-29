import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_use/flutter_use.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:gap/gap.dart';
import 'package:geocoding/geocoding.dart';
import 'package:naver_map_plugin/naver_map_plugin.dart';
import 'package:parking_people_flutter/gen/assets.gen.dart';
import 'package:parking_people_flutter/models/enums.dart';
import 'package:parking_people_flutter/models/parking_lot.dart';
import 'package:parking_people_flutter/repository/rest_api.dart';
import 'package:parking_people_flutter/utils/globals.dart';
import 'package:parking_people_flutter/views/components/common_scaffold.dart';
import 'package:parking_people_flutter/views/components/custom_card.dart';
import 'package:parking_people_flutter/views/routes/routes.dart';

import '/utils/extensions/material_utils.dart';
import '/utils/extensions/list_utils.dart';

import 'package:flutter_hooks/flutter_hooks.dart';

part 'parking_lot_selection_screen.g.dart';

const List<ParkingLot> sampleData = [
  ParkingLot(
    name: '고현중앙공영주차장',
    activityLevel: ActivityLevel.FREE,
    walkingDistance: 130,
  ),
  ParkingLot(
    name: '시외버스터미널뒤편',
    activityLevel: ActivityLevel.NORMAL,
    walkingDistance: 92,
  ),
  ParkingLot(
    name: '버스터미널뒤편',
    activityLevel: ActivityLevel.CROWDED,
    walkingDistance: 60,
  ),
];

@hwidget
Widget parkingLotSelectionScreen(BuildContext context) {
  final args = context.routeArguments;
  final String address = args['address'];
  final Location location = args['location'];

  ValueNotifier<OverlayImage?> targetPinIcon = useState<OverlayImage?>(null);
  ValueNotifier<OverlayImage?> parkingPinIcon = useState<OverlayImage?>(null);

  defaultLogger.d(args);

  final dio = RestClient(Dio());

  useEffectOnce(() {
    final future = dio.getRecommendations(
      lat: location.latitude,
      lng: location.longitude,
      rangeInKm: 2,
    )..then((value) => defaultLogger.d(value));
    return () {
      future.timeout(Duration.zero);
    };
  });

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
              width: 20,
              height: 20,
              icon: targetPinIcon.value,
            ),
            Marker(
              markerId: '2',
              position: const LatLng(34.890858, 128.623559),
              width: 20,
              height: 20,
              icon: parkingPinIcon.value,
            ),
            Marker(
              markerId: '3',
              position: const LatLng(34.890767, 128.622794),
              width: 20,
              height: 20,
              icon: parkingPinIcon.value,
            ),
            Marker(
              markerId: '4',
              position: const LatLng(34.890186, 128.624471),
              width: 20,
              height: 20,
              icon: parkingPinIcon.value,
            ),
          ],
        ),
      ),
      ...sampleData.map(
        (parkingLot) => CustomCard(
          hideAction: true,
          onTap: () {
            Navigator.of(context).pushNamed(
              Routes.locationDetail,
              arguments: {'parkingLot': parkingLot},
            );
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      parkingLot.name,
                      style: const TextStyle(
                        fontSize: 17,
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          '목적지에서',
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        ),
                        const Gap(8),
                        Text(
                          '${parkingLot.walkingDistance}m',
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ].withSpacer(const Gap(8)).toList(),
                ),
              ),
              const Gap(8),
              SizedBox.square(
                dimension: 70,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: parkingLot.activityLevel.displayColor,
                  ),
                  child: Center(
                    child: Text(parkingLot.activityLevel.translate),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
