import 'package:flutter/material.dart';

import 'package:sebastian/presentation/core/colors.dart';

ThemeData mainTheme() {
  final colorScheme = ColorScheme.fromSeed(
    seedColor: SebastianColors.primary,
    brightness: Brightness.dark,
  );

  final bool isDark = colorScheme.brightness == Brightness.dark;

  // For surfaces that use primary color in light themes and surface color in dark
  final Color primarySurfaceColor = isDark ? colorScheme.surface : colorScheme.primary;
  final Color onPrimarySurfaceColor = isDark ? colorScheme.onSurface : colorScheme.onPrimary;

  return ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
    brightness: colorScheme.brightness,
    primaryColor: primarySurfaceColor,
    canvasColor: colorScheme.surface,
    scaffoldBackgroundColor: colorScheme.surfaceContainerLowest,
    cardColor: colorScheme.surface,
    dividerColor: colorScheme.onSurface.withOpacity(0.12),
    dialogBackgroundColor: colorScheme.surface,
    indicatorColor: onPrimarySurfaceColor,
    applyElevationOverlayColor: isDark,

    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: SebastianColors.primary,
      linearTrackColor: colorScheme.primary,
    ),
    snackBarTheme: const SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
    ),
    popupMenuTheme: const PopupMenuThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith(
        (states) {
          if (states.contains(WidgetState.selected)) {
            return colorScheme.primary;
          }
          return null;
        },
      ),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return colorScheme.primary.withAlpha(0x80);
        }
        return null;
      }),
    ),
    listTileTheme: const ListTileThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
    ),

    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
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
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),
    ),
  );
}
