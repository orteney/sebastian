import 'package:json_annotation/json_annotation.dart';
import 'package:sebastian/data/blitz/models/request_variables.dart';

part 'blitz_primary_role_response.g.dart';

@JsonSerializable(createToJson: false)
class BlitzPrimaryRoleResponse {
  final BlitzPrimaryRoleData data;

  BlitzPrimaryRoleResponse(this.data);

  factory BlitzPrimaryRoleResponse.fromJson(Map<String, dynamic> json) => _$BlitzPrimaryRoleResponseFromJson(json);
}

@JsonSerializable(createToJson: false)
class BlitzPrimaryRoleData {
  final BlitzRole primaryRole;

  BlitzPrimaryRoleData(this.primaryRole);

  factory BlitzPrimaryRoleData.fromJson(Map<String, dynamic> json) => _$BlitzPrimaryRoleDataFromJson(json);
}
