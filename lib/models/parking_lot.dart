import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:parking_people_flutter/models/enums.dart';

part 'parking_lot.freezed.dart';
part 'parking_lot.g.dart';

enum ParkingLotType {
  PARKING_LOT,
  BUILDING,
  STREET;
}

@freezed
class ParkingLot with _$ParkingLot {
  const factory ParkingLot({
    int? id,
    String? type,
    required String name,
    required ActivityLevel activityLevel,
    int? capacity,
    int? baseFee,
    String? contact,
    int? timeToDes,
    int? distanceToDes,
    // required double latitude,
    // required double longitude,
    int? walkingDistance,
  }) = _ParkingLot;

  factory ParkingLot.fromJson(Map<String, Object?> json) =>
      _$ParkingLotFromJson(json);
}
