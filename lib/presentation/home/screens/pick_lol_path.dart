import 'package:flutter/material.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:sebastian/presentation/core/widgets/sebastian_message.dart';

class PickLolPathScreen extends StatelessWidget {
  const PickLolPathScreen({
    super.key,
    required this.onPickedPath,
    this.onRetryTap,
    this.pickedWrongPath = false,
  });

  final bool pickedWrongPath;
  final VoidCallback? onRetryTap;
  final void Function(String) onPickedPath;

  Future<void> _onPickPathTap(String dialogTitle) async {
    final result = await FilePicker.platform.getDirectoryPath(
      lockParentWindow: true,
      dialogTitle: dialogTitle,
    );

    if (result != null) {
      onPickedPath(result);
    } else {
      // User canceled the picker
    }
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);

    return Center(
      child: SebastianMessage(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              !pickedWrongPath
                  ? appLocalizations.lolPathPickerMessageInitial
                  : appLocalizations.lolPathPickerMessageWrongPath,
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (!pickedWrongPath)
                  OutlinedButton(
                    onPressed: onRetryTap,
                    child: Text(appLocalizations.buttonRetry),
                  ),
                const SizedBox(width: 16),
                OutlinedButton(
                  onPressed: () => _onPickPathTap(appLocalizations.lolPathPickerDialogTitle),
                  child: Text(appLocalizations.lolPathPickerPickPathButton),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
