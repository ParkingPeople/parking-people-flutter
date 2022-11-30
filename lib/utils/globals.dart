import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:logger/logger.dart';
import 'package:parking_people_flutter/repository/api_client.dart';
import 'package:parking_people_flutter/repository/rest_api.dart';

final defaultLogger = Logger();

final globalNavigatorKey = GlobalKey<NavigatorState>();

late String submitPhotoPath;

int lastVisitedId = -1;

// ignore: prefer_const_declarations
bool isDemoMode = false;

late final ApiClient? _defaultApiClient;

const defaultApiBaseUrl = "https://main.parkingpeople.app";

ApiClient get defaultApiClient =>
    _defaultApiClient ??= ParkingLotApi(Dio(), baseUrl: defaultApiBaseUrl);
