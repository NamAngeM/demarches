import 'package:flutter/material.dart';
import 'tailwind_colors.dart';

class TailwindTypography {
  // 🇫🇷 TYPOGRAPHIE FRANCE - Échelle officielle
  // Display (Titres principaux)
  static const double displayLargeSize = 57.0;    // Headlines principales
  static const double displayMediumSize = 45.0;   // Titres sections
  static const double displaySmallSize = 36.0;    // Sous-titres
  
  // Headline (Titres)
  static const double headlineLargeSize = 32.0;   // Titres cartes
  static const double headlineMediumSize = 28.0;  // Titres guides
  static const double headlineSmallSize = 24.0;   // Titres widgets
  
  // Title (Titres moyens)
  static const double titleLargeSize = 22.0;      // AppBar titles
  static const double titleMediumSize = 16.0;     // Card titles
  static const double titleSmallSize = 14.0;      // Labels
  
  // Body (Texte principal)
  static const double bodyLargeSize = 16.0;       // Texte principal
  static const double bodyMediumSize = 14.0;      // Descriptions
  static const double bodySmallSize = 12.0;       // Captions
  
  // Label (Boutons et éléments)
  static const double labelLargeSize = 14.0;      // Boutons
  static const double labelMediumSize = 12.0;     // Chips
  static const double labelSmallSize = 11.0;      // Helper text
  
  // Poids de police (comme Tailwind)
  static const FontWeight fontThin = FontWeight.w100;
  static const FontWeight fontExtralight = FontWeight.w200;
  static const FontWeight fontLight = FontWeight.w300;
  static const FontWeight fontNormal = FontWeight.w400;
  static const FontWeight fontMedium = FontWeight.w500;
  static const FontWeight fontSemibold = FontWeight.w600;
  static const FontWeight fontBold = FontWeight.w700;
  static const FontWeight fontExtrabold = FontWeight.w800;
  static const FontWeight fontBlack = FontWeight.w900;
  
  // Hauteurs de ligne (comme Tailwind)
  static const double leadingNone = 1.0;
  static const double leadingTight = 1.25;
  static const double leadingSnug = 1.375;
  static const double leadingNormal = 1.5;
  static const double leadingRelaxed = 1.625;
  static const double leadingLoose = 2.0;
  
  // Espacement des lettres (comme Tailwind)
  static const double trackingTighter = -0.05;
  static const double trackingTight = -0.025;
  static const double trackingNormal = 0.0;
  static const double trackingWide = 0.025;
  static const double trackingWider = 0.05;
  static const double trackingWidest = 0.1;
  
  // 🇫🇷 STYLES DE TEXTE FRANCE
  // Display styles
  static const TextStyle displayLarge = TextStyle(
    fontSize: displayLargeSize,
    fontWeight: fontBold,
    height: leadingTight,
    letterSpacing: trackingTight,
    color: TailwindColors.gray900,
  );
  
  static const TextStyle displayMedium = TextStyle(
    fontSize: displayMediumSize,
    fontWeight: fontBold,
    height: leadingTight,
    letterSpacing: trackingTight,
    color: TailwindColors.gray900,
  );
  
  static const TextStyle displaySmall = TextStyle(
    fontSize: displaySmallSize,
    fontWeight: fontBold,
    height: leadingTight,
    letterSpacing: trackingTight,
    color: TailwindColors.gray900,
  );
  
  // Headline styles
  static const TextStyle headlineLarge = TextStyle(
    fontSize: headlineLargeSize,
    fontWeight: fontBold,
    height: leadingTight,
    letterSpacing: trackingTight,
    color: TailwindColors.gray900,
  );
  
  static const TextStyle headlineMedium = TextStyle(
    fontSize: headlineMediumSize,
    fontWeight: fontBold,
    height: leadingTight,
    letterSpacing: trackingTight,
    color: TailwindColors.gray900,
  );
  
  static const TextStyle headlineSmall = TextStyle(
    fontSize: headlineSmallSize,
    fontWeight: fontBold,
    height: leadingTight,
    letterSpacing: trackingTight,
    color: TailwindColors.gray900,
  );
  
  // Title styles
  static const TextStyle titleLarge = TextStyle(
    fontSize: titleLargeSize,
    fontWeight: fontSemibold,
    height: leadingTight,
    letterSpacing: trackingTight,
    color: TailwindColors.gray900,
  );
  
  static const TextStyle titleMedium = TextStyle(
    fontSize: titleMediumSize,
    fontWeight: fontSemibold,
    height: leadingTight,
    letterSpacing: trackingTight,
    color: TailwindColors.gray900,
  );
  
  static const TextStyle titleSmall = TextStyle(
    fontSize: titleSmallSize,
    fontWeight: fontSemibold,
    height: leadingTight,
    letterSpacing: trackingTight,
    color: TailwindColors.gray900,
  );
  
  // Body styles
  static const TextStyle bodyLarge = TextStyle(
    fontSize: bodyLargeSize,
    fontWeight: fontNormal,
    height: leadingNormal,
    letterSpacing: trackingNormal,
    color: TailwindColors.gray700,
  );
  
  static const TextStyle bodyMedium = TextStyle(
    fontSize: bodyMediumSize,
    fontWeight: fontNormal,
    height: leadingNormal,
    letterSpacing: trackingNormal,
    color: TailwindColors.gray700,
  );
  
  static const TextStyle bodySmall = TextStyle(
    fontSize: bodySmallSize,
    fontWeight: fontNormal,
    height: leadingNormal,
    letterSpacing: trackingNormal,
    color: TailwindColors.gray600,
  );
  
  // Label styles
  static const TextStyle labelLarge = TextStyle(
    fontSize: labelLargeSize,
    fontWeight: fontMedium,
    height: leadingTight,
    letterSpacing: trackingWide,
    color: TailwindColors.gray900,
  );
  
  static const TextStyle labelMedium = TextStyle(
    fontSize: labelMediumSize,
    fontWeight: fontMedium,
    height: leadingTight,
    letterSpacing: trackingWide,
    color: TailwindColors.gray700,
  );
  
  static const TextStyle labelSmall = TextStyle(
    fontSize: labelSmallSize,
    fontWeight: fontMedium,
    height: leadingTight,
    letterSpacing: trackingWide,
    color: TailwindColors.gray600,
  );
  
  // 🇫🇷 STYLES AVEC COULEURS FRANCE
  static TextStyle textPrimary = bodyLarge.copyWith(color: TailwindColors.primary);
  static TextStyle textSecondary = bodyLarge.copyWith(color: TailwindColors.secondary);
  static TextStyle textSuccess = bodyLarge.copyWith(color: TailwindColors.success);
  static TextStyle textWarning = bodyLarge.copyWith(color: TailwindColors.warning);
  static TextStyle textError = bodyLarge.copyWith(color: TailwindColors.error);
  static TextStyle textMuted = bodyLarge.copyWith(color: TailwindColors.gray500);
  static TextStyle textWhite = bodyLarge.copyWith(color: Colors.white);
  
  // 🇫🇷 ALIAS POUR COMPATIBILITÉ
  static const TextStyle h1 = displayLarge;
  static const TextStyle h2 = displayMedium;
  static const TextStyle h3 = displaySmall;
  static const TextStyle h4 = headlineLarge;
  static const TextStyle h5 = headlineMedium;
  static const TextStyle h6 = headlineSmall;
}
