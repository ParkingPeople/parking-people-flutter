import 'dart:io';
import 'dart:ui';

import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter_use/flutter_use.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:parking_people_flutter/gen/assets.gen.dart';
import 'package:parking_people_flutter/gen/colors.gen.dart';
import 'package:parking_people_flutter/repository/api_client.dart';
import 'package:parking_people_flutter/repository/rest_api.dart';
import 'package:parking_people_flutter/translations.dart';
import 'package:parking_people_flutter/utils/globals.dart';
import 'package:parking_people_flutter/utils/extensions/material_utils.dart';
import 'package:parking_people_flutter/views/components/common/empty.dart';
import 'package:parking_people_flutter/views/components/common_badge.dart';
import 'package:parking_people_flutter/views/components/common_scaffold.dart';

import 'package:flutter_hooks/flutter_hooks.dart';

part 'submit_result_screen.g.dart';

@hwidget
Widget submitResultScreen(BuildContext context) {
  final args = context.routeArguments;

  final File file = args['file'];
  final double lat = args['lat'];
  final double lng = args['lng'];

  final parkingLotApi = ApiClientLocator.instance.lookup<ParkingLotApi>();

  final ValueNotifier<String?> lotName = useState<String?>(null);

  if (!isDemoMode) {
    useEffectOnce(() {
      final fetch = CancelableOperation.fromFuture(parkingLotApi?.uploadFile(
            lat: lat,
            lng: lng,
            file: file,
          ) ??
          Future.value(null))
        ..then(
          (response) {
            if (response ?? false) {
              // success
            } else {
              // error
            }
          },
          onError: (err, st) {
            defaultLogger.e("Error while submitting a photo", err, st);
          },
        );

      return () async {
        await fetch.cancel();
      };
    });
  }

  final image = isDemoMode
      ? Assets.images.parkingLotSample.image(
          fit: BoxFit.cover,
        )
      : Image.file(
          file,
          fit: BoxFit.cover,
        );

  return CommonScaffold(
    title: Strings.photoResultTitle.i18n,
    actions: [
      IconButton(
        icon: const Icon(Icons.home_rounded),
        onPressed: () {
          Navigator.of(context).popUntil((route) => route.isFirst);
        },
      ),
    ],
    children: [
      Text(
        Strings.photoResultText.i18n,
        style: const TextStyle(
          color: ColorName.blue,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            // TODO(qb20nh): this normally would be the display name of the real parking lot
            lotName.value ?? Strings.photoResultSubtitle.i18n,
            style: const TextStyle(
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
                image,
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
                image,
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
              TableRow(
                children: [
                  Text(Strings.photoTakenAt.i18n),
                  const Empty(),
                  FutureBuilder<DateTime>(
                      future: file.lastModified(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final DateFormat formatter =
                              DateFormat.yMd(Platform.localeName).add_jm();
                          return Text(formatter.format(snapshot.data!));
                        }
                        return const Empty();
                      }),
                ],
              ),
              // const TableRow(
              //   children: [
              //     Text('주차 위치'),
              //     Empty(),
              //     Text('D4'),
              //   ],
              // ),
              TableRow(
                children: [
                  Text(Strings.photoCount.i18n),
                  const Empty(),
                  Text('1${Strings.photoCountPostfix.i18n}'),
                ],
              ),
              TableRow(
                children: [
                  Text(Strings.photoState.i18n),
                  const Empty(),
                  Row(
                    children: [
                      CommonBadge(
                          color: ColorName.blue,
                          content: Strings.photoAnalysisStateDone.i18n),
                      const Spacer(),
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
