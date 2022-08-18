import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';

extension IterableUtils<T> on Iterable<Iterable<T>> {
  Iterable<T> get flattened sync* {
    for (var i in this) {
      yield* i;
    }
  }
}

extension InsertJoiners on Iterable<Widget> {
  Iterable<Widget> withSpacer(Widget spacer) sync* {
    if (length > 0) {
      yield elementAt(0);
      for (Widget element in skip(1)) {
        yield spacer;
        yield element;
      }
    }
  }

  Iterable<Widget> wrapEachPadding(EdgeInsets padding) =>
      map((e) => e is Flexible || e is Spacer || e is Gap
          ? e
          : Padding(
              padding: padding,
              child: e,
            ));
}
