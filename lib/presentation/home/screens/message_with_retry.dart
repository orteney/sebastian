import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:sebastian/presentation/core/widgets/sebastian_message.dart';

class MessageWithRetryScreen extends StatelessWidget {
  const MessageWithRetryScreen({
    super.key,
    required this.message,
    required this.onTapRetry,
  });

  final String message;
  final VoidCallback onTapRetry;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return Center(
      child: SebastianMessage(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(message),
            const SizedBox(height: 32),
            OutlinedButton(
              onPressed: onTapRetry,
              child: Text(appLocalizations.buttonRetry),
            ),
          ],
        ),
      ),
    );
  }
}
