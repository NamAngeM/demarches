import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';

class ModernCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Color? backgroundColor;
  final double? elevation;
  final BorderRadius? borderRadius;
  final Gradient? gradient;
  final List<BoxShadow>? shadows;
  final VoidCallback? onTap;
  final bool isInteractive;

  const ModernCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.elevation,
    this.borderRadius,
    this.gradient,
    this.shadows,
    this.onTap,
    this.isInteractive = false,
  });

  @override
  Widget build(BuildContext context) {
    final cardWidget = Container(
      margin: margin ?? const EdgeInsets.all(AppSpacing.paddingLG),
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.surface,
        gradient: gradient,
        borderRadius: borderRadius ?? BorderRadius.circular(AppSpacing.radiusXL),
        boxShadow: shadows ?? _getDefaultShadows(),
      ),
      child: Padding(
        padding: padding ?? const EdgeInsets.all(AppSpacing.paddingXL),
        child: child,
      ),
    );

    if (isInteractive && onTap != null) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: borderRadius ?? BorderRadius.circular(AppSpacing.radiusXL),
          child: cardWidget,
        ),
      );
    }

    return cardWidget;
  }

  List<BoxShadow> _getDefaultShadows() {
    return [
      BoxShadow(
        color: AppColors.neutral200.withOpacity(0.1),
        blurRadius: 8,
        offset: const Offset(0, 2),
      ),
      BoxShadow(
        color: AppColors.neutral200.withOpacity(0.05),
        blurRadius: 16,
        offset: const Offset(0, 4),
      ),
    ];
  }
}

class GradientCard extends ModernCard {
  const GradientCard({
    super.key,
    required super.child,
    super.padding,
    super.margin,
    super.elevation,
    super.borderRadius,
    super.onTap,
    super.isInteractive,
    Gradient? gradient,
  }) : super(
          gradient: gradient ?? AppColors.cardGradient,
          backgroundColor: null,
        );
}

class ElevatedCard extends ModernCard {
  const ElevatedCard({
    super.key,
    required super.child,
    super.padding,
    super.margin,
    super.backgroundColor,
    super.borderRadius,
    super.onTap,
    super.isInteractive,
  }) : super(
          elevation: 4,
          shadows: _elevatedShadows,
        );

  static const List<BoxShadow> _elevatedShadows = [
    BoxShadow(
      color: Color(0x26A3A3A3), // AppColors.neutral200.withOpacity(0.15)
      blurRadius: 12,
      offset: Offset(0, 4),
    ),
    BoxShadow(
      color: Color(0x14A3A3A3), // AppColors.neutral200.withOpacity(0.08)
      blurRadius: 24,
      offset: Offset(0, 8),
    ),
  ];
}

class GlassCard extends ModernCard {
  const GlassCard({
    super.key,
    required super.child,
    super.padding,
    super.margin,
    super.borderRadius,
    super.onTap,
    super.isInteractive,
  }) : super(
          backgroundColor: const Color(0xCCFFFFFF), // AppColors.surface.withOpacity(0.8)
          shadows: _glassShadows,
        );

  static const List<BoxShadow> _glassShadows = [
    BoxShadow(
      color: Color(0x1AA3A3A3), // AppColors.neutral200.withOpacity(0.1)
      blurRadius: 20,
      offset: Offset(0, 8),
    ),
  ];
}
