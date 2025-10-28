import 'package:flutter/material.dart';

/// Centralized app theme and custom ThemeExtension carrying gradients and
/// card decorations so components don't need to re-declare visuals.
class AppTheme {
  static const Color scaffoldColor = Color(0xFF000000);
  static const Color primary = Color(0xFF18C2E8); // neon cyan-ish
  static const Color accent = Color(0xFF3CE5D8);
  static const Color cardDark = Color(0xFF0F1113);
  // More visible background gradient (subtle cool-blue tint)
  static LinearGradient get backgroundGradient => const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF081B35),Color(0xFF000000)],
    stops: [0.0, 1.0],
  );

  // Card gradient with a faint cyan tint at top-left to create a visible
  // transition similar to the provided design image.
  static LinearGradient get cardGradient => const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0x1A2BE8F0), Color(0xFF0B0D10)],
    stops: [0.0, 1.0],
  );

  static ThemeData get themeData {
    final base = ThemeData.dark();
    return base.copyWith(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: scaffoldColor,
      colorScheme: ColorScheme.dark(
        primary: primary,
        secondary: accent,
        background: scaffoldColor,
        surface: cardDark,
      ),
      textTheme: base.textTheme.apply(
        bodyColor: Colors.white,
        displayColor: Colors.white,
      ),
      // Card visuals are provided via the ThemeExtension below and via
      // `AppCard` helper so we avoid SDK-specific CardTheme typing issues.
      extensions: <ThemeExtension<dynamic>>[
        AppExtras(
          backgroundGradient: backgroundGradient,
          cardGradient: cardGradient,
          accentColor: primary,
          glowColor: primary.withOpacity(0.30),
        ),
      ],
    );
  }
}

/// Small ThemeExtension to carry gradients and extra colors.
class AppExtras extends ThemeExtension<AppExtras> {
  final LinearGradient backgroundGradient;
  final LinearGradient cardGradient;
  final Color accentColor;
  final Color glowColor;

  const AppExtras({
    required this.backgroundGradient,
    required this.cardGradient,
    required this.accentColor,
    required this.glowColor,
  });

  @override
  ThemeExtension<AppExtras> copyWith({
    LinearGradient? backgroundGradient,
    LinearGradient? cardGradient,
    Color? accentColor,
    Color? glowColor,
  }) {
    return AppExtras(
      backgroundGradient: backgroundGradient ?? this.backgroundGradient,
      cardGradient: cardGradient ?? this.cardGradient,
      accentColor: accentColor ?? this.accentColor,
      glowColor: glowColor ?? this.glowColor,
    );
  }

  @override
  ThemeExtension<AppExtras> lerp(ThemeExtension<AppExtras>? other, double t) {
    if (other is! AppExtras) return this;
    return AppExtras(
      backgroundGradient: LinearGradient.lerp(
        backgroundGradient,
        other.backgroundGradient,
        t,
      )!,
      cardGradient: LinearGradient.lerp(cardGradient, other.cardGradient, t)!,
      accentColor: Color.lerp(accentColor, other.accentColor, t)!,
      glowColor: Color.lerp(glowColor, other.glowColor, t)!,
    );
  }
}

/// Helper to obtain the extension more ergonomically
AppExtras appExtras(BuildContext context) =>
    Theme.of(context).extension<AppExtras>()!;
