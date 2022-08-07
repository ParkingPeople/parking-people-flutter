import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parking_people_flutter/constants/custom_colors.dart';
import 'package:parking_people_flutter/views/components/common/common_button.dart';

class GoBackButton extends StatelessWidget {
  const GoBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => CommonButton(
        onTap: () {
          navigator?.maybePop();
        },
        buttonColor: Colors.transparent,
        child: const Icon(
          Icons.chevron_left,
          size: kToolbarHeight,
          color: CustomColors.grey,
        ),
      );
}
