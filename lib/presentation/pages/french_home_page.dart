import 'package:flutter/material.dart';
import '../../core/design/french_design_system.dart';
import '../widgets/french_components.dart';

/// 🇫🇷 PAGE D'ACCUEIL FRANÇAISE
/// Implémentation selon la structure Figma
class FrenchHomePage extends StatelessWidget {
  const FrenchHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildAppBar(context),
          SliverPadding(
            padding: const EdgeInsets.all(FrenchDesignSystem.space4),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildWelcomeSection(),
                const SizedBox(height: FrenchDesignSystem.space6),
                _buildQuickActions(),
                const SizedBox(height: FrenchDesignSystem.space6),
                _buildRecentActivity(),
                const SizedBox(height: FrenchDesignSystem.space6),
                _buildRecommendations(),
                const SizedBox(height: FrenchDesignSystem.space6),
                _buildNewsUpdates(),
                const SizedBox(height: FrenchDesignSystem.space8),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 120,
      pinned: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(
            gradient: FrenchDesignSystem.primaryGradient,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(FrenchDesignSystem.radiusXXLarge),
              bottomRight: Radius.circular(FrenchDesignSystem.radiusXXLarge),
            ),
            boxShadow: FrenchDesignSystem.shadowLarge,
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: FrenchDesignSystem.space4,
                vertical: FrenchDesignSystem.space3,
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(FrenchDesignSystem.space2),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(FrenchDesignSystem.radiusMedium),
                      border: Border.all(color: Colors.white.withOpacity(0.3)),
                    ),
                    child: const Icon(
                      Icons.school,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: FrenchDesignSystem.space3),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Bonjour, Étudiant !',
                          style: FrenchDesignSystem.titleLarge.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Bienvenue en France 🇫🇷',
                          style: FrenchDesignSystem.bodyMedium.copyWith(
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(FrenchDesignSystem.space2),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(FrenchDesignSystem.radiusMedium),
                    ),
                    child: Stack(
                      children: [
                        const Icon(
                          Icons.notifications_outlined,
                          color: Colors.white,
                          size: 24,
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: FrenchDesignSystem.secondary,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeSection() {
    return FrenchComponents.card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(FrenchDesignSystem.space3),
                decoration: BoxDecoration(
                  gradient: FrenchDesignSystem.franceGradient,
                  borderRadius: BorderRadius.circular(FrenchDesignSystem.radiusLarge),
                  boxShadow: FrenchDesignSystem.shadowMedium,
                ),
                child: const Icon(
                  Icons.rocket_launch_rounded,
                  color: Colors.white,
                  size: 32,
                ),
              ),
              const SizedBox(width: FrenchDesignSystem.space4),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Votre parcours commence ici',
                      style: FrenchDesignSystem.headlineSmall.copyWith(
                        color: FrenchDesignSystem.gray900,
                      ),
                    ),
                    const SizedBox(height: FrenchDesignSystem.space2),
                    Text(
                      'Découvrez tous les guides pour réussir votre installation en France',
                      style: FrenchDesignSystem.bodyMedium.copyWith(
                        color: FrenchDesignSystem.gray600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: FrenchDesignSystem.space4),
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  'Guides',
                  '12',
                  Icons.menu_book,
                  FrenchDesignSystem.primary,
                ),
              ),
              const SizedBox(width: FrenchDesignSystem.space3),
              Expanded(
                child: _buildStatCard(
                  'Terminés',
                  '3',
                  Icons.check_circle,
                  FrenchDesignSystem.success,
                ),
              ),
              const SizedBox(width: FrenchDesignSystem.space3),
              Expanded(
                child: _buildStatCard(
                  'En cours',
                  '2',
                  Icons.schedule,
                  FrenchDesignSystem.warning,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(FrenchDesignSystem.space3),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(FrenchDesignSystem.radiusMedium),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: FrenchDesignSystem.space2),
          Text(
            value,
            style: FrenchDesignSystem.titleMedium.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: FrenchDesignSystem.labelSmall.copyWith(
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Actions rapides',
          style: FrenchDesignSystem.headlineSmall,
        ),
        const SizedBox(height: FrenchDesignSystem.space4),
        Row(
          children: [
            Expanded(
              child: _buildQuickActionCard(
                'Nouvelle démarche',
                Icons.add_circle_outline,
                FrenchDesignSystem.primary,
                () {},
              ),
            ),
            const SizedBox(width: FrenchDesignSystem.space3),
            Expanded(
              child: _buildQuickActionCard(
                'Mes favoris',
                Icons.favorite_outline,
                FrenchDesignSystem.secondary,
                () {},
              ),
            ),
          ],
        ),
        const SizedBox(height: FrenchDesignSystem.space3),
        Row(
          children: [
            Expanded(
              child: _buildQuickActionCard(
                'Urgences',
                Icons.phone,
                FrenchDesignSystem.error,
                () {},
              ),
            ),
            const SizedBox(width: FrenchDesignSystem.space3),
            Expanded(
              child: _buildQuickActionCard(
                'Communauté',
                Icons.people_outline,
                FrenchDesignSystem.accent,
                () {},
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildQuickActionCard(String title, IconData icon, Color color, VoidCallback onTap) {
    return FrenchComponents.card(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(FrenchDesignSystem.space3),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(FrenchDesignSystem.radiusMedium),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: FrenchDesignSystem.space3),
          Text(
            title,
            style: FrenchDesignSystem.titleSmall.copyWith(
              color: FrenchDesignSystem.gray700,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildRecentActivity() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Activité récente',
              style: FrenchDesignSystem.headlineSmall,
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'Voir tout',
                style: FrenchDesignSystem.labelMedium.copyWith(
                  color: FrenchDesignSystem.primary,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: FrenchDesignSystem.space4),
        FrenchComponents.guideCard(
          title: 'Demande de visa étudiant',
          description: 'Guide complet pour obtenir votre visa étudiant en France',
          category: 'Visa & Titre de séjour',
          difficulty: 'Difficile',
          duration: '2-3 mois',
          isCompleted: false,
          isBookmarked: true,
          onTap: () {},
          onBookmark: () {},
        ),
        const SizedBox(height: FrenchDesignSystem.space3),
        FrenchComponents.guideCard(
          title: 'Ouverture compte bancaire',
          description: 'Comment ouvrir un compte bancaire en tant qu\'étudiant étranger',
          category: 'Banque & Finance',
          difficulty: 'Moyen',
          duration: '1-2 semaines',
          isCompleted: true,
          isBookmarked: false,
          onTap: () {},
          onBookmark: () {},
        ),
      ],
    );
  }

  Widget _buildRecommendations() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recommandé pour vous',
              style: FrenchDesignSystem.headlineSmall,
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'Explorer plus',
                style: FrenchDesignSystem.labelMedium.copyWith(
                  color: FrenchDesignSystem.primary,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: FrenchDesignSystem.space4),
        SizedBox(
          height: 200,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildRecommendationCard(
                'Trouver un logement',
                'Guide complet pour trouver votre logement étudiant',
                'Logement',
                Icons.home,
                FrenchDesignSystem.accent,
              ),
              const SizedBox(width: FrenchDesignSystem.space3),
              _buildRecommendationCard(
                'Assurance santé',
                'Comprendre le système de santé français',
                'Santé & Assurance',
                Icons.health_and_safety,
                FrenchDesignSystem.success,
              ),
              const SizedBox(width: FrenchDesignSystem.space3),
              _buildRecommendationCard(
                'Transport public',
                'Naviguer dans les transports en commun',
                'Transport',
                Icons.directions_bus,
                FrenchDesignSystem.info,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRecommendationCard(
    String title,
    String description,
    String category,
    IconData icon,
    Color color,
  ) {
    return SizedBox(
      width: 280,
      child: FrenchComponents.card(
        onTap: () {},
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 100,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [color.withOpacity(0.8), color],
                ),
                borderRadius: BorderRadius.circular(FrenchDesignSystem.radiusMedium),
              ),
              child: Center(
                child: Icon(icon, color: Colors.white, size: 40),
              ),
            ),
            const SizedBox(height: FrenchDesignSystem.space3),
            Text(
              title,
              style: FrenchDesignSystem.titleMedium,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: FrenchDesignSystem.space2),
            Text(
              description,
              style: FrenchDesignSystem.bodySmall,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: FrenchDesignSystem.space3),
            FrenchComponents.badge(
              text: category,
              backgroundColor: color.withOpacity(0.1),
              textColor: color,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNewsUpdates() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Actualités & Mises à jour',
          style: FrenchDesignSystem.headlineSmall,
        ),
        const SizedBox(height: FrenchDesignSystem.space4),
        FrenchComponents.card(
          child: Column(
            children: [
              _buildNewsItem(
                'Nouvelle réglementation visa',
                'Les démarches pour les étudiants internationaux ont été simplifiées',
                'Il y a 2 heures',
                Icons.new_releases,
                FrenchDesignSystem.info,
              ),
              const Divider(height: FrenchDesignSystem.space6),
              _buildNewsItem(
                'Guide logement mis à jour',
                'Nouvelles informations sur les aides au logement étudiant',
                'Il y a 1 jour',
                Icons.home_work,
                FrenchDesignSystem.accent,
              ),
              const Divider(height: FrenchDesignSystem.space6),
              _buildNewsItem(
                'Conseil de la semaine',
                'Comment optimiser votre budget étudiant en France',
                'Il y a 3 jours',
                Icons.lightbulb_outline,
                FrenchDesignSystem.warning,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNewsItem(
    String title,
    String description,
    String time,
    IconData icon,
    Color color,
  ) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(FrenchDesignSystem.space2),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(FrenchDesignSystem.radiusSmall),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(width: FrenchDesignSystem.space3),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: FrenchDesignSystem.titleSmall,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: FrenchDesignSystem.space1),
              Text(
                description,
                style: FrenchDesignSystem.bodySmall,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: FrenchDesignSystem.space1),
              Text(
                time,
                style: FrenchDesignSystem.labelSmall.copyWith(
                  color: FrenchDesignSystem.gray500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
