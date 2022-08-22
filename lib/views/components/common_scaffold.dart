import 'package:flutter/material.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:gap/gap.dart';
import 'package:parking_people_flutter/utils/extensions/list_utils.dart';

part 'common_scaffold.g.dart';

@swidget
Widget commonScaffold(
  BuildContext context, {
  required String title,
  List<Widget>? children,
  List<Widget>? actions,
}) {
  return Scaffold(
    appBar: AppBar(
      title: Text(
        title,
        style: const TextStyle(fontSize: 15),
      ),
      toolbarHeight: 60,
      backgroundColor: Colors.transparent,
      foregroundColor: Theme.of(context).textTheme.bodyText2?.color,
      elevation: 0,
      centerTitle: true,
      actions: actions,
    ),
    body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Gap(0),
          if (children != null) ...children,
        ]
            .wrapEachPadding(const EdgeInsets.symmetric(horizontal: 24))
            .withSpacer(const Gap(16))
            .toList(),
      ),
    ),
  );
}
