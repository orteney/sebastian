import 'package:flutter/material.dart';

import 'package:sebastian/presentation/core/widgets/icons/sebastian_logo.dart';

class SebastianMessage extends StatelessWidget {
  const SebastianMessage({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SebastianLogo(flip: true),
          const SizedBox(width: 16),
          Flexible(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: DefaultTextStyle(
                  style: Theme.of(context).textTheme.titleLarge!,
                  textAlign: TextAlign.start,
                  child: child,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
