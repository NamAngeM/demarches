import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/buttons/buttons.dart';
import '../../core/theme/app_text_styles.dart';
import 'widget_showcase_page.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Démarches App'),
        actions: [
          AppIconButton(
            icon: Icons.notifications_outlined,
            onPressed: () {
              // TODO: Implémenter les notifications
            },
            tooltip: 'Notifications',
          ),
          const SizedBox(width: 8),
          AppIconButton(
            icon: Icons.palette_outlined,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const WidgetShowcasePage(),
                ),
              );
            },
            tooltip: 'Galerie des widgets',
          ),
          const SizedBox(width: 8),
          AppIconButton(
            icon: Icons.settings_outlined,
            onPressed: () {
              // TODO: Implémenter les paramètres
            },
            tooltip: 'Paramètres',
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bienvenue dans Démarches App',
              style: AppTextStyles.headline2,
            ),
            const SizedBox(height: 8),
            Text(
              'Votre application de gestion des démarches administratives',
              style: AppTextStyles.bodyLarge,
            ),
            const SizedBox(height: 32),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Actions rapides',
                      style: AppTextStyles.cardTitle,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: AppButton(
                            text: 'Nouvelle démarche',
                            icon: Icons.add_circle_outline,
                            onPressed: () {
                              // TODO: Implémenter l'ajout d'une nouvelle démarche
                            },
                            isFullWidth: true,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: AppButton(
                            text: 'Mes démarches',
                            icon: Icons.list_alt,
                            type: AppButtonType.outline,
                            onPressed: () {
                              // TODO: Implémenter la liste des démarches
                            },
                            isFullWidth: true,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: AppButton(
                            text: 'Statistiques',
                            icon: Icons.analytics_outlined,
                            type: AppButtonType.text,
                            onPressed: () {
                              // TODO: Implémenter les statistiques
                            },
                            isFullWidth: true,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: AppButton(
                            text: 'Aide',
                            icon: Icons.help_outline,
                            type: AppButtonType.text,
                            onPressed: () {
                              // TODO: Implémenter l'aide
                            },
                            isFullWidth: true,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            Center(
              child: Text(
                'Développé avec ❤️ en France',
                style: AppTextStyles.bodySmall,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: AppFab(
        onPressed: () {
          // TODO: Implémenter l'ajout d'une nouvelle démarche
        },
        label: 'Ajouter',
        icon: Icons.add,
      ),
    );
  }
}
