import 'package:flutter/widgets.dart';
import 'package:parking_people_flutter/views/routes/initial_route.dart';
import 'package:parking_people_flutter/views/screens/home_screen.dart';
import 'package:parking_people_flutter/views/screens/intro_screen.dart';
import 'package:parking_people_flutter/views/screens/my_point_screen.dart';
import 'package:parking_people_flutter/views/screens/parking_lot_detail_screen.dart';
import 'package:parking_people_flutter/views/screens/parking_lot_selection_screen.dart';
import 'package:parking_people_flutter/views/screens/submit_photo_screen.dart';
import 'package:parking_people_flutter/views/screens/submit_result_screen.dart';

class Routes {
  const Routes._();

  static const initialRoute = '/splash';
  static const intro = '/intro';
  static const home = '/home';
  static const searchResult = '/searchResult';
  static const locationDetail = '/locationDetail';
  static const pointStatus = '/pointStatus';
  static const photoSubmission = '/photoSubmission';
  static const photoSubmissionResult = '$photoSubmission/result';

  static final routeMap = <String, WidgetBuilder>{
    initialRoute: (_) => const InitialRouteWidget(),
    intro: (_) => const IntroScreen(),
    home: (_) => const HomeScreen(),
    pointStatus: (_) => const MyPointScreen(),
    searchResult: (_) => const ParkingLotSelectionScreen(),
    locationDetail: (_) => const ParkingLotDetailScreen(),
    photoSubmission: (_) => const SubmitPhotoScreen(),
    photoSubmissionResult: (_) => const SubmitResultScreen(),
  };
}
