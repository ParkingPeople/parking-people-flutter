import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:gap/gap.dart';
import 'package:parking_people_flutter/gen/assets.gen.dart';
import 'package:parking_people_flutter/gen/colors.gen.dart';
import 'package:parking_people_flutter/models/parking_lot.dart';
import 'package:parking_people_flutter/translations.dart';
import 'package:parking_people_flutter/views/components/common_badge.dart';
import 'package:parking_people_flutter/views/components/common_scaffold.dart';

import '/utils/extensions/material_utils.dart';

part 'parking_lot_detail_screen.g.dart';

@swidget
Widget parkingLotDetailScreen(BuildContext context) {
  final args = context.routeArguments;
  final ParkingLot parkingLot = args['parkingLot'];

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
        child: Stack(
          fit: StackFit.expand,
          children: [
            Assets.images.parkingLotSample.image(fit: BoxFit.cover),
            Positioned(
              right: 8,
              bottom: 8,
              child: CommonBadge(
                color: parkingLot.activityLevel.displayColor,
                content: parkingLot.activityLevel.translate,
              ),
            ),
          ],
        ),
      ),
      const Text(
        '상세 주소',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      const Text('부산시 강서구 공항앞길 126 우리 주차장'),
      const Text(
        '전화번호',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      const Text('051-972-4400'),
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
      const Text(
        '소형',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      Row(
        children: [
          CommonBadge(
            color: ColorName.blue.withOpacity(0.4),
            content: '기본 요금',
          ),
          const Gap(8),
          const Text('30분 9000원, 추가 10분 300원'),
        ],
      ),
      TextButton(
        style: TextButton.styleFrom(
          backgroundColor: ColorName.blue,
          primary: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {},
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
