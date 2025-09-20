import 'package:flutter/material.dart';
import '../../core/design/tailwind_colors.dart';
import '../../core/design/tailwind_spacing.dart';
import '../../core/design/tailwind_typography.dart';
import '../../core/design/tailwind_components.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFF5F5F5), // Gris France très clair
              Color(0xFFE0E0E0), // Gris France clair
              Color(0xFFF5F5F5), // Gris France très clair
            ],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              _buildAppBar(),
              SliverPadding(
                padding: const EdgeInsets.all(TailwindSpacing.p4),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    _buildHeroSection(),
                    const SizedBox(height: TailwindSpacing.p4),
                    _buildStatsSection(),
                    const SizedBox(height: TailwindSpacing.p4),
                    _buildMainServices(context),
                    const SizedBox(height: TailwindSpacing.p4),
                    _buildAdditionalServices(context),
                    const SizedBox(height: TailwindSpacing.p6),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 100,
      floating: false,
      pinned: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF1565C0), // Bleu France
                  Color(0xFF1976D2), // Bleu France clair
                  Color(0xFF1E88E5), // Bleu France plus clair
                ],
                stops: [0.0, 0.6, 1.0],
              ),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24),
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0x261565C0), // Bleu France avec opacité
                blurRadius: 20,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: SafeArea(
              child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                  children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.25),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: const Icon(
                      Icons.school_rounded,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Bonjour ! 👋',
                          style: TailwindTypography.h3.copyWith(
                            color: Colors.white,
                            fontWeight: TailwindTypography.fontBold,
                          ),
                        ),
                        Text(
                          'Votre assistant démarches étudiantes',
                          style: TailwindTypography.styleSm.copyWith(
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.notifications_outlined,
                      color: Colors.white,
                      size: 20,
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

  Widget _buildHeroSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            TailwindColors.gray50,
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: TailwindColors.gray200.withOpacity(0.5),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    TailwindColors.primary,
                    TailwindColors.primaryLight,
                  ],
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: TailwindColors.primary.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(
                Icons.rocket_launch_rounded,
                color: Colors.white,
                size: 28,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Prêt à commencer ?',
                    style: TailwindTypography.h4.copyWith(
                      fontWeight: TailwindTypography.fontBold,
                      color: TailwindColors.gray900,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Découvrez tous les outils pour réussir vos démarches',
                    style: TailwindTypography.styleSm.copyWith(
                      color: TailwindColors.gray600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Text(
            'Vos Statistiques',
            style: TailwindTypography.h4.copyWith(
              fontWeight: TailwindTypography.fontBold,
              color: TailwindColors.gray900,
            ),
          ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
              child: _buildStatCard('12', 'Démarches', Icons.checklist_rounded, TailwindColors.primary),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _buildStatCard('3', 'Urgentes', Icons.priority_high_rounded, TailwindColors.error),
            ),
            const SizedBox(width: 8),
                        Expanded(
              child: _buildStatCard('85%', 'Terminé', Icons.trending_up_rounded, TailwindColors.success),
                        ),
                      ],
                    ),
                  ],
    );
  }

  Widget _buildStatCard(String value, String label, IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: TailwindColors.gray200.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: TailwindTypography.h5.copyWith(
                color: color,
                fontWeight: TailwindTypography.fontBold,
              ),
            ),
            Text(
              label,
              style: TailwindTypography.styleXs.copyWith(
                color: TailwindColors.gray600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMainServices(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Text(
            'Services Principaux',
            style: TailwindTypography.h4.copyWith(
              fontWeight: TailwindTypography.fontBold,
              color: TailwindColors.gray900,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildServiceCard(
                context,
                'Checklist',
                Icons.checklist_rounded,
                TailwindColors.primary,
                'Suivez vos démarches',
                () => _navigateToPage(context, 1),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _buildServiceCard(
                context,
                'Guides',
                Icons.menu_book_rounded,
                TailwindColors.secondary,
                'Tout savoir',
                () => _navigateToPage(context, 2),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAdditionalServices(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Text(
            'Outils Utiles',
            style: TailwindTypography.h4.copyWith(
              fontWeight: TailwindTypography.fontBold,
              color: TailwindColors.gray900,
            ),
          ),
        ),
        const SizedBox(height: 12),
        _buildToolCard(
          context,
          'Calculatrice de Budget',
          Icons.calculate_rounded,
          TailwindColors.success,
          'Gérez vos finances',
          () => _showFeatureDialog(context, 'Calculatrice de Budget'),
        ),
        const SizedBox(height: 8),
        _buildToolCard(
          context,
          'Contacts d\'Urgence',
          Icons.emergency_rounded,
          TailwindColors.error,
          'Numéros importants',
          () => _showFeatureDialog(context, 'Contacts d\'Urgence'),
        ),
        const SizedBox(height: 8),
        _buildToolCard(
          context,
          'Scanner de Documents',
          Icons.document_scanner_rounded,
          TailwindColors.info,
          'Numérisez vos papiers',
          () => _showFeatureDialog(context, 'Scanner de Documents'),
        ),
        const SizedBox(height: 8),
        _buildToolCard(
          context,
          'Recherche',
          Icons.search_rounded,
          TailwindColors.accent,
          'Trouvez rapidement',
          () => _showFeatureDialog(context, 'Recherche'),
        ),
      ],
    );
  }

  Widget _buildServiceCard(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    String subtitle,
    VoidCallback onTap,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: TailwindColors.gray200.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        color.withOpacity(0.1),
                        color.withOpacity(0.05),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: color, size: 28),
                ),
                const SizedBox(height: 12),
                Text(
                  title,
                  style: TailwindTypography.h6.copyWith(
                    fontWeight: TailwindTypography.fontBold,
                    color: TailwindColors.gray900,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TailwindTypography.styleXs.copyWith(
                    color: TailwindColors.gray600,
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

  Widget _buildToolCard(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    String subtitle,
    VoidCallback onTap,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: TailwindColors.gray200.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: color, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TailwindTypography.h6.copyWith(
                          fontWeight: TailwindTypography.fontBold,
                          color: TailwindColors.gray900,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: TailwindTypography.styleXs.copyWith(
                          color: TailwindColors.gray600,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: TailwindColors.gray400,
                  size: 14,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showFeatureDialog(BuildContext context, String feature) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(TailwindSpacing.rounded2xl),
        ),
        title: Text(
          feature,
          style: TailwindTypography.h4,
        ),
        content: Text(
          'Cette fonctionnalité sera bientôt disponible !',
          style: TailwindTypography.styleBase,
        ),
        actions: [
          TailwindComponents.button(
            text: 'OK',
            onPressed: () => Navigator.pop(context),
            backgroundColor: TailwindColors.primary,
            textColor: Colors.white,
            paddingHorizontal: TailwindSpacing.p4,
            paddingVertical: TailwindSpacing.p2,
            borderRadius: TailwindSpacing.roundedLg,
          ),
        ],
      ),
    );
  }

  void _navigateToPage(BuildContext context, int pageIndex) {
    // Navigation vers la page spécifique
    // Dans une vraie app, on utiliserait Navigator ou un système de routage
    print('Navigation vers la page $pageIndex');
  }
}