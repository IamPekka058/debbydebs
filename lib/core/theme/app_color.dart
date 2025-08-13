import "package:flutter/material.dart";

class AppColor {
  // TODO(IamPekka058): Change the color scheme to match the app's branding
  static final ColorScheme colorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: const Color(0xFF00B8A9),
    onPrimary: Colors.white,
    primaryContainer: const Color(0xFF00BCD4),
    secondary: const Color(0xFF90E0D0),
    onSecondary: Colors.black,
    error: const Color(0xFFE63946),
    onError: Colors.white,
    surface: const Color(0xFFF6F9F9),
    onSurface: Colors.black,
    primaryFixed: Colors.grey[900],
    surfaceContainer: Colors.grey[800],
    secondaryContainer: const Color(0xFF3e7472),
  );
}
