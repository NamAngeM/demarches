import 'package:flutter/material.dart';
import 'tailwind_colors.dart';
import 'tailwind_typography.dart';
import 'tailwind_spacing.dart';

/// 🇫🇷 SYSTÈME DE DESIGN FRANÇAIS
/// Implémentation complète du design system Student Guide France
class FrenchDesignSystem {
  // ===== COULEURS FRANCE =====
  static const Color primary = Color(0xFF1565C0);       // Bleu France
  static const Color primaryLight = Color(0xFF1976D2);  // Bleu France clair
  static const Color primaryLighter = Color(0xFF1E88E5); // Bleu France plus clair
  static const Color primaryDark = Color(0xFF0D47A1);   // Bleu France foncé
  
  static const Color secondary = Color(0xFFD32F2F);     // Rouge France
  static const Color secondaryLight = Color(0xFFE53935); // Rouge France clair
  static const Color secondaryLighter = Color(0xFFF44336); // Rouge France plus clair
  static const Color secondaryDark = Color(0xFFB71C1C); // Rouge France foncé
  
  static const Color accent = Color(0xFF4CAF50);        // Vert France
  static const Color accentLight = Color(0xFF66BB6A);   // Vert France clair
  static const Color accentDark = Color(0xFF388E3C);    // Vert France foncé
  
  // Gris France
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
  
  // Couleurs de statut
  static const Color success = Color(0xFF4CAF50);       // Vert Material
  static const Color warning = Color(0xFFFF9800);       // Orange Material
  static const Color error = Color(0xFFF44336);         // Rouge Material
  static const Color info = Color(0xFF2196F3);          // Bleu Material
  
  // ===== TYPOGRAPHIE FRANCE =====
  // Display styles
  static const TextStyle displayLarge = TextStyle(
    fontSize: 57.0,
    fontWeight: FontWeight.bold,
    height: 1.2,
    letterSpacing: -0.5,
    color: gray900,
  );
  
  static const TextStyle displayMedium = TextStyle(
    fontSize: 45.0,
    fontWeight: FontWeight.bold,
    height: 1.2,
    letterSpacing: -0.5,
    color: gray900,
  );
  
  static const TextStyle displaySmall = TextStyle(
    fontSize: 36.0,
    fontWeight: FontWeight.bold,
    height: 1.2,
    letterSpacing: -0.5,
    color: gray900,
  );
  
  // Headline styles
  static const TextStyle headlineLarge = TextStyle(
    fontSize: 32.0,
    fontWeight: FontWeight.bold,
    height: 1.2,
    letterSpacing: -0.25,
    color: gray900,
  );
  
  static const TextStyle headlineMedium = TextStyle(
    fontSize: 28.0,
    fontWeight: FontWeight.bold,
    height: 1.2,
    letterSpacing: -0.25,
    color: gray900,
  );
  
  static const TextStyle headlineSmall = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
    height: 1.2,
    letterSpacing: -0.25,
    color: gray900,
  );
  
  // Title styles
  static const TextStyle titleLarge = TextStyle(
    fontSize: 22.0,
    fontWeight: FontWeight.w600,
    height: 1.2,
    letterSpacing: 0,
    color: gray900,
  );
  
  static const TextStyle titleMedium = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w600,
    height: 1.2,
    letterSpacing: 0,
    color: gray900,
  );
  
  static const TextStyle titleSmall = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w600,
    height: 1.2,
    letterSpacing: 0,
    color: gray900,
  );
  
  // Body styles
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.normal,
    height: 1.5,
    letterSpacing: 0,
    color: gray700,
  );
  
  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.normal,
    height: 1.5,
    letterSpacing: 0,
    color: gray700,
  );
  
  static const TextStyle bodySmall = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.normal,
    height: 1.5,
    letterSpacing: 0,
    color: gray600,
  );
  
  // Label styles
  static const TextStyle labelLarge = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    height: 1.2,
    letterSpacing: 0.1,
    color: gray900,
  );
  
  static const TextStyle labelMedium = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w500,
    height: 1.2,
    letterSpacing: 0.1,
    color: gray700,
  );
  
  static const TextStyle labelSmall = TextStyle(
    fontSize: 11.0,
    fontWeight: FontWeight.w500,
    height: 1.2,
    letterSpacing: 0.1,
    color: gray600,
  );
  
  // ===== ESPACEMENT FRANCE =====
  static const double space1 = 4.0;   // 4px
  static const double space2 = 8.0;   // 8px
  static const double space3 = 12.0;  // 12px
  static const double space4 = 16.0;  // 16px
  static const double space5 = 20.0;  // 20px
  static const double space6 = 24.0;  // 24px
  static const double space8 = 32.0;  // 32px
  static const double space10 = 40.0; // 40px
  static const double space12 = 48.0; // 48px
  static const double space16 = 64.0; // 64px
  
  // ===== RAYONS DE BORDURE =====
  static const double radiusSmall = 4.0;
  static const double radiusMedium = 8.0;
  static const double radiusLarge = 12.0;
  static const double radiusXLarge = 16.0;
  static const double radiusXXLarge = 24.0;
  static const double radiusFull = 9999.0;
  
  // ===== ÉLÉVATION FRANCE =====
  static const double elevation0 = 0.0;    // Level 0: flush
  static const double elevation1 = 1.0;    // Level 1: cards
  static const double elevation2 = 3.0;    // Level 2: buttons
  static const double elevation3 = 6.0;    // Level 3: modals
  static const double elevation4 = 8.0;    // Level 4: navigation
  static const double elevation5 = 12.0;   // Level 5: FAB
  
  // ===== OMBRES FRANCE =====
  static const List<BoxShadow> shadowSmall = [
    BoxShadow(
      color: Color(0x0A000000),
      blurRadius: 2,
      offset: Offset(0, 1),
    ),
  ];
  
  static const List<BoxShadow> shadowMedium = [
    BoxShadow(
      color: Color(0x1A000000),
      blurRadius: 4,
      offset: Offset(0, 2),
    ),
  ];
  
  static const List<BoxShadow> shadowLarge = [
    BoxShadow(
      color: Color(0x1A000000),
      blurRadius: 8,
      offset: Offset(0, 4),
    ),
  ];
  
  static const List<BoxShadow> shadowXLarge = [
    BoxShadow(
      color: Color(0x1A000000),
      blurRadius: 16,
      offset: Offset(0, 8),
    ),
  ];
  
  // ===== DÉGRADÉS FRANCE =====
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
  
  // ===== THÈME PRINCIPAL =====
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: false,
      colorScheme: const ColorScheme.light(
        primary: primary,
        onPrimary: Colors.white,
        secondary: secondary,
        onSecondary: Colors.white,
        surface: Colors.white,
        onSurface: gray800,
        background: gray50,
        onBackground: gray800,
        error: error,
        onError: Colors.white,
      ),
      scaffoldBackgroundColor: gray50,
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: elevation0,
        backgroundColor: Colors.transparent,
        foregroundColor: gray800,
        titleTextStyle: titleLarge,
      ),
      cardTheme: CardTheme(
        elevation: elevation1,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusLarge),
        ),
        shadowColor: Colors.black.withOpacity(0.1),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: elevation2,
          backgroundColor: primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: space4, vertical: space3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusMedium),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primary,
          padding: const EdgeInsets.symmetric(horizontal: space4, vertical: space2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusMedium),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primary,
          side: const BorderSide(color: primary),
          padding: const EdgeInsets.symmetric(horizontal: space4, vertical: space3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusMedium),
          ),
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: primary,
        unselectedItemColor: gray400,
        elevation: elevation4,
      ),
    );
  }
}
