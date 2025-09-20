import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/buttons/buttons.dart';
import '../../core/theme/app_text_styles.dart';
import '../../domain/entities/guide.dart';
import '../../data/datasources/guides_local_data.dart';
import 'guide_detail_page.dart';

class FeaturesDemoPage extends ConsumerStatefulWidget {
  const FeaturesDemoPage({super.key});

  @override
  ConsumerState<FeaturesDemoPage> createState() => _FeaturesDemoPageState();
}

class _FeaturesDemoPageState extends ConsumerState<FeaturesDemoPage> {
  List<Guide> _guides = [];

  @override
  void initState() {
    super.initState();
    _loadGuides();
  }

  void _loadGuides() {
    setState(() {
      _guides = GuidesLocalData.getAllGuides();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Démo des Fonctionnalités'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nouvelles Fonctionnalités',
              style: AppTextStyles.headline2,
            ),
            const SizedBox(height: 8),
            Text(
              'Découvrez les fonctionnalités avancées des guides',
              style: AppTextStyles.bodyLarge,
            ),
            const SizedBox(height: 32),
            
            // Fonctionnalités principales
            _buildFeatureCard(
              icon: Icons.check_box,
              title: 'Checkboxes pour les étapes',
              description: 'Marquez chaque étape comme terminée avec des checkboxes interactives',
              features: [
                'Checkboxes visuelles pour chaque étape',
                'Marquage automatique des étapes terminées',
                'Interface visuelle claire (vert pour terminé)',
                'Sauvegarde locale de la progression',
              ],
            ),
            
            _buildFeatureCard(
              icon: Icons.track_changes,
              title: 'Suivi de progression',
              description: 'Visualisez votre progression avec une barre de progression et des statistiques',
              features: [
                'Barre de progression en temps réel',
                'Pourcentage de completion',
                'Compteur d\'étapes terminées',
                'Sauvegarde persistante de la progression',
              ],
            ),
            
            _buildFeatureCard(
              icon: Icons.check_circle,
              title: 'Marquer comme terminé',
              description: 'Bouton pour marquer l\'ensemble du guide comme terminé',
              features: [
                'Bouton "Marquer comme terminé"',
                'Notification de succès',
                'Option de partage automatique',
                'Interface adaptative selon l\'état',
              ],
            ),
            
            _buildFeatureCard(
              icon: Icons.share,
              title: 'Partage natif',
              description: 'Partagez les guides, étapes et progression via l\'API native',
              features: [
                'Partage du guide complet',
                'Partage d\'une étape spécifique',
                'Partage de la progression',
                'Intégration avec les apps de partage du système',
              ],
            ),
            
            const SizedBox(height: 32),
            
            // Guides de démonstration
            Text(
              'Guides de Démonstration',
              style: AppTextStyles.sectionTitle,
            ),
            const SizedBox(height: 16),
            
            ..._guides.take(3).map((guide) => _buildGuideCard(guide)).toList(),
            
            const SizedBox(height: 32),
            
            // Instructions
            Card(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Comment tester',
                          style: AppTextStyles.cardTitle.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '1. Cliquez sur un guide pour l\'ouvrir',
                      style: AppTextStyles.bodyMedium,
                    ),
                    Text(
                      '2. Utilisez les checkboxes pour marquer les étapes',
                      style: AppTextStyles.bodyMedium,
                    ),
                    Text(
                      '3. Observez la barre de progression se mettre à jour',
                      style: AppTextStyles.bodyMedium,
                    ),
                    Text(
                      '4. Testez le bouton "Marquer comme terminé"',
                      style: AppTextStyles.bodyMedium,
                    ),
                    Text(
                      '5. Utilisez les boutons de partage',
                      style: AppTextStyles.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required String description,
    required List<String> features,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Icon(
                    icon,
                    color: Theme.of(context).colorScheme.primary,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: AppTextStyles.cardTitle,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        description,
                        style: AppTextStyles.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Fonctionnalités :',
              style: AppTextStyles.bodyMedium.copyWith(
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 8),
            ...features.map((feature) => Padding(
              padding: const EdgeInsets.only(left: 8, top: 4),
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    size: 16,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      feature,
                      style: AppTextStyles.bodySmall,
                    ),
                  ),
                ],
              ),
            )).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildGuideCard(Guide guide) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => GuideDetailPage(guide: guide),
            ),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Text(
                guide.categoryIcon,
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      guide.title,
                      style: AppTextStyles.cardTitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      guide.categoryDisplayName,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Theme.of(context).colorScheme.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
