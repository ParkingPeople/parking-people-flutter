import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:gap/gap.dart';

import 'package:parking_people_flutter/utils/extensions/list_utils.dart';

part 'custom_card.g.dart';

@swidget
Widget customCard(
  BuildContext context, {
  dynamic title,
  Widget? child,
  TransitionBuilder? builder,
  VoidCallback? onTap,
  bool hideAction = false,
  String? action,
}) {
  return Center(
    child: Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(25)),
      ),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (title != null ||
                  action != null ||
                  (onTap != null && !hideAction))
                Row(
                  children: [
                    if (title is String)
                      Expanded(
                        child: Text(
                          title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    if (title is Widget) Expanded(child: title),
                    if (action != null)
                      Text(
                        action,
                        style: const TextStyle(
                          fontSize: 13,
                        ),
                      ),
                    if (onTap != null && !hideAction)
                      const Icon(Icons.chevron_right_rounded),
                  ],
                ),
              if (builder != null) builder.call(context, child),
              if (builder == null && child != null) child,
            ].withSpacer(const Gap(16)).toList(),
          ),
        ),
      ),
    ),
  );
}
