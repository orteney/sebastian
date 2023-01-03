import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:sebastian/presentation/core/widgets/sebastian_message.dart';

class PickLolPathScreen extends StatelessWidget {
  const PickLolPathScreen({
    super.key,
    this.customMessage,
    this.onRetryTap,
    required this.onPickedPath,
  });

  final String? customMessage;
  final VoidCallback? onRetryTap;
  final void Function(String) onPickedPath;

  Future<void> _onPickPathTap() async {
    final result = await FilePicker.platform.getDirectoryPath(
      lockParentWindow: true,
      dialogTitle: 'Выбери папку «League of Legends»',
    );

    if (result != null) {
      onPickedPath(result);
    } else {
      // User canceled the picker
    }
  }

  @override
  Widget build(BuildContext context) {
    return SebastianMessage(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            customMessage ??
                'Привет, я Себастьян!\n\nМне не удалось узнать где у тебя находится клиент лиги...\n\nЕсли она не запущена, то запусти её и попробуй "повторить".\nЕсли всё равно не получается, тогда покажи мне путь до папки с файлом "LeagueClient.exe"',
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (customMessage == null)
                OutlinedButton(
                  onPressed: onRetryTap,
                  child: const Text('ПОВТОРИТЬ'),
                ),
              const SizedBox(width: 16),
              OutlinedButton(
                onPressed: _onPickPathTap,
                child: const Text('ПОКАЗАТЬ ПУТЬ'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
