import 'package:sebastian/data/senpai/models/senpai_build.dart';
import 'package:sebastian/domain/builds/build_info.dart';

class SenpaiBuildMapper {
  BuildInfo call(SenpaiBuildInfo senpaiBuildInfo) {
    return BuildInfo(
      keystoneId: senpaiBuildInfo.keystoneId,
      winRate: senpaiBuildInfo.winRate.roundToDouble(),
      numMatches: senpaiBuildInfo.numMatches,
      itemBuild: ItemBuild(
        startBuild: senpaiBuildInfo.build.startBuild,
        coreBuild: senpaiBuildInfo.build.coreBuild,
        finalBuild: senpaiBuildInfo.build.finalBuild,
        buildPath: senpaiBuildInfo.build.buildPath,
        situationalItems: senpaiBuildInfo.build.situationalItems,
      ),
      summonerSpells: senpaiBuildInfo.build.spells,
      runes: Runes(
        primaryPath: senpaiBuildInfo.build.runes.primaryPath,
        subPath: senpaiBuildInfo.build.runes.subPath,
        primary: senpaiBuildInfo.build.runes.tree.primary,
        sub: senpaiBuildInfo.build.runes.tree.sub,
        stat: senpaiBuildInfo.build.runes.tree.stat,
      ),
      skillOrder: senpaiBuildInfo.build.skillOrder,
      skillPath: senpaiBuildInfo.build.skillPath,
    );
  }
}
