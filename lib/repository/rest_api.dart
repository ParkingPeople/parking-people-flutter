import 'package:dio/dio.dart';
import 'package:parking_people_flutter/models/api_response.dart';
import 'package:retrofit/retrofit.dart';

part 'rest_api.g.dart';

@RestApi(
    baseUrl: "http://ec2-3-38-224-90.ap-northeast-2.compute.amazonaws.com:8080")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET("/parking-lots/recommend")
  Future<ParkingLotResponse> getRecommendations({
    @Query("lat") required double lat,
    @Query("lon") required double lng,
    @Query("range") required double rangeInKm,
  });
}
