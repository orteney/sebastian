import 'dart:async';

import 'package:flutter/material.dart';

class SnackbarPresenter extends StatefulWidget {
  const SnackbarPresenter({
    super.key,
    required this.messageStream,
    required this.child,
  });

  final Stream<String> messageStream;
  final Widget child;

  @override
  State<SnackbarPresenter> createState() => _SnackbarPresenterState();
}

class _SnackbarPresenterState extends State<SnackbarPresenter> {
  StreamSubscription<String>? _subscription;

  @override
  void initState() {
    super.initState();
    _subscribe();
  }

  @override
  void didUpdateWidget(covariant SnackbarPresenter oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.messageStream != widget.messageStream) {
      _unsubscribe();
      _subscribe();
    }
  }

  @override
  void dispose() {
    _unsubscribe();
    super.dispose();
  }

  void _subscribe() {
    _subscription = widget.messageStream.listen(_onMessage);
  }

  void _unsubscribe() {
    if (_subscription != null) {
      _subscription!.cancel();
      _subscription = null;
    }
  }

  void _onMessage(String message) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
