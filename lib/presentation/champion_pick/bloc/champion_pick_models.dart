import 'dart:ui';

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

  static Role? fromPosition(String? position) {
    switch (position) {
      case 'top':
        return Role.toplane;
      case 'jungle':
        return Role.jungler;
      case 'middle':
        return Role.midlane;
      case 'bottom':
        return Role.botlane;
      case 'support':
        return Role.support;
      default:
        return null;
    }
  }
}

enum PerkStyle {
  precision(8000, Color(0xFF362A1B)),
  domination(8100, Color(0xFF35191E)),
  sorcery(8200, Color(0xFF1D1A2C)),
  inspiration(8300, Color(0xFF1F2E2F)),
  resolve(8400, Color(0xFF1F221A)),
  unknown(0, Color(0xFF363030));

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