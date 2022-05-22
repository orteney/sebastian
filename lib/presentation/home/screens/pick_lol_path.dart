import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class PickLolPathScreen extends StatelessWidget {
  const PickLolPathScreen({
    super.key,
    this.customMessage,
    required this.onPickedPath,
  });

  final String? customMessage;
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
            customMessage ?? 'Привет!\nМне нужно узнать, где у тебя находится клиент лиги...',
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: _onPickPathTap,
            child: const Text('ПОКАЗАТЬ'),
          ),
        ],
      ),
    );
  }
}
