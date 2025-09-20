import 'package:flutter/material.dart';

class TailwindColors {
  // 🇫🇷 COULEURS FRANCE - Palette officielle
  // Bleu France
  static const Color primary = Color(0xFF1565C0);       // Bleu France principal
  static const Color primaryLight = Color(0xFF1976D2);  // Bleu France clair
  static const Color primaryLighter = Color(0xFF1E88E5); // Bleu France plus clair
  static const Color primaryDark = Color(0xFF0D47A1);   // Bleu France foncé
  static const Color primaryDarker = Color(0xFF0A3D91); // Bleu France très foncé
  
  // Rouge France
  static const Color secondary = Color(0xFFD32F2F);     // Rouge France principal
  static const Color secondaryLight = Color(0xFFE53935); // Rouge France clair
  static const Color secondaryLighter = Color(0xFFF44336); // Rouge France plus clair
  static const Color secondaryDark = Color(0xFFB71C1C); // Rouge France foncé
  static const Color secondaryDarker = Color(0xFF8B0000); // Rouge France très foncé
  
  // Couleurs d'accent (France)
  static const Color accent = Color(0xFF4CAF50);        // Vert France
  static const Color accentLight = Color(0xFF66BB6A);   // Vert France clair
  static const Color accentDark = Color(0xFF388E3C);    // Vert France foncé
  
  // Couleurs de statut (Material Design)
  static const Color success = Color(0xFF4CAF50);       // Vert Material
  static const Color warning = Color(0xFFFF9800);       // Orange Material
  static const Color error = Color(0xFFF44336);         // Rouge Material
  static const Color info = Color(0xFF2196F3);          // Bleu Material
  
  // 🇫🇷 NEUTRAL - Grays France
  static const Color gray50 = Color(0xFFF5F5F5);        // Gris très clair
  static const Color gray100 = Color(0xFFE0E0E0);       // Gris clair
  static const Color gray200 = Color(0xFFBDBDBD);       // Gris moyen clair
  static const Color gray300 = Color(0xFF9E9E9E);       // Gris moyen
  static const Color gray400 = Color(0xFF757575);       // Gris moyen foncé
  static const Color gray500 = Color(0xFF616161);       // Gris foncé
  static const Color gray600 = Color(0xFF424242);       // Gris très foncé
  static const Color gray700 = Color(0xFF303030);       // Gris sombre
  static const Color gray800 = Color(0xFF212121);       // Gris très sombre
  static const Color gray900 = Color(0xFF121212);       // Gris noir
  
  // Couleurs de fond
  static const Color background = Color(0xFFFAFAFA);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF8FAFC);
  
  // 🇫🇷 DÉGRADÉS FRANCE
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primary, primaryLight, primaryLighter],
    stops: [0.0, 0.5, 1.0],
  );
  
  static const LinearGradient secondaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [secondary, secondaryLight, secondaryLighter],
    stops: [0.0, 0.5, 1.0],
  );
  
  static const LinearGradient franceGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primary, secondary],
    stops: [0.0, 1.0],
  );
  
  static const LinearGradient accentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [accent, accentLight],
  );
  
  // Dégradés de fond
  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFF8FAFC), Color(0xFFE2E8F0)],
  );
  
  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFFFFFF), Color(0xFFF8FAFC)],
  );
  
  // Couleurs avec opacité (comme Tailwind)
  static Color primaryWithOpacity(double opacity) => primary.withOpacity(opacity);
  static Color secondaryWithOpacity(double opacity) => secondary.withOpacity(opacity);
  static Color grayWithOpacity(double opacity) => gray500.withOpacity(opacity);
}
