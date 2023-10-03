import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:sebastian/data/lcu/lcu.dart';
import 'package:sebastian/di/di.dart';

class SecretMenuDialog extends StatelessWidget {
  const SecretMenuDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);

    return AlertDialog(
      title: Text(appLocalizations.secretMenuTitle),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: const Icon(Icons.person),
            title: Text(appLocalizations.secretMenuResetIconTitle),
            subtitle: Text(appLocalizations.secretMenuResetIconSubtitle),
            onTap: () => getIt<LCU>().service.resetAccountIcon(),
          ),
          ListTile(
            leading: const Icon(Icons.delete_rounded),
            title: Text(appLocalizations.secretMenuCleanBannerTitle),
            subtitle: Text(appLocalizations.secretMenuClearBannerSubtitle),
            onTap: () => getIt<LCU>().service.removeChallengesTokens(),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            MaterialLocalizations.of(context).closeButtonLabel.toUpperCase(),
          ),
        )
      ],
    );
  }
}
