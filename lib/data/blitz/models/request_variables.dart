import 'package:json_annotation/json_annotation.dart';

import 'package:sebastian/data/blitz/models/blitz_queue.dart';
import 'package:sebastian/data/blitz/models/role.dart';

export 'package:sebastian/data/blitz/models/blitz_queue.dart';
export 'package:sebastian/data/blitz/models/role.dart';

part 'request_variables.g.dart';

@JsonSerializable(createFactory: false, includeIfNull: false)
class BuildRequestVariables {
  final String championId;
  final BlitzQueue queue;

  @JsonKey(toJson: blitzRoleToJson)
  final BlitzRole? role;

  BuildRequestVariables({
    required this.championId,
    required this.queue,
    this.role,
  });

  Map<String, dynamic> toJson() => _$BuildRequestVariablesToJson(this);
}

@JsonSerializable(createFactory: false, includeIfNull: false)
class AllChampionsStatsRequestVariables {
  final BlitzQueue queue;

  AllChampionsStatsRequestVariables(this.queue);

  Map<String, dynamic> toJson() => _$AllChampionsStatsRequestVariablesToJson(this);
}
