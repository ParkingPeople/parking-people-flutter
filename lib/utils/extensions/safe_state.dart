import 'package:flutter/widgets.dart';
import 'package:parking_people_flutter/utils/globals.dart';

abstract class SafeState<T extends StatefulWidget> extends State<T> {
  late final logger = defaultLogger;

  bool _mutating = false;

  @protected
  bool safeAction(VoidCallback fn) {
    if (mounted) {
      fn();
    }

    return mounted;
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      if (_mutating) {
        logger.w('setState called inside another setState.');

        fn();

        return;
      }
      _mutating = true;
      super.setState(fn);
      _mutating = false;
    } else {
      logger.e('setState called for dismounted widget.');
    }
  }
}
