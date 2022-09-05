import 'package:emulators/emulators.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:parking_people_flutter/main.dart' as app;
import 'package:parking_people_flutter/translations.dart';
import 'package:parking_people_flutter/utils/globals.dart';

Future<void> main() async {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  final emu = await Emulators.build();

  // final lines = await emu.toolchain.emulator(['-list-avds']).string();
  // final device = lines
  //     .split('\n')
  //     .map((line) => line.trim())
  //     .firstWhere((line) => line.isNotEmpty);

  final device = emu.currentDevice();

  final screenshot = emu.screenshotHelper(
    androidPath: 'screenshots/android',
    iosPath: 'screenshots/ios',
    suffixes: [Environment.getString('locale')].whereType<String>().toList(),
  );

  setUpAll(() async {
    await binding.waitUntilFirstFrameRasterized;

    // Clean up the status bar for the device
    await screenshot.cleanStatusBar();
  });

  // Close the connection to the driver after the tests have completed.
  tearDownAll(() async {
    emu.shutdownAll();
  });

  group('Screenshots', () {
    testWidgets('home screen', (tester) async {
      isDemoMode = true;
      app.main();
      await tester.pumpAndSettle();

      expect(find.text(Strings.introBody), findsOneWidget);

      await screenshot.capture('01');
    });

    // testWidgets('updated count', () async {
    //   await driver.tap(buttonFinder);
    //   await driver.tap(buttonFinder);
    //   await driver.tap(buttonFinder);
    //   await driver.waitUntilNoTransientCallbacks();
    //   await screenshot.capture('02');
    // });
  });
}
