import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/theme/app_spacing.dart';

class ModernButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;
  final ModernButtonStyle style;
  final ModernButtonSize size;
  final bool isLoading;
  final bool isFullWidth;

  const ModernButton({
    super.key,
    required this.text,
    this.onPressed,
    this.icon,
    this.style = ModernButtonStyle.primary,
    this.size = ModernButtonSize.medium,
    this.isLoading = false,
    this.isFullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    final buttonStyle = _getButtonStyle();
    final buttonSize = _getButtonSize();
    
    Widget buttonChild = _buildButtonChild();
    
    if (isFullWidth) {
      buttonChild = SizedBox(
        width: double.infinity,
        child: buttonChild,
      );
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: buttonStyle,
        child: buttonChild,
      ),
    );
  }

  Widget _buildButtonChild() {
    if (isLoading) {
      return SizedBox(
        height: _getIconSize(),
        width: _getIconSize(),
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(
            _getTextColor(),
          ),
        ),
      );
    }

    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: _getIconSize()),
          const SizedBox(width: AppSpacing.paddingSM),
          Text(text, style: _getTextStyle()),
        ],
      );
    }

    return Text(text, style: _getTextStyle());
  }

  ButtonStyle _getButtonStyle() {
    switch (style) {
      case ModernButtonStyle.primary:
        return ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: _getPadding(),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_getBorderRadius()),
          ),
        );
      case ModernButtonStyle.secondary:
        return ElevatedButton.styleFrom(
          backgroundColor: AppColors.secondary,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: _getPadding(),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_getBorderRadius()),
          ),
        );
      case ModernButtonStyle.outline:
        return ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: AppColors.primary,
          elevation: 0,
          padding: _getPadding(),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_getBorderRadius()),
            side: const BorderSide(color: AppColors.primary, width: 2),
          ),
        );
      case ModernButtonStyle.ghost:
        return ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary.withOpacity(0.1),
          foregroundColor: AppColors.primary,
          elevation: 0,
          padding: _getPadding(),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_getBorderRadius()),
          ),
        );
    }
  }

  EdgeInsets _getPadding() {
    switch (size) {
      case ModernButtonSize.small:
        return const EdgeInsets.symmetric(
          horizontal: AppSpacing.paddingMD,
          vertical: AppSpacing.paddingSM,
        );
      case ModernButtonSize.medium:
        return const EdgeInsets.symmetric(
          horizontal: AppSpacing.paddingXL,
          vertical: AppSpacing.paddingMD,
        );
      case ModernButtonSize.large:
        return const EdgeInsets.symmetric(
          horizontal: AppSpacing.paddingXXL,
          vertical: AppSpacing.paddingLG,
        );
    }
  }

  double _getBorderRadius() {
    switch (size) {
      case ModernButtonSize.small:
        return AppSpacing.radiusMD;
      case ModernButtonSize.medium:
        return AppSpacing.radiusLG;
      case ModernButtonSize.large:
        return AppSpacing.radiusXL;
    }
  }

  TextStyle _getTextStyle() {
    switch (size) {
      case ModernButtonSize.small:
        return AppTypography.labelMedium;
      case ModernButtonSize.medium:
        return AppTypography.button;
      case ModernButtonSize.large:
        return AppTypography.titleMedium;
    }
  }

  double _getIconSize() {
    switch (size) {
      case ModernButtonSize.small:
        return 16;
      case ModernButtonSize.medium:
        return 20;
      case ModernButtonSize.large:
        return 24;
    }
  }

  Color _getTextColor() {
    switch (style) {
      case ModernButtonStyle.primary:
      case ModernButtonStyle.secondary:
        return Colors.white;
      case ModernButtonStyle.outline:
      case ModernButtonStyle.ghost:
        return AppColors.primary;
    }
  }

  ModernButtonSize _getButtonSize() => size;
}

enum ModernButtonStyle {
  primary,
  secondary,
  outline,
  ghost,
}

enum ModernButtonSize {
  small,
  medium,
  large,
}

class GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;
  final Gradient gradient;
  final ModernButtonSize size;
  final bool isLoading;
  final bool isFullWidth;

  const GradientButton({
    super.key,
    required this.text,
    this.onPressed,
    this.icon,
    this.gradient = AppColors.primaryGradient,
    this.size = ModernButtonSize.medium,
    this.isLoading = false,
    this.isFullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(_getBorderRadius()),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isLoading ? null : onPressed,
          borderRadius: BorderRadius.circular(_getBorderRadius()),
          child: Container(
            padding: _getPadding(),
            child: _buildButtonChild(),
          ),
        ),
      ),
    );
  }

  Widget _buildButtonChild() {
    if (isLoading) {
      return SizedBox(
        height: _getIconSize(),
        width: _getIconSize(),
        child: const CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    }

    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: _getIconSize(), color: Colors.white),
          const SizedBox(width: AppSpacing.paddingSM),
          Text(text, style: _getTextStyle().copyWith(color: Colors.white)),
        ],
      );
    }

    return Text(text, style: _getTextStyle().copyWith(color: Colors.white));
  }

  EdgeInsets _getPadding() {
    switch (size) {
      case ModernButtonSize.small:
        return const EdgeInsets.symmetric(
          horizontal: AppSpacing.paddingMD,
          vertical: AppSpacing.paddingSM,
        );
      case ModernButtonSize.medium:
        return const EdgeInsets.symmetric(
          horizontal: AppSpacing.paddingXL,
          vertical: AppSpacing.paddingMD,
        );
      case ModernButtonSize.large:
        return const EdgeInsets.symmetric(
          horizontal: AppSpacing.paddingXXL,
          vertical: AppSpacing.paddingLG,
        );
    }
  }

  double _getBorderRadius() {
    switch (size) {
      case ModernButtonSize.small:
        return AppSpacing.radiusMD;
      case ModernButtonSize.medium:
        return AppSpacing.radiusLG;
      case ModernButtonSize.large:
        return AppSpacing.radiusXL;
    }
  }

  TextStyle _getTextStyle() {
    switch (size) {
      case ModernButtonSize.small:
        return AppTypography.labelMedium;
      case ModernButtonSize.medium:
        return AppTypography.button;
      case ModernButtonSize.large:
        return AppTypography.titleMedium;
    }
  }

  double _getIconSize() {
    switch (size) {
      case ModernButtonSize.small:
        return 16;
      case ModernButtonSize.medium:
        return 20;
      case ModernButtonSize.large:
        return 24;
    }
  }
}
