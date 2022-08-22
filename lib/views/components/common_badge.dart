import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:parking_people_flutter/gen/colors.gen.dart';

part 'common_badge.g.dart';

@swidget
Widget commonBadge(
  BuildContext context, {
  required Color color,
  required String content,
}) {
  return Badge(
    toAnimate: false,
    shape: BadgeShape.square,
    badgeColor: color,
    borderRadius: BorderRadius.circular(10),
    badgeContent: Text(
      content,
      style: TextStyle(
        color: color.computeLuminance() > .5 ? ColorName.black : Colors.white,
      ),
    ),
  );
}
