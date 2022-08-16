import 'package:expand_tap_area/expand_tap_area.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:parking_people_flutter/parking_people_app.dart';

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
      runApp(const RootRestorationScope(
        restorationId: 'root',
        child: ParkingPeopleApp(),
      ));
    });
  });
}

Future<void> init() async {
  // do some stuffs
}
