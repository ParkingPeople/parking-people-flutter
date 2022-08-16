import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:get/get.dart';
import 'package:parking_people_flutter/gen/colors.gen.dart';
import 'package:parking_people_flutter/views/components/common/common_button.dart';

part 'go_back_button.g.dart';

@swidget
Widget goBackButton() => CommonButton(
      onTap: () {
        navigator?.maybePop();
      },
      buttonColor: Colors.transparent,
      child: const Icon(
        Icons.chevron_left,
        size: kToolbarHeight,
        color: ColorName.grey,
      ),
    );
