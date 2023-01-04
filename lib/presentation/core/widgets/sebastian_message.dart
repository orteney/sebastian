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
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const SebastianLogo(size: Size.square(75), flip: true),
            const SizedBox(width: 16),
            Flexible(
              child: Card(
                margin: const EdgeInsets.only(bottom: 32),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
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
      ),
    );
  }
}
