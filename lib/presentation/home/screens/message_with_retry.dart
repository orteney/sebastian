import 'package:flutter/material.dart';

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
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            message,
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: onTapRetry,
            child: const Text('ПОВТОРИТЬ'),
          ),
        ],
      ),
    );
  }
}
