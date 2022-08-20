import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:gap/gap.dart';
import 'package:parking_people_flutter/gen/colors.gen.dart';
import 'package:parking_people_flutter/utils/globals.dart';
import 'package:parking_people_flutter/views/components/common_scaffold.dart';

part 'submit_result_screen.g.dart';

@swidget
Widget submitResultScreen(BuildContext context) {
  return CommonScaffold(
    title: '사진 제출 결과',
    actions: [
      IconButton(
        icon: const Icon(Icons.home_rounded),
        onPressed: () {
          Navigator.of(context).popUntil((route) => route.isFirst);
        },
      ),
    ],
    children: [
      const Text(
        '20 포인트를 획득했어요.',
        style: TextStyle(
          color: ColorName.blue,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '하나 주차장',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          const Gap(8),
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Stack(
              fit: StackFit.expand,
              clipBehavior: Clip.hardEdge,
              children: [
                Image.file(
                  File(submitPhotoPath),
                  fit: BoxFit.cover,
                ),
                ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 8.0,
                      sigmaY: 8.0,
                    ),
                    child: Container(
                      color: Colors.transparent,
                    ),
                  ),
                ),
                Image.file(
                  File(submitPhotoPath),
                  fit: BoxFit.contain,
                ),
              ],
            ),
          ),
          Table(
            columnWidths: const {
              0: IntrinsicColumnWidth(),
              1: FlexColumnWidth(),
            },
            // children: {'촬영 일시': '2022. 08. 14 오전 11:26', '주차 위치': 'D4', '사진 갯수': '4장','상태': PhotoStatus.analyzed,}.entries.map(),
          ),
        ],
      ),
    ],
  );
}
