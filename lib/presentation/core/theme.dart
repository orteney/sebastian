import 'package:flutter/material.dart';

ThemeData mainTheme() {
  final theme = ThemeData.from(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFFF22222),
      background: const Color(0xFF121212),
      brightness: Brightness.dark,
    ),
  );

  return theme.copyWith(
    progressIndicatorTheme: theme.progressIndicatorTheme.copyWith(
      color: const Color(0xFFF22222),
      linearTrackColor: theme.colorScheme.primary,
    ),
    snackBarTheme: theme.snackBarTheme.copyWith(
      behavior: SnackBarBehavior.floating,
    ),
    popupMenuTheme: theme.popupMenuTheme.copyWith(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
    ),

    switchTheme: theme.switchTheme.copyWith(
      thumbColor: MaterialStateProperty.resolveWith(
        (states) {
          if (states.contains(MaterialState.selected)) {
            return theme.colorScheme.primary;
          }
          return null;
        },
      ),
      trackColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return theme.colorScheme.primary.withAlpha(0x80);
        }
        return null;
      }),
    ),

    // Button themes
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),
    ),
  );
}
