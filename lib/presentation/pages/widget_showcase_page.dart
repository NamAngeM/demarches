import 'package:flutter/material.dart';
import '../widgets/buttons/buttons.dart';
import '../../core/theme/app_text_styles.dart';

class WidgetShowcasePage extends StatelessWidget {
  const WidgetShowcasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Galerie des Widgets'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Typography Section
            _buildSection(
              title: 'Typographie',
              children: [
                Text('Headline 1', style: AppTextStyles.headline1),
                const SizedBox(height: 8),
                Text('Headline 2', style: AppTextStyles.headline2),
                const SizedBox(height: 8),
                Text('Headline 3', style: AppTextStyles.headline3),
                const SizedBox(height: 8),
                Text('Titre de section', style: AppTextStyles.sectionTitle),
                const SizedBox(height: 8),
                Text('Titre de carte', style: AppTextStyles.cardTitle),
                const SizedBox(height: 8),
                Text('Texte principal', style: AppTextStyles.bodyLarge),
                const SizedBox(height: 8),
                Text('Texte secondaire', style: AppTextStyles.bodyMedium),
                const SizedBox(height: 8),
                Text('Texte petit', style: AppTextStyles.bodySmall),
                const SizedBox(height: 8),
                Text('Texte d\'erreur', style: AppTextStyles.errorText),
                const SizedBox(height: 8),
                Text('Texte de succès', style: AppTextStyles.successText),
                const SizedBox(height: 8),
                Text('Texte d\'avertissement', style: AppTextStyles.warningText),
              ],
            ),
            
            const SizedBox(height: 32),
            
            // Buttons Section
            _buildSection(
              title: 'Boutons',
              children: [
                Text('Boutons principaux', style: AppTextStyles.cardTitle),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    AppButton(
                      text: 'Primaire',
                      onPressed: () {},
                    ),
                    AppButton(
                      text: 'Secondaire',
                      type: AppButtonType.secondary,
                      onPressed: () {},
                    ),
                    AppButton(
                      text: 'Contour',
                      type: AppButtonType.outline,
                      onPressed: () {},
                    ),
                    AppButton(
                      text: 'Texte',
                      type: AppButtonType.text,
                      onPressed: () {},
                    ),
                    AppButton(
                      text: 'Danger',
                      type: AppButtonType.danger,
                      onPressed: () {},
                    ),
                  ],
                ),
                
                const SizedBox(height: 24),
                Text('Tailles de boutons', style: AppTextStyles.cardTitle),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    AppButton(
                      text: 'Petit',
                      size: AppButtonSize.small,
                      onPressed: () {},
                    ),
                    AppButton(
                      text: 'Moyen',
                      size: AppButtonSize.medium,
                      onPressed: () {},
                    ),
                    AppButton(
                      text: 'Grand',
                      size: AppButtonSize.large,
                      onPressed: () {},
                    ),
                  ],
                ),
                
                const SizedBox(height: 24),
                Text('Boutons avec icônes', style: AppTextStyles.cardTitle),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    AppButton(
                      text: 'Avec icône',
                      icon: Icons.add,
                      onPressed: () {},
                    ),
                    AppButton(
                      text: 'Chargement',
                      isLoading: true,
                      onPressed: () {},
                    ),
                    AppButton(
                      text: 'Plein largeur',
                      isFullWidth: true,
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
            
            const SizedBox(height: 32),
            
            // Icon Buttons Section
            _buildSection(
              title: 'Boutons d\'icônes',
              children: [
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    AppIconButton(
                      icon: Icons.favorite,
                      onPressed: () {},
                      tooltip: 'Favoris',
                    ),
                    AppIconButton(
                      icon: Icons.share,
                      type: AppIconButtonType.secondary,
                      onPressed: () {},
                      tooltip: 'Partager',
                    ),
                    AppIconButton(
                      icon: Icons.edit,
                      type: AppIconButtonType.outline,
                      onPressed: () {},
                      tooltip: 'Modifier',
                    ),
                    AppIconButton(
                      icon: Icons.delete,
                      type: AppIconButtonType.danger,
                      onPressed: () {},
                      tooltip: 'Supprimer',
                    ),
                    AppIconButton(
                      icon: Icons.refresh,
                      type: AppIconButtonType.text,
                      onPressed: () {},
                      tooltip: 'Actualiser',
                    ),
                  ],
                ),
                
                const SizedBox(height: 24),
                Text('Tailles de boutons d\'icônes', style: AppTextStyles.cardTitle),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    AppIconButton(
                      icon: Icons.star,
                      size: AppIconButtonSize.small,
                      onPressed: () {},
                      tooltip: 'Petit',
                    ),
                    AppIconButton(
                      icon: Icons.star,
                      size: AppIconButtonSize.medium,
                      onPressed: () {},
                      tooltip: 'Moyen',
                    ),
                    AppIconButton(
                      icon: Icons.star,
                      size: AppIconButtonSize.large,
                      onPressed: () {},
                      tooltip: 'Grand',
                    ),
                  ],
                ),
              ],
            ),
            
            const SizedBox(height: 32),
            
            // FAB Section
            _buildSection(
              title: 'Boutons flottants',
              children: [
                Text('Types de FAB', style: AppTextStyles.cardTitle),
                const SizedBox(height: 16),
                Row(
                  children: [
                    AppFab(
                      onPressed: () {},
                      icon: Icons.add,
                    ),
                    const SizedBox(width: 16),
                    AppFab(
                      type: AppFabType.secondary,
                      onPressed: () {},
                      icon: Icons.edit,
                    ),
                    const SizedBox(width: 16),
                    AppFab(
                      type: AppFabType.extended,
                      onPressed: () {},
                      icon: Icons.add,
                      label: 'Ajouter',
                    ),
                  ],
                ),
              ],
            ),
            
            const SizedBox(height: 32),
            
            // Status Text Section
            _buildSection(
              title: 'Textes de statut',
              children: [
                Wrap(
                  spacing: 16,
                  runSpacing: 8,
                  children: [
                    Text('En attente', style: AppTextStyles.statusPending),
                    Text('En cours', style: AppTextStyles.statusInProgress),
                    Text('Terminé', style: AppTextStyles.statusCompleted),
                    Text('Annulé', style: AppTextStyles.statusCancelled),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyles.headline3),
        const SizedBox(height: 16),
        ...children,
      ],
    );
  }
}
