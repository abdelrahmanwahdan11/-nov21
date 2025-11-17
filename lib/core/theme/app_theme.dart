import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/dummy_data.dart';

class AppTheme {
  static ThemeData light(Color primary) {
    final textTheme = GoogleFonts.plusJakartaSansTextTheme();
    final accent = lighten(primary);
    return ThemeData(
      useMaterial3: true,
      primaryColor: primary,
      colorScheme: ColorScheme.light(
        primary: primary,
        secondary: accent,
        surface: const Color(0xFFF6F1E7),
        background: const Color(0xFFF5EFE3),
      ),
      scaffoldBackgroundColor: const Color(0xFFF3EDE2),
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleTextStyle: textTheme.titleMedium?.copyWith(
          color: Colors.brown.shade700,
          fontWeight: FontWeight.w600,
        ),
      ),
      cardTheme: CardTheme(
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide(color: primary.withOpacity(.2)),
        ),
      ),
    );
  }

  static ThemeData dark(Color primary) {
    final textTheme = GoogleFonts.plusJakartaSansTextTheme().apply(
      bodyColor: Colors.white,
      displayColor: Colors.white,
    );
    final accent = lighten(primary);
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: primary,
      scaffoldBackgroundColor: const Color(0xFF0E1216),
      colorScheme: ColorScheme.dark(
        primary: primary,
        secondary: accent,
        background: const Color(0xFF0E1216),
        surface: const Color(0xFF1C2127),
      ),
      textTheme: textTheme,
      cardTheme: CardTheme(
        color: const Color(0xFF1F252C),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF1C2229),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide(color: primary.withOpacity(.2)),
        ),
      ),
    );
  }
}
