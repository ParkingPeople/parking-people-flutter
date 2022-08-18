import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';
import 'package:i18n_extension/i18n_widget.dart';
import 'package:parking_people_flutter/gen/colors.gen.dart';
import 'package:parking_people_flutter/gen/fonts.gen.dart';
import 'package:parking_people_flutter/utils/globals.dart';
import 'package:parking_people_flutter/views/routes/routes.dart';
import 'package:parking_people_flutter/views/screens/intro_screen.dart';

part 'parking_people_app.g.dart';

@swidget
Widget parkingPeopleApp(BuildContext context) {
  return AdaptiveTheme(
    initial: AdaptiveThemeMode.system,
    light: ThemeData(
      colorScheme: ColorScheme.fromSwatch(
          primarySwatch: ColorName.blue,
          accentColor: ColorName.blueAccent,
          brightness: Brightness.light),
      textTheme: const TextTheme(
        bodyText2: TextStyle(color: ColorName.black),
      ),
      fontFamily: FontFamily.spoqaHanSansNeo,
      brightness: Brightness.light,
    ),
    dark: ThemeData(
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: ColorName.blue,
        accentColor: ColorName.blueAccent,
        brightness: Brightness.dark,
      ),
      textTheme: const TextTheme(
        bodyText2: TextStyle(color: ColorName.lighterGrey),
      ),
      fontFamily: FontFamily.spoqaHanSansNeo,
      brightness: Brightness.dark,
    ),
    builder: (light, dark) => MaterialApp(
      navigatorKey: globalNavigatorKey,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ko', "KR"),
        Locale('en', "US"),
      ],
      routes: Routes.routeMap,
      home: I18n(
        child: const IntroScreen(),
      ),
      theme: light,
      darkTheme: dark,
    ),
  );
}
