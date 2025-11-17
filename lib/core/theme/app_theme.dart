import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData light(Color primary) {
    final base = ThemeData.light();
    return base.copyWith(
      primaryColor: primary,
      colorScheme: base.colorScheme.copyWith(primary: primary, secondary: const Color(0xFFC6D66B)),
      scaffoldBackgroundColor: const Color(0xFFF6F0E7),
      textTheme: GoogleFonts.plusJakartaSansTextTheme(base.textTheme),
      appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent, elevation: 0),
      cardTheme: CardTheme(color: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24))),
    );
  }

  static ThemeData dark(Color primary) {
    final base = ThemeData.dark();
    return base.copyWith(
      primaryColor: primary,
      colorScheme: base.colorScheme.copyWith(primary: primary, secondary: const Color(0xFF9EB45C)),
      scaffoldBackgroundColor: const Color(0xFF121212),
      textTheme: GoogleFonts.plusJakartaSansTextTheme(base.textTheme),
      cardTheme: CardTheme(color: const Color(0xFF1E1E1E), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24))),
    );
  }
}
