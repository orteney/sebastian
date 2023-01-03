import 'package:flutter/material.dart';

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
    return SebastianMessage(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(message),
          const SizedBox(height: 32),
          OutlinedButton(
            onPressed: onTapRetry,
            child: const Text('ПОВТОРИТЬ'),
          ),
        ],
      ),
    );
  }
}
