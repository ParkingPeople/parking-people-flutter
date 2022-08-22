import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:gap/gap.dart';
import 'package:parking_people_flutter/gen/colors.gen.dart';
import 'package:parking_people_flutter/utils/globals.dart';
import 'package:parking_people_flutter/views/components/common/empty.dart';
import 'package:parking_people_flutter/views/components/common_badge.dart';
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
          const Gap(16),
          Table(
            columnWidths: const {
              0: IntrinsicColumnWidth(),
              1: FixedColumnWidth(8),
              2: FlexColumnWidth(),
            },
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              const TableRow(
                children: [
                  Text('촬영 일시'),
                  Empty(),
                  Text('2022. 08. 14 오전 11:26'),
                ],
              ),
              const TableRow(
                children: [
                  Text('주차 위치'),
                  Empty(),
                  Text('D4'),
                ],
              ),
              const TableRow(
                children: [
                  Text('사진 갯수'),
                  Empty(),
                  Text('4장'),
                ],
              ),
              TableRow(
                children: [
                  const Text('상태'),
                  const Empty(),
                  Row(
                    children: const [
                      CommonBadge(color: ColorName.blue, content: '검토 완료'),
                      Spacer(),
                    ],
                  ),
                ],
              ),
            ]
                .expand((element) => [
                      element,
                      const TableRow(
                        children: [
                          Gap(8),
                          Empty(),
                          Empty(),
                        ],
                      ),
                    ])
                .toList(),
            // children: {'촬영 일시': '2022. 08. 14 오전 11:26', '주차 위치': 'D4', '사진 갯수': '4장','상태': PhotoStatus.analyzed,}.entries.map(),
          ),
        ],
      ),
    ],
  );
}
