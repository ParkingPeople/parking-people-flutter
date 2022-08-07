import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:flutter/material.dart';
import 'package:parking_people_flutter/constants/custom_colors.dart';
import 'package:parking_people_flutter/utils/colors.dart';

class CommonButton extends StatelessWidget {
  const CommonButton({
    super.key,
    required this.onTap,
    this.onLongPress,
    this.text,
    this.child,
    this.buttonColor = Colors.white,
    this.buttonTextColor = Colors.black,
    this.buttonWidth,
    this.buttonHeight = 72,
    this.buttonFontSize = 16.0,
    this.mini = false,
    this.forAction = false,
    this.buttonBorder,
    this.buttonBorderRadius = 10.0,
    this.borderWidth = 0,
    this.bold = false,
    this.padding,
  }) : assert(
          text != null || child != null,
          'Either text or child content must be given.',
        );

  ///
  final String? text;

  ///
  final Widget? child;

  ///
  final Color buttonColor;

  ///
  final Color buttonTextColor;

  ///
  final double? buttonWidth;

  ///
  final double buttonHeight;

  /// onTap에 아무것도 없으면 utils.dart에 있는 noop을 넣어줄 것
  final VoidCallback onTap;

  final VoidCallback? onLongPress;

  final double buttonFontSize;

  final bool mini;

  final bool forAction;

  final Border? buttonBorder;

  final double buttonBorderRadius;

  final double borderWidth;

  final bool bold;

  final EdgeInsets? padding;

  Color get _splashBaseColor =>
      isDark(buttonColor) ? CustomColors.white : CustomColors.blue;

  @override
  Widget build(final BuildContext context) => Container(
        clipBehavior: Clip.antiAlias,
        width: mini
            ? null
            : (buttonWidth ?? (forAction ? buttonHeight : double.infinity)),
        height: mini ? null : buttonHeight,
        padding: mini ? const EdgeInsets.all(8) : null,
        decoration: BoxDecoration(
          border: buttonBorder ??
              (borderWidth > 0
                  ? Border.all(
                      color: Color.lerp(buttonColor, CustomColors.black, .06)!,
                      width: borderWidth,
                    )
                  : null),
          borderRadius: BorderRadius.circular(
            forAction ? buttonHeight : buttonBorderRadius,
          ),
          color: buttonColor,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            onLongPress: onLongPress,
            splashColor: _splashBaseColor.withOpacity(0.2),
            highlightColor:
                _splashBaseColor.withOpacity(isDark(buttonColor) ? 0.2 : 0.1),
            child: Padding(
              padding: padding ?? EdgeInsets.zero,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: forAction ? MainAxisSize.min : MainAxisSize.max,
                children: [
                  FitHorizontally(
                    child: child ??
                        Text(
                          text!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: buttonTextColor,
                            fontWeight:
                                bold ? FontWeight.w700 : FontWeight.w500,
                            fontSize: buttonFontSize,
                          ),
                        ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
