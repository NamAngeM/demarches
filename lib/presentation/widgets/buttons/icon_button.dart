import 'package:flutter/material.dart';
import '../../core/theme/app_text_styles.dart';

enum AppIconButtonType {
  primary,
  secondary,
  outline,
  text,
  danger,
}

enum AppIconButtonSize {
  small,
  medium,
  large,
}

class AppIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final AppIconButtonType type;
  final AppIconButtonSize size;
  final String? tooltip;
  final bool isLoading;

  const AppIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.type = AppIconButtonType.primary,
    this.size = AppIconButtonSize.medium,
    this.tooltip,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final buttonStyle = _getButtonStyle(context);
    final iconSize = _getIconSize();
    final padding = _getPadding();
    final borderRadius = _getBorderRadius();

    Widget button = Container(
      decoration: BoxDecoration(
        color: buttonStyle.backgroundColor,
        borderRadius: borderRadius,
        border: buttonStyle.side != null
            ? Border.all(
                color: buttonStyle.side!.color,
                width: buttonStyle.side!.width,
              )
            : null,
        boxShadow: buttonStyle.elevation! > 0
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: buttonStyle.elevation!,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isLoading ? null : onPressed,
          borderRadius: borderRadius,
          child: Container(
            padding: padding,
            child: isLoading
                ? SizedBox(
                    width: iconSize,
                    height: iconSize,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        _getIconColor(context),
                      ),
                    ),
                  )
                : Icon(
                    icon,
                    size: iconSize,
                    color: _getIconColor(context),
                  ),
          ),
        ),
      ),
    );

    if (tooltip != null) {
      return Tooltip(
        message: tooltip!,
        child: button,
      );
    }

    return button;
  }

  ButtonStyle _getButtonStyle(BuildContext context) {
    switch (type) {
      case AppIconButtonType.primary:
        return ButtonStyle(
          backgroundColor: WidgetStateProperty.all(const Color(0xFF002395)), // Bleu français
          elevation: WidgetStateProperty.all(2),
          side: WidgetStateProperty.all(BorderSide.none),
        );
      case AppIconButtonType.secondary:
        return ButtonStyle(
          backgroundColor: WidgetStateProperty.all(const Color(0xFFED2939)), // Rouge français
          elevation: WidgetStateProperty.all(2),
          side: WidgetStateProperty.all(BorderSide.none),
        );
      case AppIconButtonType.outline:
        return ButtonStyle(
          backgroundColor: WidgetStateProperty.all(Colors.transparent),
          elevation: WidgetStateProperty.all(0),
          side: WidgetStateProperty.all(
            const BorderSide(color: Color(0xFF002395), width: 2),
          ),
        );
      case AppIconButtonType.text:
        return ButtonStyle(
          backgroundColor: WidgetStateProperty.all(Colors.transparent),
          elevation: WidgetStateProperty.all(0),
          side: WidgetStateProperty.all(BorderSide.none),
        );
      case AppIconButtonType.danger:
        return ButtonStyle(
          backgroundColor: WidgetStateProperty.all(const Color(0xFFED2939)), // Rouge français
          elevation: WidgetStateProperty.all(2),
          side: WidgetStateProperty.all(BorderSide.none),
        );
    }
  }

  double _getIconSize() {
    switch (size) {
      case AppIconButtonSize.small:
        return 16;
      case AppIconButtonSize.medium:
        return 20;
      case AppIconButtonSize.large:
        return 24;
    }
  }

  EdgeInsets _getPadding() {
    switch (size) {
      case AppIconButtonSize.small:
        return const EdgeInsets.all(8);
      case AppIconButtonSize.medium:
        return const EdgeInsets.all(12);
      case AppIconButtonSize.large:
        return const EdgeInsets.all(16);
    }
  }

  BorderRadius _getBorderRadius() {
    switch (size) {
      case AppIconButtonSize.small:
        return BorderRadius.circular(6);
      case AppIconButtonSize.medium:
        return BorderRadius.circular(8);
      case AppIconButtonSize.large:
        return BorderRadius.circular(10);
    }
  }

  Color _getIconColor(BuildContext context) {
    switch (type) {
      case AppIconButtonType.primary:
      case AppIconButtonType.secondary:
      case AppIconButtonType.danger:
        return Colors.white;
      case AppIconButtonType.outline:
      case AppIconButtonType.text:
        return const Color(0xFF002395); // Bleu français
    }
  }
}
