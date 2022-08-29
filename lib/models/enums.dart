import 'package:flutter/material.dart';
import 'package:functional_enum_annotation/functional_enum_annotation.dart';
import 'package:parking_people_flutter/gen/colors.gen.dart';
import 'package:parking_people_flutter/translations.dart';

part 'enums.g.dart';

@functionalEnum
enum PhotoStatus with Translatable {
  stored(Strings.photoStatusStored),
  uploaded(Strings.photoStatusUploaded),
  analyzing(Strings.photoStatusAnalyzing),
  analyzed(Strings.photoStatusAnalyzed);

  const PhotoStatus(this.translationKey);

  @override
  final String translationKey;
}

@functionalEnum
enum ActivityLevel with Translatable {
  FREE(Strings.activityLevelFree, ColorName.trafficFree),
  NORMAL(Strings.activityLevelNormal, ColorName.trafficNormal),
  CROWDED(Strings.activityLevelCrowded, ColorName.trafficCrowded),
  UNKNOWN(Strings.activityLevelUnkown, ColorName.darkGrey);

  const ActivityLevel(
    this.translationKey,
    this.displayColor,
  );

  @override
  final String translationKey;

  final Color displayColor;
}

enum ResponseStatus {
  OK(200, "OK"),
  BAD_REQUEST(400, "BAD_REQUEST"),
  NOT_FOUND(404, "NOT_FOUND"),
  INTERNAL_SERER_ERROR(500, "INTERNAL_SERVER_ERROR");

  const ResponseStatus(this.statusCode, this.code);

  final int statusCode;
  final String code;
}
