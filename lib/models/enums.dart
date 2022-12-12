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
  // ignore: constant_identifier_names
  FREE(Strings.activityLevelFree, ColorName.trafficFree),
  // ignore: constant_identifier_names
  NORMAL(Strings.activityLevelNormal, ColorName.trafficNormal),
  // ignore: constant_identifier_names
  CROWDED(Strings.activityLevelCrowded, ColorName.trafficCrowded),
  // ignore: constant_identifier_names
  UNKNOWN(Strings.activityLevelUnknown, ColorName.darkGrey);

  const ActivityLevel(
    this.translationKey,
    this.displayColor,
  );

  @override
  final String translationKey;

  final Color displayColor;
}

enum ResponseStatus {
  // ignore: constant_identifier_names
  OK(200, "OK"),
  // ignore: constant_identifier_names
  BAD_REQUEST(400, "BAD_REQUEST"),
  // ignore: constant_identifier_names
  NOT_FOUND(404, "NOT_FOUND"),
  // ignore: constant_identifier_names
  INTERNAL_SERER_ERROR(500, "INTERNAL_SERVER_ERROR");

  const ResponseStatus(this.statusCode, this.code);

  final int statusCode;
  final String code;
}
