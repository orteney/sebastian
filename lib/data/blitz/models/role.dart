import 'package:json_annotation/json_annotation.dart';

enum BlitzRole {
  @JsonValue('ADC')
  adc,

  @JsonValue('JUNGLE')
  jungle,

  @JsonValue('MID')
  mid,

  @JsonValue('SUPPORT')
  support,

  @JsonValue('TOP')
  top,
}
