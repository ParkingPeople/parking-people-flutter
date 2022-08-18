import 'package:flutter/widgets.dart';
import 'package:parking_people_flutter/views/screens/home_screen.dart';
import 'package:parking_people_flutter/views/screens/intro_screen.dart';

class Routes {
  const Routes._();

  static const initialRoute = '/';
  static const intro = '/intro';
  static const home = '/home';
  static const searchResult = '/searchResult';
  static const locationDetail = '/locationDetail';
  static const pointStatus = '/pointStatus';
  static const photoSubmission = '/photoSubmission';
  static const photoSubmissionResult = '$photoSubmission/result';

  static final routeMap = <String, WidgetBuilder>{
    // initialRoute: (_) => const InitialRouteWidget(),
    intro: (_) => const IntroScreen(),
    home: (_) => const HomeScreen(),
  };
}
