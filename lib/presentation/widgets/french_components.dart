import 'package:flutter/material.dart';
import '../../core/design/french_design_system.dart';

/// 🇫🇷 COMPOSANTS UI FRANÇAIS
/// Composants réutilisables selon le design system français
class FrenchComponents {
  
  // ===== BOUTONS FRANÇAIS =====
  static Widget primaryButton({
    required String text,
    required VoidCallback onPressed,
    IconData? icon,
    bool isLoading = false,
    bool isFullWidth = false,
  }) {
    return SizedBox(
      width: isFullWidth ? double.infinity : null,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          elevation: FrenchDesignSystem.elevation2,
          backgroundColor: FrenchDesignSystem.primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(
            horizontal: FrenchDesignSystem.space4,
            vertical: FrenchDesignSystem.space3,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(FrenchDesignSystem.radiusMedium),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: 20),
                    const SizedBox(width: FrenchDesignSystem.space2),
                  ],
                  Text(text, style: FrenchDesignSystem.labelLarge),
                ],
              ),
      ),
    );
  }
  
  static Widget secondaryButton({
    required String text,
    required VoidCallback onPressed,
    IconData? icon,
    bool isFullWidth = false,
  }) {
    return SizedBox(
      width: isFullWidth ? double.infinity : null,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: FrenchDesignSystem.primary,
          side: const BorderSide(color: FrenchDesignSystem.primary),
          padding: const EdgeInsets.symmetric(
            horizontal: FrenchDesignSystem.space4,
            vertical: FrenchDesignSystem.space3,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(FrenchDesignSystem.radiusMedium),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 20),
              const SizedBox(width: FrenchDesignSystem.space2),
            ],
            Text(text, style: FrenchDesignSystem.labelLarge),
          ],
        ),
      ),
    );
  }
  
  static Widget textButton({
    required String text,
    required VoidCallback onPressed,
    IconData? icon,
  }) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: FrenchDesignSystem.primary,
        padding: const EdgeInsets.symmetric(
          horizontal: FrenchDesignSystem.space4,
          vertical: FrenchDesignSystem.space2,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(FrenchDesignSystem.radiusMedium),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 20),
            const SizedBox(width: FrenchDesignSystem.space2),
          ],
          Text(text, style: FrenchDesignSystem.labelLarge),
        ],
      ),
    );
  }
  
  // ===== CARTES FRANÇAISES =====
  static Widget card({
    required Widget child,
    VoidCallback? onTap,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    Color? backgroundColor,
    double? elevation,
    BorderRadius? borderRadius,
  }) {
    Widget cardContent = Container(
      padding: padding ?? const EdgeInsets.all(FrenchDesignSystem.space4),
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white,
        borderRadius: borderRadius ?? BorderRadius.circular(FrenchDesignSystem.radiusLarge),
        boxShadow: elevation != null ? [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: elevation * 2,
            offset: Offset(0, elevation),
          ),
        ] : FrenchDesignSystem.shadowSmall,
      ),
      child: child,
    );
    
    if (onTap != null) {
      return Padding(
        padding: margin ?? EdgeInsets.zero,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: borderRadius ?? BorderRadius.circular(FrenchDesignSystem.radiusLarge),
            child: cardContent,
          ),
        ),
      );
    }
    
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: cardContent,
    );
  }
  
  static Widget guideCard({
    required String title,
    required String description,
    required String category,
    required VoidCallback onTap,
    String? difficulty,
    String? duration,
    bool isCompleted = false,
    bool isBookmarked = false,
    VoidCallback? onBookmark,
  }) {
    return card(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(FrenchDesignSystem.space2),
                decoration: BoxDecoration(
                  color: FrenchDesignSystem.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(FrenchDesignSystem.radiusSmall),
                ),
                child: Icon(
                  _getCategoryIcon(category),
                  color: FrenchDesignSystem.primary,
                  size: 24,
                ),
              ),
              const SizedBox(width: FrenchDesignSystem.space3),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: FrenchDesignSystem.titleMedium,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: FrenchDesignSystem.space1),
                    Text(
                      category,
                      style: FrenchDesignSystem.bodySmall.copyWith(
                        color: FrenchDesignSystem.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              if (onBookmark != null)
                IconButton(
                  onPressed: onBookmark,
                  icon: Icon(
                    isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                    color: isBookmarked ? FrenchDesignSystem.primary : FrenchDesignSystem.gray400,
                  ),
                ),
            ],
          ),
          const SizedBox(height: FrenchDesignSystem.space3),
          Text(
            description,
            style: FrenchDesignSystem.bodyMedium,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: FrenchDesignSystem.space3),
          Row(
            children: [
              if (difficulty != null) ...[
                _buildBadge(difficulty, FrenchDesignSystem.warning),
                const SizedBox(width: FrenchDesignSystem.space2),
              ],
              if (duration != null) ...[
                _buildBadge(duration, FrenchDesignSystem.info),
                const SizedBox(width: FrenchDesignSystem.space2),
              ],
              const Spacer(),
              if (isCompleted)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: FrenchDesignSystem.space2,
                    vertical: FrenchDesignSystem.space1,
                  ),
                  decoration: BoxDecoration(
                    color: FrenchDesignSystem.success.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(FrenchDesignSystem.radiusSmall),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: FrenchDesignSystem.success,
                        size: 16,
                      ),
                      const SizedBox(width: FrenchDesignSystem.space1),
                      Text(
                        'Terminé',
                        style: FrenchDesignSystem.labelSmall.copyWith(
                          color: FrenchDesignSystem.success,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
  
  // ===== CHAMPS DE SAISIE FRANÇAIS =====
  static Widget inputField({
    required String label,
    String? hintText,
    TextEditingController? controller,
    IconData? prefixIcon,
    IconData? suffixIcon,
    VoidCallback? onSuffixTap,
    bool obscureText = false,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    ValueChanged<String>? onChanged,
    int? maxLines,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: FrenchDesignSystem.labelMedium.copyWith(
            color: FrenchDesignSystem.gray700,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: FrenchDesignSystem.space2),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          validator: validator,
          onChanged: onChanged,
          maxLines: maxLines ?? 1,
          style: FrenchDesignSystem.bodyMedium,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: FrenchDesignSystem.bodyMedium.copyWith(
              color: FrenchDesignSystem.gray400,
            ),
            prefixIcon: prefixIcon != null
                ? Icon(prefixIcon, color: FrenchDesignSystem.gray400)
                : null,
            suffixIcon: suffixIcon != null
                ? IconButton(
                    onPressed: onSuffixTap,
                    icon: Icon(suffixIcon, color: FrenchDesignSystem.gray400),
                  )
                : null,
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: FrenchDesignSystem.space4,
              vertical: FrenchDesignSystem.space3,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(FrenchDesignSystem.radiusMedium),
              borderSide: const BorderSide(color: FrenchDesignSystem.gray200),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(FrenchDesignSystem.radiusMedium),
              borderSide: const BorderSide(color: FrenchDesignSystem.gray200),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(FrenchDesignSystem.radiusMedium),
              borderSide: const BorderSide(color: FrenchDesignSystem.primary, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(FrenchDesignSystem.radiusMedium),
              borderSide: const BorderSide(color: FrenchDesignSystem.error, width: 2),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(FrenchDesignSystem.radiusMedium),
              borderSide: const BorderSide(color: FrenchDesignSystem.error, width: 2),
            ),
          ),
        ),
      ],
    );
  }
  
  // ===== BADGES ET CHIPS FRANÇAIS =====
  static Widget badge({
    required String text,
    Color? backgroundColor,
    Color? textColor,
    IconData? icon,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: FrenchDesignSystem.space2,
        vertical: FrenchDesignSystem.space1,
      ),
      decoration: BoxDecoration(
        color: backgroundColor ?? FrenchDesignSystem.gray200,
        borderRadius: BorderRadius.circular(FrenchDesignSystem.radiusSmall),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 14, color: textColor ?? FrenchDesignSystem.gray700),
            const SizedBox(width: FrenchDesignSystem.space1),
          ],
          Text(
            text,
            style: FrenchDesignSystem.labelSmall.copyWith(
              color: textColor ?? FrenchDesignSystem.gray700,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
  
  static Widget chip({
    required String text,
    required VoidCallback onTap,
    bool isSelected = false,
    IconData? icon,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: FrenchDesignSystem.space3,
          vertical: FrenchDesignSystem.space2,
        ),
        decoration: BoxDecoration(
          color: isSelected ? FrenchDesignSystem.primary : Colors.white,
          borderRadius: BorderRadius.circular(FrenchDesignSystem.radiusFull),
          border: Border.all(
            color: isSelected ? FrenchDesignSystem.primary : FrenchDesignSystem.gray200,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: 16,
                color: isSelected ? Colors.white : FrenchDesignSystem.gray600,
              ),
              const SizedBox(width: FrenchDesignSystem.space1),
            ],
            Text(
              text,
              style: FrenchDesignSystem.labelMedium.copyWith(
                color: isSelected ? Colors.white : FrenchDesignSystem.gray700,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  // ===== INDICATEURS DE PROGRESSION =====
  static Widget progressIndicator({
    required double progress,
    String? label,
    Color? color,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label,
            style: FrenchDesignSystem.labelMedium,
          ),
          const SizedBox(height: FrenchDesignSystem.space2),
        ],
        Container(
          height: 8,
          decoration: BoxDecoration(
            color: FrenchDesignSystem.gray200,
            borderRadius: BorderRadius.circular(FrenchDesignSystem.radiusSmall),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: progress.clamp(0.0, 1.0),
            child: Container(
              decoration: BoxDecoration(
                color: color ?? FrenchDesignSystem.primary,
                borderRadius: BorderRadius.circular(FrenchDesignSystem.radiusSmall),
              ),
            ),
          ),
        ),
      ],
    );
  }
  
  // ===== MÉTHODES UTILITAIRES =====
  static IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'visa & titre de séjour':
        return Icons.credit_card;
      case 'logement':
        return Icons.home;
      case 'santé & assurance':
        return Icons.health_and_safety;
      case 'banque & finance':
        return Icons.account_balance;
      case 'études & université':
        return Icons.school;
      case 'transport':
        return Icons.directions_bus;
      case 'stages & emploi':
        return Icons.work;
      case 'vie quotidienne':
        return Icons.person;
      default:
        return Icons.help_outline;
    }
  }
  
  static Widget _buildBadge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: FrenchDesignSystem.space2,
        vertical: FrenchDesignSystem.space1,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(FrenchDesignSystem.radiusSmall),
      ),
      child: Text(
        text,
        style: FrenchDesignSystem.labelSmall.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
