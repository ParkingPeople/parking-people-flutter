import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:parking_people_flutter/gen/colors.gen.dart';
import 'package:parking_people_flutter/utils/colors.dart';

part 'common_button.g.dart';

Color _splashBaseColor(Color buttonColor) =>
    isDark(buttonColor) ? Colors.white : ColorName.blue;

@swidget
Widget commonButton({
  required VoidCallback onTap,
  VoidCallback? onLongPress,
  String? text,
  Widget? child,
  Color buttonColor = Colors.white,
  Color buttonTextColor = Colors.black,
  double? buttonWidth,
  double buttonHeight = 72,
  double buttonFontSize = 16,
  bool mini = false,
  bool forAction = false,
  Border? buttonBorder,
  double buttonBorderRadius = 10,
  double borderWidth = 0,
  bool bold = false,
  EdgeInsets? padding,
}) =>
    Container(
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
                    color: Color.lerp(buttonColor, ColorName.black, .06)!,
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
          splashColor: _splashBaseColor(buttonColor).withOpacity(0.2),
          highlightColor: _splashBaseColor(buttonColor)
              .withOpacity(isDark(buttonColor) ? 0.2 : 0.1),
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
                          fontWeight: bold ? FontWeight.w700 : FontWeight.w500,
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
