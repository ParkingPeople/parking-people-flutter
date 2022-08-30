import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:async/async.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_use/flutter_use.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:gap/gap.dart';
import 'package:geocoding/geocoding.dart';
import 'package:naver_map_plugin/naver_map_plugin.dart';
import 'package:parking_people_flutter/gen/assets.gen.dart';
import 'package:parking_people_flutter/models/parking_lot.dart';
import 'package:parking_people_flutter/repository/rest_api.dart';
import 'package:parking_people_flutter/utils/globals.dart';
import 'package:parking_people_flutter/views/components/common/empty.dart';
import 'package:parking_people_flutter/views/components/common_scaffold.dart';
import 'package:parking_people_flutter/views/components/custom_card.dart';
import 'package:parking_people_flutter/views/routes/routes.dart';

import '/utils/extensions/material_utils.dart';
import '/utils/extensions/list_utils.dart';

import 'package:flutter_hooks/flutter_hooks.dart';

part 'parking_lot_selection_screen.g.dart';

@hwidget
Widget parkingLotSelectionScreen(BuildContext context) {
  final args = context.routeArguments;
  final String address = args['address'];
  final Location location = args['location'];

  final ValueNotifier<OverlayImage?> targetPinIcon =
      useState<OverlayImage?>(null);
  final ValueNotifier<OverlayImage?> parkingPinIcon =
      useState<OverlayImage?>(null);

  final ValueNotifier<List<ParkingLot>> parkingLots =
      useState<List<ParkingLot>>([]);

  defaultLogger.d(args);

  final dio = RestClient(Dio());

  useEffectOnce(() {
    CancelableOperation fetch =
        CancelableOperation.fromFuture(dio.getRecommendations(
      lat: location.latitude,
      lng: location.longitude,
      rangeInKm: 1,
    ));
    fetch.then((response) {
      parkingLots.value = response.parkingLots;
    });
    return () {
      fetch.cancel();
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
              markerId: 'mylocation',
              position: LatLng(location.latitude, location.longitude),
              width: 20,
              height: 20,
              icon: targetPinIcon.value,
            ),
            ...parkingLots.value.map((parkingLot) => Marker(
                  markerId: parkingLot.name,
                  position: LatLng(parkingLot.latitude, parkingLot.longitude),
                  width: 20,
                  height: 20,
                  icon: parkingPinIcon.value,
                )),
          ],
        ),
      ),
      ...parkingLots.value.map(
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
                    if (parkingLot.distanceToDes != null)
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
                            '${parkingLot.distanceToDes}m',
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
      const Empty(),
    ],
  );
}
