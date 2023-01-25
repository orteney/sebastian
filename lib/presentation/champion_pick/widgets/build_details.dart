import 'package:flutter/material.dart';

import 'package:sebastian/data/models/lcu_image.dart';
import 'package:sebastian/domain/builds/build_info.dart';
import 'package:sebastian/presentation/core/widgets/blurry_container.dart';

class BuildDetails extends StatelessWidget {
  const BuildDetails({
    super.key,
    required this.championBuild,
    required this.runesImages,
    required this.itemImages,
    required this.summonerSpellImages,
    this.singleColumn = false,
    required this.color,
  });

  final BuildInfo championBuild;
  final Map<int, LcuImage> runesImages;
  final Map<int, LcuImage> itemImages;
  final Map<int, LcuImage> summonerSpellImages;
  final bool singleColumn;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return BlurryContainer(
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: singleColumn
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _Runes(runes: championBuild.runes, runesImages: runesImages),
                      const SizedBox(width: 32),
                      _SummonerSpells(spells: championBuild.summonerSpells, summonerSpellImages: summonerSpellImages),
                    ],
                  ),
                  const SizedBox(height: 32),
                  _SkillOrder(
                    skillPath: championBuild.skillPath,
                    skillOrder: championBuild.skillOrder,
                  ),
                  const SizedBox(height: 32),
                  _Items(itemBuild: championBuild.itemBuild, itemImages: itemImages),
                ],
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _Runes(runes: championBuild.runes, runesImages: runesImages),
                            const SizedBox(width: 32),
                            _SummonerSpells(
                                spells: championBuild.summonerSpells, summonerSpellImages: summonerSpellImages),
                          ],
                        ),
                        const SizedBox(height: 32),
                        _SkillOrder(
                          skillPath: championBuild.skillPath,
                          skillOrder: championBuild.skillOrder,
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: _Items(itemBuild: championBuild.itemBuild, itemImages: itemImages),
                  )
                ],
              ),
      ),
    );
  }
}

class _Runes extends StatelessWidget {
  const _Runes({
    required this.runes,
    required this.runesImages,
  });

  final Runes runes;
  final Map<int, LcuImage> runesImages;

  Image _getImage(int itemId) {
    final lcuImage = runesImages[itemId]!;

    return Image.network(
      lcuImage.url,
      headers: lcuImage.headers,
      height: 40,
      width: 40,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Руны', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: runes.primary.map(_getImage).toList(),
            ),
            const SizedBox(width: 8),
            Column(
              children: runes.sub.map(_getImage).toList(),
            ),
            const SizedBox(width: 8),
            Column(
              children: runes.stat.map(_getImage).toList(),
            ),
          ],
        ),
      ],
    );
  }
}

class _SummonerSpells extends StatelessWidget {
  const _SummonerSpells({
    required this.spells,
    required this.summonerSpellImages,
  });

  final List<int> spells;
  final Map<int, LcuImage> summonerSpellImages;

  Image _getImage(LcuImage lcuImage) {
    return Image.network(
      lcuImage.url,
      headers: lcuImage.headers,
      height: 40,
      width: 40,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Самонерки', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 12),
        Row(
          children: spells.map((e) => _getImage(summonerSpellImages[e]!)).toList(),
        ),
      ],
    );
  }
}

class _Items extends StatelessWidget {
  const _Items({
    required this.itemBuild,
    required this.itemImages,
  });

  final ItemBuild itemBuild;
  final Map<int, LcuImage> itemImages;

  Widget _getImage(int itemId) {
    final lcuImage = itemImages[itemId];

    if (lcuImage == null) {
      return const SizedBox(
        height: 30,
        width: 30,
        child: Icon(Icons.image_not_supported_outlined),
      );
    }

    return Image.network(
      lcuImage.url,
      headers: lcuImage.headers,
      height: 30,
      width: 30,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Предметы', style: Theme.of(context).textTheme.titleMedium),
        const Padding(
          padding: EdgeInsets.only(top: 12, bottom: 8),
          child: Text('Стартовая сборка'),
        ),
        Wrap(
          children: itemBuild.startBuild.map(_getImage).toList(),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 12, bottom: 8),
          child: Text('Основная сборка'),
        ),
        Wrap(
          children: itemBuild.coreBuild.map(_getImage).toList(),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 12, bottom: 8),
          child: Text('Финальная сборка'),
        ),
        Wrap(
          children: itemBuild.finalBuild.map(_getImage).toList(),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 12, bottom: 8),
          child: Text('Ситуативные предметы'),
        ),
        Wrap(
          children: itemBuild.situationalItems.map(_getImage).toList(),
        ),
      ],
    );
  }
}

class _SkillOrder extends StatelessWidget {
  const _SkillOrder({
    required this.skillPath,
    required this.skillOrder,
  });

  final List<int>? skillPath;
  final List<int>? skillOrder;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Заклинания', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        Row(
          children: List.generate(18, (index) {
            final skillIndex = skillPath?[index];

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Column(
                children: [
                  Text(
                    '${index + 1}',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  const SizedBox(height: 4),
                  _SkillContainer(skillKey: 'Q', selected: skillIndex == 1),
                  const SizedBox(height: 4),
                  _SkillContainer(skillKey: 'W', selected: skillIndex == 2),
                  const SizedBox(height: 4),
                  _SkillContainer(skillKey: 'E', selected: skillIndex == 3),
                  const SizedBox(height: 4),
                  _SkillContainer(skillKey: 'R', selected: skillIndex == 4),
                ],
              ),
            );
          }),
        ),
      ],
    );
  }
}

class _SkillContainer extends StatelessWidget {
  const _SkillContainer({
    required this.skillKey,
    required this.selected,
  });

  final String skillKey;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 18,
      width: 18,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        color: Color(0xFF151515),
      ),
      child: selected
          ? Center(
              child: Text(
                skillKey,
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                textHeightBehavior: const TextHeightBehavior(applyHeightToFirstAscent: false),
              ),
            )
          : null,
    );
  }
}
