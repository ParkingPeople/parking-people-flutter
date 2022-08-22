import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:parking_people_flutter/gen/colors.gen.dart';
import 'package:parking_people_flutter/translations.dart';
import 'package:parking_people_flutter/views/components/common_scaffold.dart';
import 'package:parking_people_flutter/views/components/common_text_style_scope.dart';
import 'package:parking_people_flutter/views/components/custom_card.dart';
import 'package:parking_people_flutter/views/routes/routes.dart';

part 'my_point_screen.g.dart';

@swidget
Widget myPointScreen(BuildContext context) {
  return CommonScaffold(
    title: Strings.pointTitle.i18n,
    children: [
      CommonTextStyleScope(
        style: const TextStyle(fontSize: 17),
        child: Row(
          children: const [
            Text(
              '\${user.name}님',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text('의 현재 포인트'),
          ],
        ),
      ),
      const SizedBox.square(
        dimension: 189,
        child: Center(
          child: Card(
            color: ColorName.blue,
            shape: CircleBorder(),
            clipBehavior: Clip.hardEdge,
            child: Center(
              child: Text(
                '35포인트',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
      CustomCard(
        title: '주차장 사진 촬영하고 포인트 얻기',
        onTap: () {
          Navigator.of(context).pushNamed(Routes.photoSubmission);
        },
        child: const Text(
          '사진 한 장당 1포인트\n한 주차장 당 최대 4장의 사진에서 포인트 얻기 가능',
          style: TextStyle(
            fontSize: 13,
          ),
        ),
      ),
      CustomCard(
        title: '포인트 구매하기',
        onTap: () {},
      ),
    ],
  );
}
