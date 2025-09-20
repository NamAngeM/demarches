import 'package:flutter/material.dart';
import '../../core/theme/app_text_styles.dart';

enum AppButtonType {
  primary,
  secondary,
  outline,
  text,
  danger,
}

enum AppButtonSize {
  small,
  medium,
  large,
}

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final AppButtonType type;
  final AppButtonSize size;
  final bool isLoading;
  final bool isFullWidth;
  final IconData? icon;
  final Widget? child;

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.type = AppButtonType.primary,
    this.size = AppButtonSize.medium,
    this.isLoading = false,
    this.isFullWidth = false,
    this.icon,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    final buttonStyle = _getButtonStyle(context);
    final textStyle = _getTextStyle();
    final padding = _getPadding();
    final borderRadius = _getBorderRadius();

    Widget buttonChild = child ?? Row(
      mainAxisSize: isFullWidth ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (isLoading) ...[
          SizedBox(
            width: _getIconSize(),
            height: _getIconSize(),
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(
                _getTextColor(context),
              ),
            ),
          ),
          const SizedBox(width: 8),
        ] else if (icon != null) ...[
          Icon(icon, size: _getIconSize()),
          const SizedBox(width: 8),
        ],
        Text(text, style: textStyle),
      ],
    );

    return SizedBox(
      width: isFullWidth ? double.infinity : null,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonStyle.backgroundColor,
          foregroundColor: buttonStyle.foregroundColor,
          elevation: buttonStyle.elevation,
          padding: padding,
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius,
            side: buttonStyle.side,
          ),
        ),
        child: buttonChild,
      ),
    );
  }

  ButtonStyle _getButtonStyle(BuildContext context) {
    switch (type) {
      case AppButtonType.primary:
        return ButtonStyle(
          backgroundColor: WidgetStateProperty.all(const Color(0xFF002395)), // Bleu français
          foregroundColor: WidgetStateProperty.all(Colors.white),
          elevation: WidgetStateProperty.all(2),
          side: WidgetStateProperty.all(BorderSide.none),
        );
      case AppButtonType.secondary:
        return ButtonStyle(
          backgroundColor: WidgetStateProperty.all(const Color(0xFFED2939)), // Rouge français
          foregroundColor: WidgetStateProperty.all(Colors.white),
          elevation: WidgetStateProperty.all(2),
          side: WidgetStateProperty.all(BorderSide.none),
        );
      case AppButtonType.outline:
        return ButtonStyle(
          backgroundColor: WidgetStateProperty.all(Colors.transparent),
          foregroundColor: WidgetStateProperty.all(const Color(0xFF002395)), // Bleu français
          elevation: WidgetStateProperty.all(0),
          side: WidgetStateProperty.all(
            const BorderSide(color: Color(0xFF002395), width: 2),
          ),
        );
      case AppButtonType.text:
        return ButtonStyle(
          backgroundColor: WidgetStateProperty.all(Colors.transparent),
          foregroundColor: WidgetStateProperty.all(const Color(0xFF002395)), // Bleu français
          elevation: WidgetStateProperty.all(0),
          side: WidgetStateProperty.all(BorderSide.none),
        );
      case AppButtonType.danger:
        return ButtonStyle(
          backgroundColor: WidgetStateProperty.all(const Color(0xFFED2939)), // Rouge français
          foregroundColor: WidgetStateProperty.all(Colors.white),
          elevation: WidgetStateProperty.all(2),
          side: WidgetStateProperty.all(BorderSide.none),
        );
    }
  }

  TextStyle _getTextStyle() {
    switch (size) {
      case AppButtonSize.small:
        return AppTextStyles.buttonSmall;
      case AppButtonSize.medium:
        return AppTextStyles.buttonMedium;
      case AppButtonSize.large:
        return AppTextStyles.buttonLarge;
    }
  }

  EdgeInsets _getPadding() {
    switch (size) {
      case AppButtonSize.small:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 8);
      case AppButtonSize.medium:
        return const EdgeInsets.symmetric(horizontal: 24, vertical: 12);
      case AppButtonSize.large:
        return const EdgeInsets.symmetric(horizontal: 32, vertical: 16);
    }
  }

  BorderRadius _getBorderRadius() {
    switch (size) {
      case AppButtonSize.small:
        return BorderRadius.circular(6);
      case AppButtonSize.medium:
        return BorderRadius.circular(8);
      case AppButtonSize.large:
        return BorderRadius.circular(10);
    }
  }

  double _getIconSize() {
    switch (size) {
      case AppButtonSize.small:
        return 16;
      case AppButtonSize.medium:
        return 20;
      case AppButtonSize.large:
        return 24;
    }
  }

  Color _getTextColor(BuildContext context) {
    switch (type) {
      case AppButtonType.primary:
      case AppButtonType.secondary:
      case AppButtonType.danger:
        return Colors.white;
      case AppButtonType.outline:
      case AppButtonType.text:
        return const Color(0xFF002395); // Bleu français
    }
  }
}
