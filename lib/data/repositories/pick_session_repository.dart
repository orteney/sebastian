import 'package:champmastery/data/lcu.dart';
import 'package:champmastery/data/models/pick_session.dart';

class PickSessionRepository {
  final LCU _lcu;

  PickSessionRepository(this._lcu);

  Stream<PickSession?> observePickSession() {
    return _lcu.subscribeToChampSelectEvent().map(
      (eventMessage) {
        if (eventMessage == null) return null;

        if (eventMessage['eventType'] == 'Delete') return null;

        final data = eventMessage['data'];
        if (data == null) return null;

        return PickSession.fromMap(data);
      },
    );
  }
}
