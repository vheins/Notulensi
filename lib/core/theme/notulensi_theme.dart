import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Custom ThemeExtension for the Obsidian Archive design system.
class NotulensiColors extends ThemeExtension<NotulensiColors> {
  final Color primary;
  final Color background;
  final Color surface;
  final Color textHigh;
  final Color textLow;
  final Color error;
  final Color success;

  const NotulensiColors({
    required this.primary,
    required this.background,
    required this.surface,
    required this.textHigh,
    required this.textLow,
    required this.error,
    required this.success,
  });

  @override
  NotulensiColors copyWith({
    Color? primary,
    Color? background,
    Color? surface,
    Color? textHigh,
    Color? textLow,
    Color? error,
    Color? success,
  }) {
    return NotulensiColors(
      primary: primary ?? this.primary,
      background: background ?? this.background,
      surface: surface ?? this.surface,
      textHigh: textHigh ?? this.textHigh,
      textLow: textLow ?? this.textLow,
      error: error ?? this.error,
      success: success ?? this.success,
    );
  }

  @override
  NotulensiColors lerp(ThemeExtension<NotulensiColors>? other, double t) {
    if (other is! NotulensiColors) return this;
    return NotulensiColors(
      primary: Color.lerp(primary, other.primary, t)!,
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      textHigh: Color.lerp(textHigh, other.textHigh, t)!,
      textLow: Color.lerp(textLow, other.textLow, t)!,
      error: Color.lerp(error, other.error, t)!,
      success: Color.lerp(success, other.success, t)!,
    );
  }
}

class NotulensiTheme {
  static const darkColors = NotulensiColors(
    primary: Color(0xFF0A84FF),
    background: Color(0xFF000000),
    surface: Color(0xFF1C1C1E),
    textHigh: Color(0xFFFFFFFF),
    textLow: Color(0xFF8E8E93),
    error: Color(0xFFFF453A),
    success: Color(0xFF30D158),
  );

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: darkColors.background,
      primaryColor: darkColors.primary,
      colorScheme: ColorScheme.dark(
        primary: darkColors.primary,
        surface: darkColors.surface,
        error: darkColors.error,
        onPrimary: Colors.white,
        onSurface: darkColors.textHigh,
      ),
      textTheme: GoogleFonts.ibmPlexSansTextTheme().copyWith(
        displayLarge: GoogleFonts.spaceGrotesk(
          color: darkColors.textHigh,
          fontWeight: FontWeight.bold,
        ),
        headlineMedium: GoogleFonts.spaceGrotesk(
          color: darkColors.textHigh,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: GoogleFonts.ibmPlexSans(
          color: darkColors.textHigh,
        ),
        bodyMedium: GoogleFonts.ibmPlexSans(
          color: darkColors.textHigh,
        ),
        labelSmall: GoogleFonts.ibmPlexMono(
          color: darkColors.textLow,
        ),
      ),
      extensions: const [darkColors],
    );
  }
}
