import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart' show CompositeSubscription, PublishSubject;

export 'package:rxdart/rxdart.dart' show AddToCompositeSubscriptionExtension;

/// Creates a Publish Subject Stream for Error's messages
/// and push [Bloc.onError] errors to that stream
mixin ErrorStream<Event, State> on Bloc<Event, State> {
  final _errorSubject = PublishSubject<String>();
  Stream<String> get errorMessageStream => _errorSubject.stream;

  @override
  void onError(Object error, StackTrace stackTrace) {
    _errorSubject.add(error.toString());
    super.onError(error, stackTrace);
  }

  @override
  Future<void> close() {
    _errorSubject.close();
    return super.close();
  }
}

mixin StreamSubscriptions<Event, State> on Bloc<Event, State> {
  final subscriptions = CompositeSubscription();

  @override
  Future<void> close() {
    subscriptions.dispose();
    return super.close();
  }
}
