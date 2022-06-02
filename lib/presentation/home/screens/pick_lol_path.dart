import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

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
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            customMessage ??
                'Привет!\n\nМне не удалось узнать где у тебя находится клиент лиги...\n\nЕсли она не запущена, то запусти и нажми "повторить".\nЕсли не получается, то, покажи мне путь до папки с файлом "LeagueClient.exe"',
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (customMessage == null)
                ElevatedButton(
                  onPressed: onRetryTap,
                  child: const Text('ПОВТОРИТЬ'),
                ),
              const SizedBox(width: 16),
              ElevatedButton(
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
