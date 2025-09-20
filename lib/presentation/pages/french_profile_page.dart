import 'package:flutter/material.dart';
import '../../core/design/french_design_system.dart';
import '../widgets/french_components.dart';

/// 🇫🇷 PAGE PROFIL FRANÇAISE
/// Implémentation selon la structure Figma
class FrenchProfilePage extends StatefulWidget {
  const FrenchProfilePage({super.key});

  @override
  State<FrenchProfilePage> createState() => _FrenchProfilePageState();
}

class _FrenchProfilePageState extends State<FrenchProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildAppBar(),
          SliverPadding(
            padding: const EdgeInsets.all(FrenchDesignSystem.space4),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildProfileHeader(),
                const SizedBox(height: FrenchDesignSystem.space6),
                _buildProgressSection(),
                const SizedBox(height: FrenchDesignSystem.space6),
                _buildQuickActions(),
                const SizedBox(height: FrenchDesignSystem.space6),
                _buildSettingsSection(),
                const SizedBox(height: FrenchDesignSystem.space8),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
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
                      Icons.person_rounded,
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
                          'Mon Profil',
                          style: FrenchDesignSystem.titleLarge.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Gérez vos informations',
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
                    child: const Icon(
                      Icons.settings,
                      color: Colors.white,
                      size: 24,
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

  Widget _buildProfileHeader() {
    return FrenchComponents.card(
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  gradient: FrenchDesignSystem.franceGradient,
                  borderRadius: BorderRadius.circular(FrenchDesignSystem.radiusFull),
                  boxShadow: FrenchDesignSystem.shadowMedium,
                ),
                child: const Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 40,
                ),
              ),
              const SizedBox(width: FrenchDesignSystem.space4),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Marie Dubois',
                      style: FrenchDesignSystem.headlineSmall,
                    ),
                    const SizedBox(height: FrenchDesignSystem.space2),
                    Text(
                      'Étudiante en Master',
                      style: FrenchDesignSystem.bodyMedium.copyWith(
                        color: FrenchDesignSystem.gray600,
                      ),
                    ),
                    const SizedBox(height: FrenchDesignSystem.space1),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 16,
                          color: FrenchDesignSystem.gray500,
                        ),
                        const SizedBox(width: FrenchDesignSystem.space1),
                        Text(
                          'Paris, France',
                          style: FrenchDesignSystem.bodySmall.copyWith(
                            color: FrenchDesignSystem.gray500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: FrenchDesignSystem.space1),
                    Row(
                      children: [
                        Icon(
                          Icons.flag,
                          size: 16,
                          color: FrenchDesignSystem.gray500,
                        ),
                        const SizedBox(width: FrenchDesignSystem.space1),
                        Text(
                          'Originaire du Canada',
                          style: FrenchDesignSystem.bodySmall.copyWith(
                            color: FrenchDesignSystem.gray500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: _editProfile,
                icon: const Icon(Icons.edit),
                color: FrenchDesignSystem.primary,
              ),
            ],
          ),
          const SizedBox(height: FrenchDesignSystem.space4),
          Row(
            children: [
              Expanded(
                child: _buildStatItem('Guides', '12', Icons.menu_book),
              ),
              Expanded(
                child: _buildStatItem('Terminés', '8', Icons.check_circle),
              ),
              Expanded(
                child: _buildStatItem('Favoris', '5', Icons.favorite),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(FrenchDesignSystem.space3),
      decoration: BoxDecoration(
        color: FrenchDesignSystem.gray50,
        borderRadius: BorderRadius.circular(FrenchDesignSystem.radiusMedium),
      ),
      child: Column(
        children: [
          Icon(icon, color: FrenchDesignSystem.primary, size: 24),
          const SizedBox(height: FrenchDesignSystem.space2),
          Text(
            value,
            style: FrenchDesignSystem.titleLarge.copyWith(
              color: FrenchDesignSystem.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: FrenchDesignSystem.labelMedium.copyWith(
              color: FrenchDesignSystem.gray600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressSection() {
    return FrenchComponents.card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Progression générale',
                style: FrenchDesignSystem.headlineSmall,
              ),
              Text(
                '67%',
                style: FrenchDesignSystem.titleLarge.copyWith(
                  color: FrenchDesignSystem.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: FrenchDesignSystem.space4),
          FrenchComponents.progressIndicator(
            progress: 0.67,
            color: FrenchDesignSystem.primary,
          ),
          const SizedBox(height: FrenchDesignSystem.space4),
          Row(
            children: [
              Expanded(
                child: _buildProgressCategory('Visa', 1.0, FrenchDesignSystem.success),
              ),
              const SizedBox(width: FrenchDesignSystem.space3),
              Expanded(
                child: _buildProgressCategory('Logement', 0.8, FrenchDesignSystem.warning),
              ),
              const SizedBox(width: FrenchDesignSystem.space3),
              Expanded(
                child: _buildProgressCategory('Banque', 0.6, FrenchDesignSystem.info),
              ),
              const SizedBox(width: FrenchDesignSystem.space3),
              Expanded(
                child: _buildProgressCategory('Santé', 0.3, FrenchDesignSystem.gray400),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProgressCategory(String name, double progress, Color color) {
    return Column(
      children: [
        Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(FrenchDesignSystem.radiusFull),
          ),
          child: Center(
            child: Text(
              '${(progress * 100).toInt()}%',
              style: FrenchDesignSystem.labelMedium.copyWith(
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: FrenchDesignSystem.space2),
        Text(
          name,
          style: FrenchDesignSystem.labelSmall,
        ),
      ],
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
                'Modifier le profil',
                Icons.edit,
                FrenchDesignSystem.primary,
                _editProfile,
              ),
            ),
            const SizedBox(width: FrenchDesignSystem.space3),
            Expanded(
              child: _buildQuickActionCard(
                'Paramètres',
                Icons.settings,
                FrenchDesignSystem.gray600,
                _openSettings,
              ),
            ),
          ],
        ),
        const SizedBox(height: FrenchDesignSystem.space3),
        Row(
          children: [
            Expanded(
              child: _buildQuickActionCard(
                'Aide & Support',
                Icons.help_outline,
                FrenchDesignSystem.info,
                _openHelp,
              ),
            ),
            const SizedBox(width: FrenchDesignSystem.space3),
            Expanded(
              child: _buildQuickActionCard(
                'À propos',
                Icons.info_outline,
                FrenchDesignSystem.gray600,
                _openAbout,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildQuickActionCard(
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
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

  Widget _buildSettingsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Paramètres',
          style: FrenchDesignSystem.headlineSmall,
        ),
        const SizedBox(height: FrenchDesignSystem.space4),
        FrenchComponents.card(
          child: Column(
            children: [
              _buildSettingItem(
                'Notifications',
                'Gérer vos notifications',
                Icons.notifications_outlined,
                true,
                () {},
              ),
              const Divider(height: FrenchDesignSystem.space6),
              _buildSettingItem(
                'Langue',
                'Français',
                Icons.language,
                false,
                () {},
              ),
              const Divider(height: FrenchDesignSystem.space6),
              _buildSettingItem(
                'Thème',
                'Clair',
                Icons.palette,
                false,
                () {},
              ),
              const Divider(height: FrenchDesignSystem.space6),
              _buildSettingItem(
                'Confidentialité',
                'Gérer vos données',
                Icons.privacy_tip_outlined,
                false,
                () {},
              ),
              const Divider(height: FrenchDesignSystem.space6),
              _buildSettingItem(
                'Se déconnecter',
                'Déconnexion de votre compte',
                Icons.logout,
                false,
                _logout,
                isDestructive: true,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSettingItem(
    String title,
    String subtitle,
    IconData icon,
    bool hasSwitch,
    VoidCallback onTap, {
    bool isDestructive = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(FrenchDesignSystem.radiusMedium),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: FrenchDesignSystem.space2),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(FrenchDesignSystem.space2),
              decoration: BoxDecoration(
                color: isDestructive
                    ? FrenchDesignSystem.error.withOpacity(0.1)
                    : FrenchDesignSystem.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(FrenchDesignSystem.radiusSmall),
              ),
              child: Icon(
                icon,
                color: isDestructive ? FrenchDesignSystem.error : FrenchDesignSystem.primary,
                size: 20,
              ),
            ),
            const SizedBox(width: FrenchDesignSystem.space3),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: FrenchDesignSystem.titleMedium.copyWith(
                      color: isDestructive ? FrenchDesignSystem.error : FrenchDesignSystem.gray900,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: FrenchDesignSystem.bodySmall.copyWith(
                      color: FrenchDesignSystem.gray600,
                    ),
                  ),
                ],
              ),
            ),
            if (hasSwitch)
              Switch(
                value: true,
                onChanged: (value) {},
                activeColor: FrenchDesignSystem.primary,
              )
            else
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: FrenchDesignSystem.gray400,
              ),
          ],
        ),
      ),
    );
  }

  void _editProfile() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(FrenchDesignSystem.radiusXXLarge),
            topRight: Radius.circular(FrenchDesignSystem.radiusXXLarge),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(FrenchDesignSystem.space4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: FrenchDesignSystem.gray300,
                    borderRadius: BorderRadius.circular(FrenchDesignSystem.radiusSmall),
                  ),
                ),
              ),
              const SizedBox(height: FrenchDesignSystem.space4),
              Text(
                'Modifier le profil',
                style: FrenchDesignSystem.headlineSmall,
              ),
              const SizedBox(height: FrenchDesignSystem.space4),
              FrenchComponents.inputField(
                label: 'Prénom',
                hintText: 'Marie',
              ),
              const SizedBox(height: FrenchDesignSystem.space4),
              FrenchComponents.inputField(
                label: 'Nom',
                hintText: 'Dubois',
              ),
              const SizedBox(height: FrenchDesignSystem.space4),
              FrenchComponents.inputField(
                label: 'Email',
                hintText: 'marie.dubois@email.com',
              ),
              const SizedBox(height: FrenchDesignSystem.space4),
              FrenchComponents.inputField(
                label: 'Université',
                hintText: 'Sorbonne Université',
              ),
              const Spacer(),
              Row(
                children: [
                  Expanded(
                    child: FrenchComponents.secondaryButton(
                      text: 'Annuler',
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  const SizedBox(width: FrenchDesignSystem.space3),
                  Expanded(
                    child: FrenchComponents.primaryButton(
                      text: 'Sauvegarder',
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openSettings() {
    // TODO: Ouvrir les paramètres
  }

  void _openHelp() {
    // TODO: Ouvrir l'aide
  }

  void _openAbout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'À propos',
          style: FrenchDesignSystem.titleLarge,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Student Guide France',
              style: FrenchDesignSystem.headlineSmall,
            ),
            const SizedBox(height: FrenchDesignSystem.space2),
            Text(
              'Version 1.0.0',
              style: FrenchDesignSystem.bodyMedium,
            ),
            const SizedBox(height: FrenchDesignSystem.space4),
            Text(
              'Votre guide complet pour réussir votre installation en France en tant qu\'étudiant international.',
              style: FrenchDesignSystem.bodyMedium,
            ),
          ],
        ),
        actions: [
          FrenchComponents.primaryButton(
            text: 'Fermer',
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  void _logout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Se déconnecter',
          style: FrenchDesignSystem.titleLarge,
        ),
        content: Text(
          'Êtes-vous sûr de vouloir vous déconnecter ?',
          style: FrenchDesignSystem.bodyLarge,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Annuler'),
          ),
          FrenchComponents.primaryButton(
            text: 'Déconnexion',
            onPressed: () {
              Navigator.pop(context);
              // TODO: Déconnexion
            },
          ),
        ],
      ),
    );
  }
}
