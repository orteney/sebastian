import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:sebastian/presentation/core/widgets/sebastian_message.dart';

class LolNotLaunchedOrWrongPathProvidedScreen extends StatelessWidget {
  const LolNotLaunchedOrWrongPathProvidedScreen({
    super.key,
    required this.onTapRetry,
    this.onTapChangePath,
  });

  final VoidCallback onTapRetry;
  final VoidCallback? onTapChangePath;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appLocalizations = AppLocalizations.of(context);

    return Center(
      child: SebastianMessage(
        child: IntrinsicWidth(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(appLocalizations.homeMessageLolOffline),
              const SizedBox(height: 16),
              Text(
                appLocalizations.homeMessageLolOfflineResetPathMessage,
                style: theme.textTheme.bodyLarge,
              ),
              const SizedBox(height: 32),
              OverflowBar(
                alignment: MainAxisAlignment.end,
                spacing: 16,
                children: [
                  OutlinedButton(
                    onPressed: onTapChangePath,
                    child: Text(appLocalizations.homeMessageLolOfflineResetPathButton),
                  ),
                  FilledButton(
                    onPressed: onTapRetry,
                    child: Text(appLocalizations.buttonRetry),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
