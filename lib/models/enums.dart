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
  free(Strings.activityLevelFree, ColorName.trafficFree),
  normal(Strings.activityLevelNormal, ColorName.trafficNormal),
  crowded(Strings.activityLevelCrowded, ColorName.trafficCrowded),
  unknown(Strings.activityLevelUnkown, ColorName.darkGrey);

  const ActivityLevel(
    this.translationKey,
    this.displayColor,
  );

  @override
  final String translationKey;

  final Color displayColor;
}
