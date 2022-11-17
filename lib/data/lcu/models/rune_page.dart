import 'package:json_annotation/json_annotation.dart';

part 'rune_page.g.dart';

@JsonSerializable()
class RunePage {
  final String name;
  final int primaryStyleId;
  final int subStyleId;
  final bool current;
  final List<int> selectedPerkIds;

  const RunePage({
    required this.name,
    required this.primaryStyleId,
    required this.subStyleId,
    required this.current,
    required this.selectedPerkIds,
  });

  factory RunePage.fromJson(Map<String, dynamic> json) => _$RunePageFromJson(json);
  Map<String, dynamic> toJson() => _$RunePageToJson(this);
}
