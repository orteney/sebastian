import 'package:flutter/material.dart';

class UnknownBlocState extends StatelessWidget {
  const UnknownBlocState({super.key, required this.blocState});

  final Object blocState;

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Error: Unknown bloc state = ${blocState.runtimeType}'));
  }
}
