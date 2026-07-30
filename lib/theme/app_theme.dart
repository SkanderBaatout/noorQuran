import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Système de design de l'app.
///
/// Palette inspirée des manuscrits islamiques : fond ivoire / nuit profonde,
/// vert émeraude comme couleur de marque, laiton doré comme accent rare.
/// Typo : "Amiri" (serif à résonance calligraphique) pour les titres,
/// "Poppins" (géométrique, claire) pour le corps de texte.
class AppColors {
  // --- Clair ---
  static const ivory = Color(0xFFFAF6EE);
  static const emerald = Color(0xFF0F5C51);
  static const emeraldDeep = Color(0xFF0A3F38);
  static const brass = Color(0xFFC89B3C);
  static const ink = Color(0xFF1C2321);
  static const sage = Color(0xFFE7EFE9);

  // --- Sombre ---
  static const night = Color(0xFF0B1615);
  static const nightCard = Color(0xFF142523);
  static const emeraldLight = Color(0xFF3FA88D);
  static const brassLight = Color(0xFFD4AF61);
  static const offWhite = Color(0xFFEDEDE7);
}

class AppTheme {
  static ThemeData light() {
    final base = ThemeData(
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
        primary: AppColors.emerald,
        onPrimary: Colors.white,
        secondary: AppColors.brass,
        onSecondary: AppColors.ink,
        surface: Colors.white,
        onSurface: AppColors.ink,
      ),
      scaffoldBackgroundColor: AppColors.ivory,
      useMaterial3: true,
    );
    return _applyTypography(base, bodyColor: AppColors.ink);
  }

  static ThemeData dark() {
    final base = ThemeData(
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.emeraldLight,
        onPrimary: AppColors.night,
        secondary: AppColors.brassLight,
        onSecondary: AppColors.night,
        surface: AppColors.nightCard,
        onSurface: AppColors.offWhite,
      ),
      scaffoldBackgroundColor: AppColors.night,
      useMaterial3: true,
    );
    return _applyTypography(base, bodyColor: AppColors.offWhite);
  }

  static ThemeData _applyTypography(ThemeData base, {required Color bodyColor}) {
    final display = GoogleFonts.amiriTextTheme(base.textTheme);
    final body = GoogleFonts.poppinsTextTheme(base.textTheme);

    return base.copyWith(
      textTheme: body.copyWith(
        headlineLarge: display.headlineLarge?.copyWith(color: bodyColor, fontWeight: FontWeight.w700),
        headlineMedium: display.headlineMedium?.copyWith(color: bodyColor, fontWeight: FontWeight.w700),
        titleLarge: display.titleLarge?.copyWith(color: bodyColor, fontWeight: FontWeight.w600),
        bodyLarge: body.bodyLarge?.copyWith(color: bodyColor),
        bodyMedium: body.bodyMedium?.copyWith(color: bodyColor),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: base.scaffoldBackgroundColor,
        foregroundColor: bodyColor,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: display.titleLarge?.copyWith(
          color: bodyColor,
          fontWeight: FontWeight.w700,
          fontSize: 22,
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: base.brightness == Brightness.light ? AppColors.sage : AppColors.nightCard,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: base.scaffoldBackgroundColor,
        indicatorColor: base.colorScheme.primary.withValues(alpha: 0.18),
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: base.colorScheme.primary,
          foregroundColor: base.colorScheme.onPrimary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        ),
      ),
    );
  }
}
