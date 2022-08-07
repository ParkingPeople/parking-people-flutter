import 'package:catcher/catcher.dart';
import 'package:expand_tap_area/expand_tap_area.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:parking_people_flutter/views/screens/parking_people_app.dart';
import 'package:sentry/sentry.dart';

import 'utils/globals.dart';

void main() {
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();

  // lock app rotation to portrait mode
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) {
// preserve native splash screen while the first page is not loaded
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

    // show layout debug ui
    if (kDebugMode) {
      // debugPaintExpandAreaEnabled = true;
      debugPaintExpandAreaColor = const Color(0xFF00FFFF).withOpacity(0.2);
    }

    init().then((_) {
      runCatcherApp(() => const ParkingPeopleApp());
    });
  });
}

Future<void> init() async {
  // do some stuffs
}

void runCatcherApp(Widget Function() launcher) {
  final sentryHandler = SentryHandler(SentryClient(SentryOptions(
    dsn: 'dsn',
  )));

  final CatcherOptions debugOptions = CatcherOptions(
    SilentReportMode(),
    [ConsoleHandler(), sentryHandler],
  );

  final CatcherOptions releaseOptions = CatcherOptions(
    SilentReportMode(),
    [sentryHandler],
  );

  Catcher(
    rootWidget: RootRestorationScope(
      restorationId: 'root',
      child: Phoenix(
        child: launcher.call(),
      ),
    ),
    debugConfig: debugOptions,
    releaseConfig: releaseOptions,
    navigatorKey: globalNavigatorKey,
  );
}
