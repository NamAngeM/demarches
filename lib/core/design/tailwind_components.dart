import 'package:flutter/material.dart';
import 'tailwind_colors.dart';
import 'tailwind_spacing.dart';
import 'tailwind_typography.dart';

class TailwindComponents {
  // Boutons (comme Tailwind)
  static Widget button({
    required String text,
    required VoidCallback? onPressed,
    Color? backgroundColor,
    Color? textColor,
    double? fontSize,
    FontWeight? fontWeight,
    double? paddingHorizontal,
    double? paddingVertical,
    double? borderRadius,
    Widget? icon,
    bool isFullWidth = false,
  }) {
    return SizedBox(
      width: isFullWidth ? double.infinity : null,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? TailwindColors.primary,
          foregroundColor: textColor ?? Colors.white,
          elevation: 0,
          padding: EdgeInsets.symmetric(
            horizontal: paddingHorizontal ?? TailwindSpacing.p4,
            vertical: paddingVertical ?? TailwindSpacing.p3,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? TailwindSpacing.roundedLg),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              icon,
              const SizedBox(width: TailwindSpacing.p2),
            ],
            Text(
              text,
              style: TextStyle(
                fontSize: fontSize ?? TailwindTypography.textBase,
                fontWeight: fontWeight ?? TailwindTypography.fontMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  // Bouton secondaire
  static Widget buttonSecondary({
    required String text,
    required VoidCallback? onPressed,
    Widget? icon,
    bool isFullWidth = false,
  }) {
    return button(
      text: text,
      onPressed: onPressed,
      backgroundColor: TailwindColors.gray100,
      textColor: TailwindColors.gray700,
      icon: icon,
      isFullWidth: isFullWidth,
    );
  }
  
  // Bouton outline
  static Widget buttonOutline({
    required String text,
    required VoidCallback? onPressed,
    Color? borderColor,
    Color? textColor,
    Widget? icon,
    bool isFullWidth = false,
  }) {
    return SizedBox(
      width: isFullWidth ? double.infinity : null,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: textColor ?? TailwindColors.primary,
          side: BorderSide(
            color: borderColor ?? TailwindColors.primary,
            width: 1,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: TailwindSpacing.p4,
            vertical: TailwindSpacing.p3,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(TailwindSpacing.roundedLg),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              icon,
              const SizedBox(width: TailwindSpacing.p2),
            ],
            Text(
              text,
              style: const TextStyle(
                fontSize: TailwindTypography.textBase,
                fontWeight: TailwindTypography.fontMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  // Cartes (comme Tailwind)
  static Widget card({
    required Widget child,
    Color? backgroundColor,
    double? padding,
    double? margin,
    double? borderRadius,
    double? elevation,
    VoidCallback? onTap,
  }) {
    Widget cardWidget = Container(
      margin: EdgeInsets.all(margin ?? TailwindSpacing.p0),
      decoration: BoxDecoration(
        color: backgroundColor ?? TailwindColors.surface,
        borderRadius: BorderRadius.circular(borderRadius ?? TailwindSpacing.roundedXl),
        boxShadow: elevation != null ? [
          BoxShadow(
            color: TailwindColors.gray200.withOpacity(0.5),
            blurRadius: elevation,
            offset: const Offset(0, 2),
          ),
        ] : null,
      ),
      child: Padding(
        padding: EdgeInsets.all(padding ?? TailwindSpacing.p6),
        child: child,
      ),
    );
    
    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        child: cardWidget,
      );
    }
    
    return cardWidget;
  }
  
  // Input (comme Tailwind)
  static Widget input({
    String? hintText,
    String? labelText,
    TextEditingController? controller,
    bool obscureText = false,
    Widget? prefixIcon,
    Widget? suffixIcon,
    String? Function(String?)? validator,
    void Function(String)? onChanged,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: TailwindColors.gray50,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(TailwindSpacing.roundedLg),
          borderSide: const BorderSide(color: TailwindColors.gray300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(TailwindSpacing.roundedLg),
          borderSide: const BorderSide(color: TailwindColors.gray300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(TailwindSpacing.roundedLg),
          borderSide: const BorderSide(color: TailwindColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(TailwindSpacing.roundedLg),
          borderSide: const BorderSide(color: TailwindColors.error),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: TailwindSpacing.p4,
          vertical: TailwindSpacing.p3,
        ),
      ),
    );
  }
  
  // Badge (comme Tailwind)
  static Widget badge({
    required String text,
    Color? backgroundColor,
    Color? textColor,
    double? fontSize,
    double? paddingHorizontal,
    double? paddingVertical,
    double? borderRadius,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: paddingHorizontal ?? TailwindSpacing.p2,
        vertical: paddingVertical ?? TailwindSpacing.p1,
      ),
      decoration: BoxDecoration(
        color: backgroundColor ?? TailwindColors.primary,
        borderRadius: BorderRadius.circular(borderRadius ?? TailwindSpacing.roundedFull),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor ?? Colors.white,
          fontSize: fontSize ?? TailwindTypography.textXs,
          fontWeight: TailwindTypography.fontMedium,
        ),
      ),
    );
  }
  
  // Divider (comme Tailwind)
  static Widget divider({
    Color? color,
    double? thickness,
    double? height,
  }) {
    return Divider(
      color: color ?? TailwindColors.gray200,
      thickness: thickness ?? 1,
      height: height ?? TailwindSpacing.p4,
    );
  }
  
  // Spacer (comme Tailwind)
  static Widget spacer({double height = TailwindSpacing.p4}) {
    return SizedBox(height: height);
  }
  
  // Container avec padding (comme Tailwind)
  static Widget container({
    required Widget child,
    double? padding,
    double? margin,
    Color? backgroundColor,
    double? borderRadius,
    double? width,
    double? height,
  }) {
    return Container(
      width: width,
      height: height,
      margin: EdgeInsets.all(margin ?? TailwindSpacing.p0),
      padding: EdgeInsets.all(padding ?? TailwindSpacing.p0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius ?? TailwindSpacing.p0),
      ),
      child: child,
    );
  }
}
