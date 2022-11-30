import 'dart:ui';

enum PerkStyle {
  precision(
    8000,
    Color(0x1AFFC229),
  ),
  domination(
    8100,
    Color(0x1AF51849),
  ),
  sorcery(
    8200,
    Color(0x1A001CD5),
  ),
  inspiration(
    8300,
    Color(0x1A14E7F3),
  ),
  resolve(
    8400,
    Color(0x1A34FD5F),
  ),
  unknown(
    0,
    Color(0x1AFFFFFF),
  );

  const PerkStyle(this.id, this.color);

  final int id;
  final Color color;

  static PerkStyle fromId(int? id) {
    for (var perkStyle in PerkStyle.values) {
      if (perkStyle.id == id) return perkStyle;
    }

    return PerkStyle.unknown;
  }
}
