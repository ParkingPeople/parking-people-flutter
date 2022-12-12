import 'package:dio/dio.dart';
import 'package:parking_people_flutter/utils/globals.dart';

abstract class ApiClient extends AbstractService {
  factory ApiClient(Dio dio, {required String baseUrl}) {
    throw UnimplementedError();
  }
}

abstract class AbstractService {}

abstract class ServiceLocator<T extends AbstractService> {
  S? lookup<S extends T>();
  S lookupExact<S extends T>();
}

class ApiClientLocator implements ServiceLocator<ApiClient> {
  static final instance = ApiClientLocator();

  @override
  S? lookup<S extends ApiClient>() {
    ApiClient lookupResult = defaultApiClient;
    if (lookupResult is S) {
      return lookupResult;
    }
    return null;
  }

  @override
  S lookupExact<S extends ApiClient>() {
    return lookup()!;
  }
}
