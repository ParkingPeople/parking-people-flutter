import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:functional_enum_annotation/functional_enum_annotation.dart';

part 'test_model.freezed.dart';
part 'test_model.g.dart';

@functionalEnum
enum TestEnum {
  yes,
  no,
  maybe;
}

@freezed
class TestModel with _$TestModel {
  const factory TestModel({
    required String firstName,
    @Default(0) int age,
    TestEnum? value,
  }) = _TestModel;

  factory TestModel.fromJson(Map<String, Object?> json) =>
      _$TestModelFromJson(json);
}
