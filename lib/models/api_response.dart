import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:parking_people_flutter/models/enums.dart';
import 'package:parking_people_flutter/models/parking_lot.dart';

part 'api_response.freezed.dart';
part 'api_response.g.dart';

abstract class ApiResponse<T extends ApiResponse<T>> {
  List<T> get list;
  ResponseStatus get status;
  int get count => list.length;
}

@freezed
class ParkingLotResponse with _$ParkingLotResponse {
  const factory ParkingLotResponse({
    required List<ParkingLot> parkingLots,
    required ResponseStatus status,
    int? count,
  }) = _ParkingLotResponse;

  factory ParkingLotResponse.fromJson(Map<String, Object?> json) =>
      _$ParkingLotResponseFromJson(json);
}
