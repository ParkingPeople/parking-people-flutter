import 'package:functional_enum_annotation/functional_enum_annotation.dart';

part 'photo_status.g.dart';

@functionalEnum
enum PhotoStatus {
  stored,
  uploaded,
  analyzing,
  analyzed,
}
