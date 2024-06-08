import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:sebastian/presentation/core/widgets/sebastian_message.dart';

class LolNotLaunchedOrWrongPathProvidedScreen extends StatelessWidget {
  const LolNotLaunchedOrWrongPathProvidedScreen({
    super.key,
    required this.message,
    required this.onTapRetry,
    this.onTapChangePath,
  });

  final String message;
  final VoidCallback onTapRetry;
  final VoidCallback? onTapChangePath;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);

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
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: onTapChangePath,
              child: Text(appLocalizations.buttonChangePath),
            ),
          ],
        ),
      ),
    );
  }
}
