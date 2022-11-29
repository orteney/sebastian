// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ready_check_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReadyCheckEvent _$ReadyCheckEventFromJson(Map<String, dynamic> json) =>
    ReadyCheckEvent(
      json['playerResponse'] as String,
      json['state'] as String,
      (json['timer'] as num).toDouble(),
    );
