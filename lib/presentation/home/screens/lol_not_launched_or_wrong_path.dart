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
    final appLocalizations = AppLocalizations.of(context);

    return Center(
      child: SebastianMessages(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(appLocalizations.homeMessageLolOffline),
              const SizedBox(height: 32),
              OutlinedButton(
                onPressed: onTapRetry,
                child: Text(appLocalizations.buttonRetry),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(appLocalizations.homeMessageLolOfflineResetPathMessage),
              const SizedBox(height: 32),
              OutlinedButton(
                onPressed: onTapChangePath,
                child: Text(appLocalizations.homeMessageLolOfflineResetPathButton),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
