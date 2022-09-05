import 'package:flutter/widgets.dart';
import 'package:logger/logger.dart';

final defaultLogger = Logger();

final globalNavigatorKey = GlobalKey<NavigatorState>();

late String submitPhotoPath;

int lastVisitedId = -1;

// ignore: prefer_const_declarations
bool isDemoMode = false;
