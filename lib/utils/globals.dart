import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';
import 'package:parking_people_flutter/repository/api_client.dart';
import 'package:parking_people_flutter/repository/rest_api.dart';

final defaultLogger = Logger();

final globalNavigatorKey = GlobalKey<NavigatorState>();

late String submitPhotoPath;

int lastVisitedId = -1;

// ignore: prefer_const_declarations
bool isDemoMode = false;

final ApiClient defaultApiClient =
    ParkingLotApi(Dio(), baseUrl: defaultApiBaseUrl);

const defaultApiBaseUrl = "https://main.parkingpeople.app";

late final FlutterSecureStorage storage;
Future<bool> get splashDismissed async {
  String splashDismissedString =
      await storage.read(key: DataKeys.splashDismissed) ?? 'false';
  return _boolSerializerMap[splashDismissedString] as bool;
}

const _boolSerializerMap = {
  true: 'true',
  false: 'false',
  'true': true,
  'false': false
};
set splashDismissed(FutureOr<bool> newSplashDismissed) {
  storage.write(
      key: DataKeys.splashDismissed,
      value: _boolSerializerMap[newSplashDismissed] as String);
}

abstract class DataKeys {
  static const splashDismissed = 'splashDismissed';
}
