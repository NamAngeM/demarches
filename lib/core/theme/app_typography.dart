import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTypography {
  // Familles de polices
  static const String primaryFont = 'Inter';
  static const String secondaryFont = 'Poppins';
  static const String monoFont = 'JetBrains Mono';
  
  // Styles de texte - Hiérarchie claire
  static const TextStyle displayLarge = TextStyle(
    fontFamily: primaryFont,
    fontSize: 32,
    fontWeight: FontWeight.w800,
    letterSpacing: -0.5,
    height: 1.2,
    color: AppColors.neutral900,
  );
  
  static const TextStyle displayMedium = TextStyle(
    fontFamily: primaryFont,
    fontSize: 28,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.25,
    height: 1.25,
    color: AppColors.neutral900,
  );
  
  static const TextStyle displaySmall = TextStyle(
    fontFamily: primaryFont,
    fontSize: 24,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    height: 1.3,
    color: AppColors.neutral900,
  );
  
  static const TextStyle headlineLarge = TextStyle(
    fontFamily: primaryFont,
    fontSize: 22,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    height: 1.3,
    color: AppColors.neutral800,
  );
  
  static const TextStyle headlineMedium = TextStyle(
    fontFamily: primaryFont,
    fontSize: 20,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    height: 1.4,
    color: AppColors.neutral800,
  );
  
  static const TextStyle headlineSmall = TextStyle(
    fontFamily: primaryFont,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    height: 1.4,
    color: AppColors.neutral800,
  );
  
  static const TextStyle titleLarge = TextStyle(
    fontFamily: primaryFont,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    height: 1.5,
    color: AppColors.neutral700,
  );
  
  static const TextStyle titleMedium = TextStyle(
    fontFamily: primaryFont,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.1,
    height: 1.5,
    color: AppColors.neutral700,
  );
  
  static const TextStyle titleSmall = TextStyle(
    fontFamily: primaryFont,
    fontSize: 12,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.1,
    height: 1.5,
    color: AppColors.neutral600,
  );
  
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: primaryFont,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    height: 1.6,
    color: AppColors.neutral700,
  );
  
  static const TextStyle bodyMedium = TextStyle(
    fontFamily: primaryFont,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    height: 1.6,
    color: AppColors.neutral600,
  );
  
  static const TextStyle bodySmall = TextStyle(
    fontFamily: primaryFont,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    height: 1.6,
    color: AppColors.neutral500,
  );
  
  static const TextStyle labelLarge = TextStyle(
    fontFamily: primaryFont,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    height: 1.4,
    color: AppColors.neutral600,
  );
  
  static const TextStyle labelMedium = TextStyle(
    fontFamily: primaryFont,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    height: 1.4,
    color: AppColors.neutral500,
  );
  
  static const TextStyle labelSmall = TextStyle(
    fontFamily: primaryFont,
    fontSize: 10,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    height: 1.4,
    color: AppColors.neutral400,
  );
  
  // Styles spéciaux
  static const TextStyle button = TextStyle(
    fontFamily: primaryFont,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.1,
    height: 1.4,
  );
  
  static const TextStyle caption = TextStyle(
    fontFamily: primaryFont,
    fontSize: 11,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.1,
    height: 1.4,
    color: AppColors.neutral400,
  );
  
  static const TextStyle overline = TextStyle(
    fontFamily: primaryFont,
    fontSize: 10,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    height: 1.4,
    color: AppColors.neutral400,
  );
  
  // Styles avec couleurs
  static TextStyle primaryText = bodyLarge.copyWith(color: AppColors.primary);
  static TextStyle secondaryText = bodyLarge.copyWith(color: AppColors.secondary);
  static TextStyle successText = bodyLarge.copyWith(color: AppColors.success);
  static TextStyle warningText = bodyLarge.copyWith(color: AppColors.warning);
  static TextStyle errorText = bodyLarge.copyWith(color: AppColors.error);
  static TextStyle mutedText = bodyLarge.copyWith(color: AppColors.neutral500);
}
