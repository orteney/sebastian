import 'dart:ui';

import 'package:sebastian/data/lcu/pick_session.dart';

enum Role {
  toplane(4),
  jungler(3),
  midlane(2),
  botlane(1),
  support(0),

  aram(-1);

  final int roleId;

  const Role(this.roleId);

  static Role fromId(int? id) {
    for (var role in Role.values) {
      if (role.roleId == id) return role;
    }

    return Role.aram;
  }

  static Role? fromPosition(PickPosition? position) {
    switch (position) {
      case PickPosition.top:
        return Role.toplane;
      case PickPosition.jungle:
        return Role.jungler;
      case PickPosition.middle:
        return Role.midlane;
      case PickPosition.bottom:
        return Role.botlane;
      case PickPosition.support:
        return Role.support;
      default:
        return null;
    }
  }
}

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
