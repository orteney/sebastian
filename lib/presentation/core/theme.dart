import 'package:flutter/material.dart';

ThemeData mainTheme() {
  final theme = ThemeData.from(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.red,
      brightness: Brightness.dark,
    ),
  );

  return theme.copyWith(
    progressIndicatorTheme: theme.progressIndicatorTheme.copyWith(
      color: Colors.red,
      linearTrackColor: theme.colorScheme.primary,
    ),
  );
}
