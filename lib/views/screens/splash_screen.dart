import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:parking_people_flutter/gen/assets.gen.dart';
import 'package:parking_people_flutter/gen/colors.gen.dart';
import 'package:parking_people_flutter/views/routes/routes.dart';

part 'splash_screen.g.dart';

@swidget
Widget splashScreen(BuildContext context) {
  WidgetsBinding.instance.addPostFrameCallback((_) async {
    FlutterNativeSplash.remove();
    await Future.delayed(const Duration(
      seconds: 2,
    ));
    Navigator.of(context).pushReplacementNamed(Routes.intro);
  });

  return DecoratedBox(
    decoration: const BoxDecoration(
      color: ColorName.blue,
    ),
    child: SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Assets.images.splashLogo.image(),
              Transform.translate(
                offset: const Offset(0, -16),
                child: Assets.images.splashTitle.svg(),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
