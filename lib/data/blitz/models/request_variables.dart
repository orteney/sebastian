import 'package:json_annotation/json_annotation.dart';

import 'package:sebastian/data/blitz/models/queue.dart';
import 'package:sebastian/data/blitz/models/role.dart';

export 'package:sebastian/data/blitz/models/queue.dart';
export 'package:sebastian/data/blitz/models/role.dart';

part 'request_variables.g.dart';

@JsonSerializable(createFactory: false, includeIfNull: false)
class RequestVariables {
  final Queue queue;
  final String region;
  final String tier;
  final BlitzRole? role;
  final int championId;
  final int? opponentChampionId;

  RequestVariables({
    required this.queue,
    this.region = 'WORLD',
    this.tier = 'PLATINUM_PLUS',
    this.role,
    required this.championId,
    this.opponentChampionId,
  });

  Map<String, dynamic> toJson() => _$RequestVariablesToJson(this);
}
