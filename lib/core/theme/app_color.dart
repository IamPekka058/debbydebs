import "package:flutter/material.dart";

class AppColor {
  // TODO(IamPekka058): Change the color scheme to match the app's branding
  static final ColorScheme colorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: const Color(0xFF62b4b1),
    onPrimary: const Color(0xFF212121),
    primaryContainer: const Color(0xFF00BCD4),
    secondary: const Color(0xFF00BCD4),
    onSecondary: Colors.white,
    error: Colors.red,
    onError: Colors.white,
    surface: Colors.white,
    primaryFixed: Colors.grey[900],
    onSurface: Colors.black,
    surfaceContainer: Colors.grey[800],
    secondaryContainer: const Color(0xFF3e7472),
  );
}
