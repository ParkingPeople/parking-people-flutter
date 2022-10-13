import 'dart:io';

import 'package:dio/dio.dart';
import 'package:parking_people_flutter/models/api_response.dart';
import 'package:retrofit/retrofit.dart';

part 'rest_api.g.dart';

@RestApi(baseUrl: "https://main.parkingpeople.app")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET("/parking-lots/recommend")
  Future<ParkingLotResponse> getRecommendations({
    @Query("lat") required double lat,
    @Query("lon") required double lng,
    @Query("range") required double rangeInKm,
  });

  @POST("/upload/file")
  @MultiPart()
  Future<bool> uploadFile({
    @Part(name: "lat") required double lat,
    @Part(name: "lon") required double lng,
    @Part(name: "file") required File file,
  });
}
