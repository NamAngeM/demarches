import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../widgets/buttons/buttons.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/providers/auth_provider.dart';
import 'profile_setup_page.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);
    final isLoading = ref.watch(authLoadingProvider);
    final error = ref.watch(authErrorProvider);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.primary.withOpacity(0.8),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                const Spacer(),
                
                // Logo et titre
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(60),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.school,
                    size: 60,
                    color: Color(0xFF002395), // Bleu français
                  ),
                ),
                
                const SizedBox(height: 32),
                
                Text(
                  'Bienvenue dans\nDémarches App',
                  style: AppTextStyles.headline1.copyWith(
                    color: Colors.white,
                    fontSize: 32,
                  ),
                  textAlign: TextAlign.center,
                ),
                
                const SizedBox(height: 16),
                
                Text(
                  'Votre compagnon pour réussir vos démarches\nd\'étudiant étranger en France',
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                
                const Spacer(),
                
                // Boutons de connexion
                Column(
                  children: [
                    // Connexion avec Google
                    AppButton(
                      text: 'Continuer avec Google',
                      icon: Icons.login,
                      onPressed: isLoading ? null : () async {
                        await ref.read(authNotifierProvider.notifier).signInWithGoogle();
                      },
                      isFullWidth: true,
                      size: AppButtonSize.large,
                      type: AppButtonType.outline,
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Connexion anonyme
                    AppButton(
                      text: 'Continuer anonymement',
                      icon: Icons.person_outline,
                      onPressed: isLoading ? null : () async {
                        await ref.read(authNotifierProvider.notifier).signInAnonymously();
                      },
                      isFullWidth: true,
                      size: AppButtonSize.large,
                      type: AppButtonType.text,
                    ),
                  ],
                ),
                
                const SizedBox(height: 32),
                
                // Message d'erreur
                if (error != null)
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.red.withOpacity(0.3)),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.error_outline, color: Colors.red),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            error,
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: Colors.red,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () => ref.read(authNotifierProvider.notifier).clearError(),
                          icon: const Icon(Icons.close, color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                
                const SizedBox(height: 16),
                
                // Indicateur de chargement
                if (isLoading)
                  const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                
                const Spacer(),
                
                // Footer
                Text(
                  'En continuant, vous acceptez nos conditions\nd\'utilisation et notre politique de confidentialité',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: Colors.white.withOpacity(0.7),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
