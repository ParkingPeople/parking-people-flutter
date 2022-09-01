import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:parking_people_flutter/utils/globals.dart';
import 'package:parking_people_flutter/views/components/login_button.dart';
import 'package:parking_people_flutter/translations.dart';
import 'package:parking_people_flutter/utils/extensions/string_utils.dart';
import 'package:parking_people_flutter/utils/extensions/list_utils.dart';
import 'package:parking_people_flutter/views/routes/routes.dart';

part 'intro_screen.g.dart';

@hwidget
Widget introScreen(BuildContext context) {
  return Scaffold(
    body: SafeArea(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(),
            Text(
              Strings.introTitle.i18n,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            Text(
              Strings.introBody.i18n.lineBreak.onSpace,
              style: const TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 24,
              ),
            ),
            const Spacer(flex: 2),
            // KakaoLoginButton(onTap: () {
            //   defaultLogger.i('Kakao login');
            //   _navigateToNextScreen(context);
            // }),
            // GoogleLoginButton(onTap: () {
            //   defaultLogger.i('Google login');
            //   _navigateToNextScreen(context);
            // }),
            const Gap(16),
            RegisterButton(onTap: () {
              defaultLogger.i('Register');
              _navigateToNextScreen(context);
            }),
            const Gap(32),
          ]
              .wrapEachPadding(const EdgeInsets.symmetric(horizontal: 24))
              .withSpacer(const Gap(16))
              .toList(),
        ),
      ),
    ),
  );
}

void _navigateToNextScreen(BuildContext context) {
  //s
  Navigator.of(context).pushReplacementNamed(Routes.home);
}
