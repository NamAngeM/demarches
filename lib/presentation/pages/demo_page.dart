import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/buttons/buttons.dart';
import '../../core/theme/app_text_styles.dart';
import 'guides_home_page.dart';
import 'widget_showcase_page.dart';
import 'features_demo_page.dart';

class DemoPage extends ConsumerWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Démo - Démarches App'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
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
              'Votre application de guides pour étudiants étrangers en France',
              style: AppTextStyles.bodyLarge,
            ),
            const SizedBox(height: 32),
            
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Fonctionnalités disponibles',
                      style: AppTextStyles.sectionTitle,
                    ),
                    const SizedBox(height: 16),
                    
                    _buildFeatureItem(
                      context: context,
                      icon: Icons.menu_book,
                      title: 'Guides Étudiants',
                      description: '10 guides complets pour étudiants étrangers',
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const GuidesHomePage(),
                          ),
                        );
                      },
                    ),
                    
                    const Divider(),
                    
                    _buildFeatureItem(
                      context: context,
                      icon: Icons.palette,
                      title: 'Galerie des Widgets',
                      description: 'Découvrez tous les composants UI disponibles',
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const WidgetShowcasePage(),
                          ),
                        );
                      },
                    ),
                    
                    const Divider(),
                    
                    _buildFeatureItem(
                      context: context,
                      icon: Icons.check_box,
                      title: 'Fonctionnalités Avancées',
                      description: 'Checkboxes, progression, partage et plus',
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const FeaturesDemoPage(),
                          ),
                        );
                      },
                    ),
                    
                    const Divider(),
                    
                    _buildFeatureItem(
                      context: context,
                      icon: Icons.search,
                      title: 'Recherche Intelligente',
                      description: 'Recherchez par titre, description, catégorie ou tags',
                      onTap: null,
                    ),
                    
                    const Divider(),
                    
                    _buildFeatureItem(
                      context: context,
                      icon: Icons.category,
                      title: 'Catégories',
                      description: 'Filtrez par Visa, Université, Logement, etc.',
                      onTap: null,
                    ),
                    
                    const Divider(),
                    
                    _buildFeatureItem(
                      context: context,
                      icon: Icons.favorite,
                      title: 'Favoris',
                      description: 'Sauvegardez vos guides préférés',
                      onTap: null,
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Guides disponibles',
                      style: AppTextStyles.sectionTitle,
                    ),
                    const SizedBox(height: 16),
                    
                    _buildGuidePreview(
                      context: context,
                      emoji: '🛂',
                      title: 'Obtenir un visa étudiant',
                      difficulty: 'Moyen',
                      duration: '2-3 mois',
                    ),
                    
                    _buildGuidePreview(
                      context: context,
                      emoji: '🎓',
                      title: 'S\'inscrire à l\'université',
                      difficulty: 'Moyen',
                      duration: '3-4 mois',
                    ),
                    
                    _buildGuidePreview(
                      context: context,
                      emoji: '🏦',
                      title: 'Ouvrir un compte bancaire',
                      difficulty: 'Facile',
                      duration: '1-2 semaines',
                    ),
                    
                    _buildGuidePreview(
                      context: context,
                      emoji: '🏠',
                      title: 'Trouver un logement',
                      difficulty: 'Difficile',
                      duration: '1-2 mois',
                    ),
                    
                    _buildGuidePreview(
                      context: context,
                      emoji: '🏥',
                      title: 'Sécurité sociale étudiante',
                      difficulty: 'Facile',
                      duration: '2-3 semaines',
                    ),
                  ],
                ),
              ),
            ),
            
            const Spacer(),
            
            Center(
              child: Column(
                children: [
                  AppButton(
                    text: 'Commencer l\'exploration',
                    icon: Icons.rocket_launch,
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const GuidesHomePage(),
                        ),
                      );
                    },
                    isFullWidth: true,
                    size: AppButtonSize.large,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Développé avec ❤️ en France',
                    style: AppTextStyles.bodySmall,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String description,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
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
            if (onTap != null)
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Theme.of(context).colorScheme.primary,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildGuidePreview({
    required BuildContext context,
    required String emoji,
    required String title,
    required String difficulty,
    required String duration,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 24)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.bodyLarge.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    _buildInfoChip(
                      context: context,
                      icon: Icons.schedule,
                      label: duration,
                      color: Colors.blue,
                    ),
                    const SizedBox(width: 8),
                    _buildInfoChip(
                      context: context,
                      icon: Icons.trending_up,
                      label: difficulty,
                      color: _getDifficultyColor(difficulty),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip({
    required BuildContext context,
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: AppTextStyles.bodySmall.copyWith(color: color),
          ),
        ],
      ),
    );
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'facile':
        return Colors.green;
      case 'moyen':
        return Colors.orange;
      case 'difficile':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
