import 'package:json_annotation/json_annotation.dart';

enum BlitzQueue {
  @JsonValue('CLASH_SR')
  clashSr,

  @JsonValue('HOWLING_ABYSS_ARAM')
  howlingAbyssAram,

  @JsonValue('HOWLING_ABYSS_PORO_KING')
  howlingAbyssPoroKing,

  @JsonValue('RANKED_FLEX_SR')
  rankedFlexSr,

  @JsonValue('RANKED_SOLO_5X5')
  rankedSolo5X5,

  @JsonValue('SUMMONERS_RIFT_ARURF')
  summonersRiftArurf,

  @JsonValue('SUMMONERS_RIFT_BLIND_PICK')
  summonersRiftBlindPick,

  @JsonValue('SUMMONERS_RIFT_DRAFT_PICK')
  summonersRiftDraftPick,

  @JsonValue('SUMMONERS_RIFT_URF')
  summonersRiftUrf,
}
