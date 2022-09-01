import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:clipboard/clipboard.dart';
import 'package:dart_numerics/dart_numerics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_use/flutter_use.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:gap/gap.dart';
import 'package:parking_people_flutter/gen/assets.gen.dart';
import 'package:parking_people_flutter/gen/colors.gen.dart';
import 'package:parking_people_flutter/models/parking_lot.dart';
import 'package:parking_people_flutter/translations.dart';
import 'package:parking_people_flutter/views/components/common_badge.dart';
import 'package:parking_people_flutter/views/components/common_scaffold.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '/utils/extensions/material_utils.dart';

part 'parking_lot_detail_screen.g.dart';

@hwidget
Widget parkingLotDetailScreen(BuildContext context) {
  final args = context.routeArguments;
  final ParkingLot parkingLot = args['parkingLot'];

  final ValueNotifier<OverlayImage?> parkingPinIcon =
      useState<OverlayImage?>(null);

  useMount(() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      OverlayImage.fromAssetImage(
        assetName: Assets.images.parking.path,
      ).then(
        (value) {
          parkingPinIcon.value = value;
        },
      );
    });
  });

  final defaultTextStyle = Theme.of(context).textTheme.bodyText2?.merge(
        const TextStyle(
          fontSize: 19,
        ),
      );

  final chipColor =
      Color.lerp(ColorName.blue, Theme.of(context).backgroundColor, 0.6) ??
          ColorName.blue;

  return CommonScaffold(
    title: parkingLot.name,
    actions: [
      IconButton(
        icon: const Icon(Icons.home_rounded),
        onPressed: () {
          Navigator.of(context).popUntil((route) => route.isFirst);
        },
      ),
    ],
    children: [
      AspectRatio(
        aspectRatio: 16 / 9,
        child: NaverMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(parkingLot.latitude, parkingLot.longitude),
          ),
          onMapCreated: (controller) async {
            controller.getMeterPerDp();
            const targetCellSize = 100;
            final zoomLevel = 7 * (3 - log10(targetCellSize / 2) / 2);
            controller.moveCamera(CameraUpdate.zoomTo(zoomLevel));
          },
          mapType: MapType.Navi,
          tiltGestureEnable: false,
          zoomGestureEnable: false,
          rotationGestureEnable: false,
          scrollGestureEnable: false,
          nightModeEnable:
              AdaptiveTheme.of(context).brightness == Brightness.dark,
          markers: [
            Marker(
              markerId: 'parkingLot',
              position: LatLng(parkingLot.latitude, parkingLot.longitude),
              width: 20,
              height: 20,
              icon: parkingPinIcon.value,
            ),
          ],
        ),
      ),
      if (parkingLot.address is String) ...[
        const Text(
          '주소',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        GestureDetector(
          onTap: () async {
            await FlutterClipboard.copy(parkingLot.address ?? '');
            Fluttertoast.showToast(msg: '주소가 클립보드에 복사됨');
          },
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: parkingLot.address ?? '',
                  style: defaultTextStyle?.merge(
                    const TextStyle(
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                TextSpan(text: ' ', style: defaultTextStyle),
                const WidgetSpan(
                    child: Icon(
                  Icons.copy_rounded,
                  size: 19,
                )),
              ],
            ),
          ),
        ),
      ],
      if (parkingLot.contact is String) ...[
        const Text(
          '전화번호',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        GestureDetector(
          onTap: () async {
            launchUrlString('tel:${parkingLot.contact ?? ''}');
          },
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: parkingLot.contact ?? '',
                  style: defaultTextStyle?.merge(
                      const TextStyle(decoration: TextDecoration.underline)),
                ),
                TextSpan(
                  text: ' ',
                  style: defaultTextStyle,
                ),
                const WidgetSpan(
                  child: Icon(
                    Icons.phone_rounded,
                    size: 19,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
      const Divider(
        height: 15,
        thickness: 15,
      ),
      const Center(
        child: Text(
          '주차 요금',
          style: TextStyle(
            fontSize: 17,
          ),
        ),
      ),
      // const Text(
      //   '소형',
      //   style: TextStyle(
      //     fontWeight: FontWeight.bold,
      //   ),
      // ),
      Row(
        children: [
          CommonBadge(
            color: chipColor,
            content: '기본 요금',
          ),
          const Gap(8),
          Expanded(
            child: Text(
              _getFeeText(parkingLot),
              overflow: TextOverflow.fade,
            ),
          ),
        ],
      ),
      Row(
        children: [
          CommonBadge(
            color: chipColor,
            content: '정기 요금',
          ),
          const Gap(8),
          Expanded(
            child: Text(
              _getRoutineFeeText(parkingLot),
              overflow: TextOverflow.fade,
            ),
          ),
        ],
      ),
      TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: ColorName.blue,
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {
          launchUrlString(
              'geo:${parkingLot.latitude},${parkingLot.longitude}?q=${parkingLot.name}');
        },
        child: Text(
          Strings.navigate.i18n,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ),
    ],
  );
}

String _getFeeText(ParkingLot parkingLot) {
  final baseFee = parkingLot.baseFee ?? 0,
      baseFeeDuration = parkingLot.baseFeeDuration?.inMinutes ?? 0,
      extraFee = parkingLot.extraFee ?? 0,
      extraFeeDuration = parkingLot.extraFeeDuration?.inMinutes ?? 0;

  if (baseFee == 0 && extraFee == 0) {
    return '무료';
  }

  if (baseFee == 0 && extraFee != 0) {
    return '$baseFeeDuration분 무료, 이후 $extraFeeDuration분당 $extraFee원';
  }

  if (extraFee == 0 ||
      (baseFee == extraFee && baseFeeDuration == extraFeeDuration)) {
    return '$baseFeeDuration분당 $baseFee원';
  }

  return '$baseFeeDuration분 $baseFee원, 이후 $extraFeeDuration분당 $extraFee원';
}

String _getRoutineFeeText(ParkingLot parkingLot) {
  final dailyFee = parkingLot.dailyFee, monthlyFee = parkingLot.monthlyFee;

  final dailyFeePart = dailyFee == null ? '' : '일주차 $dailyFee원';
  final monthlyFeePart = monthlyFee == null ? '' : '월주차 $monthlyFee원';

  return [dailyFeePart, monthlyFeePart]
      .where((part) => part.isNotEmpty)
      .join(', ');
}
