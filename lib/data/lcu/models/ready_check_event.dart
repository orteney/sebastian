// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'ready_check_event.g.dart';

/// Example body
/// {
///   "declinerIds": [],
///   "dodgeWarning": "None",
///   "playerResponse": "None",
///   "state": "InProgress",
///   "suppressUx": false,
///   "timer": 9.0
/// }
@JsonSerializable(createToJson: false)
class ReadyCheckEvent {
  final String playerResponse;
  final String state;
  final double timer;

  ReadyCheckEvent(
    this.playerResponse,
    this.state,
    this.timer,
  );

  factory ReadyCheckEvent.fromJson(Map<String, dynamic> json) => _$ReadyCheckEventFromJson(json);
}
