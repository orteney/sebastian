import 'package:json_annotation/json_annotation.dart';

part 'lcu_error.g.dart';

@JsonSerializable()
class LcuError implements Exception {
  final String errorCode;
  final int httpStatus;
  final String message;

  const LcuError({
    required this.errorCode,
    required this.httpStatus,
    required this.message,
  });

  factory LcuError.fromJson(Map<String, dynamic> json) => _$LcuErrorFromJson(json);
  Map<String, dynamic> toJson() => _$LcuErrorToJson(this);
}
