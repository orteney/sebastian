import 'package:sebastian/data/blitz/models/blitz_queue.dart';

enum ChampionTierTableColumn {
  role,
  champion,
  tier,
  winRate,
  banRate,
  pickRate,
  games,
}

enum AvailableQueue {
  aram(BlitzQueue.howlingAbyssAram),
  rankedSolo5X5(BlitzQueue.rankedSolo5X5);

  final BlitzQueue queue;

  const AvailableQueue(this.queue);
}
