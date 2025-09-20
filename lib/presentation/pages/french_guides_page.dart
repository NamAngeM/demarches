import 'package:flutter/material.dart';
import '../../core/design/french_design_system.dart';
import '../widgets/french_components.dart';

/// 🇫🇷 PAGE GUIDES FRANÇAISE
/// Implémentation selon la structure Figma
class FrenchGuidesPage extends StatefulWidget {
  const FrenchGuidesPage({super.key});

  @override
  State<FrenchGuidesPage> createState() => _FrenchGuidesPageState();
}

class _FrenchGuidesPageState extends State<FrenchGuidesPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _searchQuery = '';
  int _selectedCategory = 0;

  final List<String> _categories = [
    'Tous',
    'Visa & Titre de séjour',
    'Logement',
    'Santé & Assurance',
    'Banque & Finance',
    'Études & Université',
    'Transport',
    'Stages & Emploi',
    'Vie quotidienne',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _categories.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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
                _buildSearchSection(),
                const SizedBox(height: FrenchDesignSystem.space6),
                _buildCategoryTabs(),
                const SizedBox(height: FrenchDesignSystem.space4),
                _buildGuidesList(),
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
                      Icons.menu_book_rounded,
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
                          'Guides & Conseils',
                          style: FrenchDesignSystem.titleLarge.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Tout ce qu\'il faut savoir',
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
                      Icons.filter_list,
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

  Widget _buildSearchSection() {
    return FrenchComponents.card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Rechercher un guide',
            style: FrenchDesignSystem.headlineSmall,
          ),
          const SizedBox(height: FrenchDesignSystem.space4),
          FrenchComponents.inputField(
            label: '',
            hintText: 'Ex: visa, logement, banque...',
            prefixIcon: Icons.search,
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
              });
            },
          ),
          const SizedBox(height: FrenchDesignSystem.space4),
          Row(
            children: [
              FrenchComponents.chip(
                text: 'Populaires',
                isSelected: true,
                onTap: () {},
              ),
              const SizedBox(width: FrenchDesignSystem.space2),
              FrenchComponents.chip(
                text: 'Récents',
                isSelected: false,
                onTap: () {},
              ),
              const SizedBox(width: FrenchDesignSystem.space2),
              FrenchComponents.chip(
                text: 'Favoris',
                isSelected: false,
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryTabs() {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final isSelected = _selectedCategory == index;
          return Padding(
            padding: EdgeInsets.only(
              right: index < _categories.length - 1 ? FrenchDesignSystem.space2 : 0,
            ),
            child: FrenchComponents.chip(
              text: _categories[index],
              isSelected: isSelected,
              icon: _getCategoryIcon(_categories[index]),
              onTap: () {
                setState(() {
                  _selectedCategory = index;
                });
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildGuidesList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Guides disponibles',
              style: FrenchDesignSystem.headlineSmall,
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.grid_view),
                  color: FrenchDesignSystem.primary,
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.list),
                  color: FrenchDesignSystem.gray400,
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: FrenchDesignSystem.space4),
        _buildGuideCard(
          'Demande de visa étudiant',
          'Guide complet pour obtenir votre visa étudiant en France. Toutes les étapes détaillées.',
          'Visa & Titre de séjour',
          'Difficile',
          '2-3 mois',
          Icons.credit_card,
          FrenchDesignSystem.error,
          false,
          true,
        ),
        const SizedBox(height: FrenchDesignSystem.space3),
        _buildGuideCard(
          'Trouver un logement étudiant',
          'Comment trouver et louer un logement en tant qu\'étudiant international.',
          'Logement',
          'Moyen',
          '1-2 mois',
          Icons.home,
          FrenchDesignSystem.accent,
          false,
          false,
        ),
        const SizedBox(height: FrenchDesignSystem.space3),
        _buildGuideCard(
          'Ouverture compte bancaire',
          'Guide pour ouvrir un compte bancaire en France avec tous les documents nécessaires.',
          'Banque & Finance',
          'Facile',
          '1-2 semaines',
          Icons.account_balance,
          FrenchDesignSystem.info,
          true,
          false,
        ),
        const SizedBox(height: FrenchDesignSystem.space3),
        _buildGuideCard(
          'Inscription universitaire',
          'Processus d\'inscription dans une université française pour étudiants internationaux.',
          'Études & Université',
          'Moyen',
          '2-4 semaines',
          Icons.school,
          FrenchDesignSystem.primary,
          false,
          true,
        ),
        const SizedBox(height: FrenchDesignSystem.space3),
        _buildGuideCard(
          'Assurance santé étudiante',
          'Comprendre et souscrire à l\'assurance maladie en France.',
          'Santé & Assurance',
          'Facile',
          '1 semaine',
          Icons.health_and_safety,
          FrenchDesignSystem.success,
          false,
          false,
        ),
        const SizedBox(height: FrenchDesignSystem.space3),
        _buildGuideCard(
          'Transport public en France',
          'Naviguer dans les transports en commun : métro, bus, train.',
          'Transport',
          'Facile',
          'Quelques jours',
          Icons.directions_bus,
          FrenchDesignSystem.warning,
          false,
          false,
        ),
      ],
    );
  }

  Widget _buildGuideCard(
    String title,
    String description,
    String category,
    String difficulty,
    String duration,
    IconData icon,
    Color color,
    bool isCompleted,
    bool isBookmarked,
  ) {
    return FrenchComponents.guideCard(
      title: title,
      description: description,
      category: category,
      difficulty: difficulty,
      duration: duration,
      isCompleted: isCompleted,
      isBookmarked: isBookmarked,
      onTap: () => _showGuideDetail(title, description, category),
      onBookmark: () {
        setState(() {
          // TODO: Toggle bookmark
        });
      },
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'tous':
        return Icons.apps;
      case 'visa & titre de séjour':
        return Icons.credit_card;
      case 'logement':
        return Icons.home;
      case 'santé & assurance':
        return Icons.health_and_safety;
      case 'banque & finance':
        return Icons.account_balance;
      case 'études & université':
        return Icons.school;
      case 'transport':
        return Icons.directions_bus;
      case 'stages & emploi':
        return Icons.work;
      case 'vie quotidienne':
        return Icons.person;
      default:
        return Icons.help_outline;
    }
  }

  void _showGuideDetail(String title, String description, String category) {
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
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(FrenchDesignSystem.space3),
                    decoration: BoxDecoration(
                      color: FrenchDesignSystem.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(FrenchDesignSystem.radiusMedium),
                    ),
                    child: Icon(
                      _getCategoryIcon(category),
                      color: FrenchDesignSystem.primary,
                      size: 32,
                    ),
                  ),
                  const SizedBox(width: FrenchDesignSystem.space4),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: FrenchDesignSystem.headlineSmall,
                        ),
                        const SizedBox(height: FrenchDesignSystem.space2),
                        Text(
                          category,
                          style: FrenchDesignSystem.bodyMedium.copyWith(
                            color: FrenchDesignSystem.primary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.bookmark_border),
                    color: FrenchDesignSystem.gray400,
                  ),
                ],
              ),
              const SizedBox(height: FrenchDesignSystem.space4),
              Text(
                'Description',
                style: FrenchDesignSystem.titleMedium,
              ),
              const SizedBox(height: FrenchDesignSystem.space2),
              Text(
                description,
                style: FrenchDesignSystem.bodyLarge,
              ),
              const SizedBox(height: FrenchDesignSystem.space4),
              Row(
                children: [
                  FrenchComponents.badge(
                    text: 'Difficile',
                    backgroundColor: FrenchDesignSystem.warning.withOpacity(0.1),
                    textColor: FrenchDesignSystem.warning,
                  ),
                  const SizedBox(width: FrenchDesignSystem.space2),
                  FrenchComponents.badge(
                    text: '2-3 mois',
                    backgroundColor: FrenchDesignSystem.info.withOpacity(0.1),
                    textColor: FrenchDesignSystem.info,
                  ),
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  Expanded(
                    child: FrenchComponents.secondaryButton(
                      text: 'Partager',
                      icon: Icons.share,
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  const SizedBox(width: FrenchDesignSystem.space3),
                  Expanded(
                    child: FrenchComponents.primaryButton(
                      text: 'Commencer',
                      icon: Icons.play_arrow,
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
}
