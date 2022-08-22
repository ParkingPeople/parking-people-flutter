import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:parking_people_flutter/models/enums.dart';

part 'parking_lot.freezed.dart';
part 'parking_lot.g.dart';

@freezed
class ParkingLot with _$ParkingLot {
  const factory ParkingLot({
    required String name,
    required ActivityLevel activityLevel,
    // required double latitude,
    // required double longitude,
    int? walkingDistance,
  }) = _ParkingLot;

  factory ParkingLot.fromJson(Map<String, Object?> json) =>
      _$ParkingLotFromJson(json);
}
