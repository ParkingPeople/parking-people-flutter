import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

extension NestedIterableUtils<T> on Iterable<Iterable<T>> {
  Iterable<T> get flattened sync* {
    for (var i in this) {
      yield* i;
    }
  }
}

extension IterableUtils<T> on Iterable<T> {
  Iterable<R> mapWithIndex<R>(R Function(int index, T item) mapper) sync* {
    int index = 0;
    for (var item in this) {
      yield mapper.call(index++, item);
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
      map((e) => e is Flexible || e is Spacer || e is Gap || e is Divider
          ? e
          : Padding(
              padding: padding,
              child: e,
            ));
}
