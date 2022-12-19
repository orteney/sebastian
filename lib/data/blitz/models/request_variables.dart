import 'package:json_annotation/json_annotation.dart';

import 'package:sebastian/data/blitz/models/blitz_queue.dart';
import 'package:sebastian/data/blitz/models/role.dart';

export 'package:sebastian/data/blitz/models/blitz_queue.dart';
export 'package:sebastian/data/blitz/models/role.dart';

part 'request_variables.g.dart';

@JsonSerializable(createFactory: false, includeIfNull: false)
class BuildRequestVariables {
  final BlitzQueue queue;
  final String region;
  final String tier;
  final BlitzRole? role;
  final int championId;
  final int? opponentChampionId;

  BuildRequestVariables({
    required this.queue,
    this.region = 'WORLD',
    this.tier = 'PLATINUM_PLUS',
    this.role,
    required this.championId,
    this.opponentChampionId,
  });

  Map<String, dynamic> toJson() => _$BuildRequestVariablesToJson(this);
}

@JsonSerializable(createFactory: false, includeIfNull: false)
class AllChampionsStatsRequestVariables {
  final BlitzQueue queue;

  AllChampionsStatsRequestVariables(this.queue);

  Map<String, dynamic> toJson() => _$AllChampionsStatsRequestVariablesToJson(this);
}
