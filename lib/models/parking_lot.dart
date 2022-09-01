import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:parking_people_flutter/models/enums.dart';
import 'package:parking_people_flutter/translations.dart';

part 'parking_lot.freezed.dart';
part 'parking_lot.g.dart';

abstract class JsonParseable<T extends JsonParseable<T>> {
  String get jsonKey;
}

enum ParkingLotType with JsonParseable<ParkingLotType>, Translatable {
  parkingLot('노외', Strings.parkingLotType_parkingLot),
  building('부설', Strings.parkingLotType_building),
  street('노상', Strings.parkingLotType_street);

  const ParkingLotType(this.jsonKey, this.translationKey);

  @override
  final String jsonKey;

  @override
  final String translationKey;
}

@freezed
class ParkingLot with _$ParkingLot {
  const factory ParkingLot({
    int? id,
    required String name,
    String? address,
    required double latitude,
    required double longitude,
    @JsonKey(name: 'address_old') String? addressOld,
    required ActivityLevel activityLevel,
    @JsonKey(fromJson: JsonConverters._parseParkingLotType, toJson: JsonConverters._unparseParkingLotType)
        ParkingLotType? parkingLotType,
    @JsonKey(name: 'is_public', fromJson: JsonConverters._parseIsPublic, toJson: JsonConverters._unparseIsPublic)
        bool? isPublic,
    int? capacity,
    int? parkingClass,
    @JsonKey(name: 'opens_at_workdays', fromJson: JsonConverters._parseTimeOfDay, toJson: JsonConverters._unparseTimeOfDay)
        TimeOfDay? opensAtWorkdays,
    @JsonKey(name: 'closes_at_workdays', fromJson: JsonConverters._parseTimeOfDay, toJson: JsonConverters._unparseTimeOfDay)
        TimeOfDay? closesAtWorkdays,
    @JsonKey(name: 'opens_at_saturdays', fromJson: JsonConverters._parseTimeOfDay, toJson: JsonConverters._unparseTimeOfDay)
        TimeOfDay? opensAtSaturdays,
    @JsonKey(name: 'closes_at_saturdays', fromJson: JsonConverters._parseTimeOfDay, toJson: JsonConverters._unparseTimeOfDay)
        TimeOfDay? closesAtSaturdays,
    @JsonKey(name: 'opens_at_holidays', fromJson: JsonConverters._parseTimeOfDay, toJson: JsonConverters._unparseTimeOfDay)
        TimeOfDay? opensAtHolidays,
    @JsonKey(name: 'closes_at_holidays', fromJson: JsonConverters._parseTimeOfDay, toJson: JsonConverters._unparseTimeOfDay)
        TimeOfDay? closesAtHolidays,
    @JsonKey(name: 'external_id') String? externalId,
    @JsonKey(name: 'base_fee') int? baseFee,
    @JsonKey(name: 'base_fee_duration', fromJson: JsonConverters._parseDuration, toJson: JsonConverters._unparseDuration)
        Duration? baseFeeDuration,
    @JsonKey(name: 'extra_fee') int? extraFee,
    @JsonKey(name: 'extra_fee_duration', fromJson: JsonConverters._parseDuration, toJson: JsonConverters._unparseDuration)
        Duration? extraFeeDuration,
    @JsonKey(name: 'daily_fee') int? dailyFee,
    @JsonKey(name: 'monthly_fee') int? monthlyFee,
    String? contact,
    int? timeToDes,
    int? distanceToDes,
  }) = _ParkingLot;

  factory ParkingLot.fromJson(Map<String, Object?> json) =>
      _$ParkingLotFromJson(json);
}

class JsonConverters {
  const JsonConverters._();

  static ParkingLotType? _parseParkingLotType(String? tok) {
    if (tok == null) {
      return null;
    }
    return ParkingLotType.values.firstWhere((type) => type.jsonKey == tok);
  }

  static String? _unparseParkingLotType(ParkingLotType? field) {
    if (field == null) {
      return null;
    }
    return field.jsonKey;
  }

  static const _isPublicMap = {true: '공영', false: '민영'};

  static bool? _parseIsPublic(String? tok) {
    if (tok == null) {
      return null;
    }
    return tok == _isPublicMap[true];
  }

  static String? _unparseIsPublic(bool? field) {
    if (field == null) {
      return null;
    }
    return _isPublicMap[field];
  }

  static TimeOfDay? _parseTimeOfDay(String? tok) {
    if (tok == null) {
      return null;
    }
    List<String> parts = tok.split(':');
    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
  }

  static String? _unparseTimeOfDay(TimeOfDay? field) {
    if (field == null) {
      return null;
    }
    return '${field.hour.toString().padLeft(2, '0')}:${field.minute.toString().padLeft(2, '0')}';
  }

  static Duration? _parseDuration(int? tok) {
    if (tok == null) {
      return null;
    }
    return Duration(minutes: tok);
  }

  static int? _unparseDuration(Duration? field) {
    if (field == null) {
      return null;
    }
    return field.inMinutes;
  }
}
