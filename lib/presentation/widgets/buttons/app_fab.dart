import 'package:flutter/material.dart';
import '../../core/theme/app_text_styles.dart';

enum AppFabType {
  primary,
  secondary,
  extended,
}

class AppFab extends StatelessWidget {
  final VoidCallback? onPressed;
  final AppFabType type;
  final IconData? icon;
  final String? label;
  final bool isLoading;

  const AppFab({
    super.key,
    this.onPressed,
    this.type = AppFabType.primary,
    this.icon,
    this.label,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case AppFabType.primary:
        return FloatingActionButton(
          onPressed: isLoading ? null : onPressed,
          backgroundColor: const Color(0xFF002395), // Bleu français
          foregroundColor: Colors.white,
          child: isLoading
              ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : Icon(icon ?? Icons.add),
        );
      
      case AppFabType.secondary:
        return FloatingActionButton(
          onPressed: isLoading ? null : onPressed,
          backgroundColor: const Color(0xFFED2939), // Rouge français
          foregroundColor: Colors.white,
          child: isLoading
              ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : Icon(icon ?? Icons.add),
        );
      
      case AppFabType.extended:
        return FloatingActionButton.extended(
          onPressed: isLoading ? null : onPressed,
          backgroundColor: const Color(0xFF002395), // Bleu français
          foregroundColor: Colors.white,
          icon: isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : Icon(icon ?? Icons.add),
          label: Text(
            label ?? 'Ajouter',
            style: AppTextStyles.buttonMedium,
          ),
        );
    }
  }
}
