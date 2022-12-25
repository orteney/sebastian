import 'package:sebastian/data/blitz/models/blitz_queue.dart';

enum ChampionTierTableColumn {
  role(true),
  champion(true),
  tier(false),
  winRate(false),
  banRate(false),
  pickRate(false),
  games(false);

  final bool initialSortAccending;

  const ChampionTierTableColumn(this.initialSortAccending);
}

enum AvailableQueue {
  aram(BlitzQueue.howlingAbyssAram),
  rankedSolo5X5(BlitzQueue.rankedSolo5X5);

  final BlitzQueue queue;

  const AvailableQueue(this.queue);
}
