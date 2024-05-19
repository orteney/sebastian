// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lcu_error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LcuError _$LcuErrorFromJson(Map<String, dynamic> json) => LcuError(
      errorCode: json['errorCode'] as String,
      httpStatus: (json['httpStatus'] as num).toInt(),
      message: json['message'] as String,
    );

Map<String, dynamic> _$LcuErrorToJson(LcuError instance) => <String, dynamic>{
      'errorCode': instance.errorCode,
      'httpStatus': instance.httpStatus,
      'message': instance.message,
    };
