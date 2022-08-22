import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:parking_people_flutter/gen/assets.gen.dart';
import 'package:parking_people_flutter/gen/colors.gen.dart';
import 'package:parking_people_flutter/translations.dart';

abstract class _LoginButton extends StatelessWidget {
  const _LoginButton({
    super.key,
    this.icon,
    required this.title,
    required this.backgroundColor,
    this.foregroundColor = ColorName.black,
    this.onTap,
    this.iconScaleFactor = 1.0,
    this.iconColor,
  });

  final Color backgroundColor;
  final Color foregroundColor;
  final String title;
  final VoidCallback? onTap;
  final SvgGenImage? icon;
  final double iconScaleFactor;

  final Color? iconColor;

  static const double _size = 48;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0x40000000),
            blurRadius: 6,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              onTap?.call();
            },
            splashColor: foregroundColor.withOpacity(0.1),
            highlightColor: foregroundColor.withOpacity(0.1),
            child: Ink(
              color: backgroundColor,
              child: Row(
                children: [
                  const Gap(4),
                  if (icon != null)
                    ClipRect(
                      child: Align(
                        widthFactor: min(1 / iconScaleFactor, 1),
                        heightFactor: min(1 / iconScaleFactor, 1),
                        child: Padding(
                          padding: EdgeInsets.all(
                              (1 - min(1, iconScaleFactor)) * _size / 2),
                          child: icon!.svg(
                            width: _size * iconScaleFactor,
                            height: _size * iconScaleFactor,
                            color: iconColor,
                          ),
                        ),
                      ),
                    ),
                  if (icon == null)
                    const SizedBox.square(
                      dimension: _size,
                    ),
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        color: foregroundColor,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Gap(_size),
                  const Gap(4),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class KakaoLoginButton extends _LoginButton {
  KakaoLoginButton({super.key, super.onTap})
      : super(
          icon: Assets.images.kakaoLogin,
          title: Strings.kakaoLogin.i18n,
          foregroundColor: ColorName.kakaoSymbol,
          backgroundColor: ColorName.kakaoBg,
          iconScaleFactor: 1.2,
        );
}

class GoogleLoginButton extends _LoginButton {
  GoogleLoginButton({super.key, super.onTap})
      : super(
          icon: Assets.images.googleLogin,
          title: Strings.googleLogin.i18n,
          foregroundColor: ColorName.black,
          backgroundColor: Colors.white,
          iconScaleFactor: 0.5,
        );
}

class RegisterButton extends _LoginButton {
  RegisterButton({super.key, super.onTap})
      : super(
          title: Strings.registerMail.i18n,
          foregroundColor: Colors.white,
          backgroundColor: ColorName.blue,
          iconScaleFactor: 0.5,
          iconColor: Colors.white,
        );
}
