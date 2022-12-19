import 'package:json_annotation/json_annotation.dart';

import 'package:sebastian/domain/core/role.dart';

enum BlitzRole {
  @JsonValue('ADC')
  adc(Role.adc),

  @JsonValue('JUNGLE')
  jungle(Role.jungle),

  @JsonValue('MID')
  mid(Role.mid),

  @JsonValue('SUPPORT')
  support(Role.support),

  @JsonValue('TOP')
  top(Role.top);

  final Role role;

  const BlitzRole(this.role);

  factory BlitzRole.fromRole(Role role) {
    return BlitzRole.values.firstWhere((element) => element.role == role);
  }
}
