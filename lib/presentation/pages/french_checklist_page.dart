import 'package:flutter/material.dart';
import '../../core/design/french_design_system.dart';
import '../widgets/french_components.dart';

/// 🇫🇷 PAGE CHECKLIST FRANÇAISE
/// Implémentation selon la structure Figma
class FrenchChecklistPage extends StatefulWidget {
  const FrenchChecklistPage({super.key});

  @override
  State<FrenchChecklistPage> createState() => _FrenchChecklistPageState();
}

class _FrenchChecklistPageState extends State<FrenchChecklistPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedFilter = 0;

  final List<String> _filters = ['Toutes', 'En cours', 'Terminées', 'Urgentes'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _filters.length, vsync: this);
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
                _buildProgressSection(),
                const SizedBox(height: FrenchDesignSystem.space6),
                _buildFilterTabs(),
                const SizedBox(height: FrenchDesignSystem.space4),
                _buildChecklistItems(),
                const SizedBox(height: FrenchDesignSystem.space8),
              ]),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog,
        backgroundColor: FrenchDesignSystem.primary,
        child: const Icon(Icons.add, color: Colors.white),
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
                      Icons.checklist_rounded,
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
                          'Ma Checklist',
                          style: FrenchDesignSystem.titleLarge.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Suivez votre progression',
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

  Widget _buildProgressSection() {
    return FrenchComponents.card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(FrenchDesignSystem.space3),
                decoration: BoxDecoration(
                  gradient: FrenchDesignSystem.accentGradient,
                  borderRadius: BorderRadius.circular(FrenchDesignSystem.radiusLarge),
                  boxShadow: FrenchDesignSystem.shadowMedium,
                ),
                child: const Icon(
                  Icons.trending_up_rounded,
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
                      'Progression générale',
                      style: FrenchDesignSystem.headlineSmall.copyWith(
                        color: FrenchDesignSystem.gray900,
                      ),
                    ),
                    const SizedBox(height: FrenchDesignSystem.space2),
                    Text(
                      'Continuez sur cette lancée !',
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
          FrenchComponents.progressIndicator(
            progress: 0.65,
            label: '65% des tâches terminées',
            color: FrenchDesignSystem.accent,
          ),
          const SizedBox(height: FrenchDesignSystem.space4),
          Row(
            children: [
              Expanded(
                child: _buildProgressStat('Terminées', '13', FrenchDesignSystem.success),
              ),
              const SizedBox(width: FrenchDesignSystem.space3),
              Expanded(
                child: _buildProgressStat('En cours', '5', FrenchDesignSystem.warning),
              ),
              const SizedBox(width: FrenchDesignSystem.space3),
              Expanded(
                child: _buildProgressStat('Restantes', '7', FrenchDesignSystem.gray400),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProgressStat(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(FrenchDesignSystem.space3),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(FrenchDesignSystem.radiusMedium),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: FrenchDesignSystem.titleLarge.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: FrenchDesignSystem.space1),
          Text(
            label,
            style: FrenchDesignSystem.labelMedium.copyWith(
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterTabs() {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _filters.length,
        itemBuilder: (context, index) {
          final isSelected = _selectedFilter == index;
          return Padding(
            padding: EdgeInsets.only(
              right: index < _filters.length - 1 ? FrenchDesignSystem.space2 : 0,
            ),
            child: FrenchComponents.chip(
              text: _filters[index],
              isSelected: isSelected,
              onTap: () {
                setState(() {
                  _selectedFilter = index;
                });
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildChecklistItems() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tâches à faire',
          style: FrenchDesignSystem.headlineSmall,
        ),
        const SizedBox(height: FrenchDesignSystem.space4),
        _buildChecklistItem(
          'Demande de visa étudiant',
          'Rassembler tous les documents nécessaires',
          'Visa & Titre de séjour',
          FrenchDesignSystem.error,
          false,
          'Urgent',
        ),
        const SizedBox(height: FrenchDesignSystem.space3),
        _buildChecklistItem(
          'Ouverture compte bancaire',
          'Prendre rendez-vous avec une banque',
          'Banque & Finance',
          FrenchDesignSystem.warning,
          false,
          'Moyen',
        ),
        const SizedBox(height: FrenchDesignSystem.space3),
        _buildChecklistItem(
          'Inscription à l\'université',
          'Finaliser l\'inscription administrative',
          'Études & Université',
          FrenchDesignSystem.info,
          true,
          'Terminé',
        ),
        const SizedBox(height: FrenchDesignSystem.space3),
        _buildChecklistItem(
          'Trouver un logement',
          'Visiter les appartements sélectionnés',
          'Logement',
          FrenchDesignSystem.accent,
          false,
          'Important',
        ),
        const SizedBox(height: FrenchDesignSystem.space3),
        _buildChecklistItem(
          'Souscription assurance santé',
          'Choisir entre CPAM ou mutuelle',
          'Santé & Assurance',
          FrenchDesignSystem.success,
          true,
          'Terminé',
        ),
      ],
    );
  }

  Widget _buildChecklistItem(
    String title,
    String description,
    String category,
    Color color,
    bool isCompleted,
    String priority,
  ) {
    return FrenchComponents.card(
      onTap: () => _showTaskDetail(title, description, category),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: isCompleted ? FrenchDesignSystem.success : color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(FrenchDesignSystem.radiusSmall),
              border: Border.all(
                color: isCompleted ? FrenchDesignSystem.success : color,
                width: 2,
              ),
            ),
            child: isCompleted
                ? const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 16,
                  )
                : null,
          ),
          const SizedBox(width: FrenchDesignSystem.space3),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: FrenchDesignSystem.titleMedium.copyWith(
                          decoration: isCompleted ? TextDecoration.lineThrough : null,
                          color: isCompleted ? FrenchDesignSystem.gray500 : FrenchDesignSystem.gray900,
                        ),
                      ),
                    ),
                    FrenchComponents.badge(
                      text: priority,
                      backgroundColor: _getPriorityColor(priority).withOpacity(0.1),
                      textColor: _getPriorityColor(priority),
                    ),
                  ],
                ),
                const SizedBox(height: FrenchDesignSystem.space1),
                Text(
                  description,
                  style: FrenchDesignSystem.bodyMedium.copyWith(
                    color: FrenchDesignSystem.gray600,
                  ),
                ),
                const SizedBox(height: FrenchDesignSystem.space2),
                Row(
                  children: [
                    Icon(
                      _getCategoryIcon(category),
                      size: 16,
                      color: color,
                    ),
                    const SizedBox(width: FrenchDesignSystem.space1),
                    Text(
                      category,
                      style: FrenchDesignSystem.labelSmall.copyWith(
                        color: color,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    if (isCompleted)
                      Text(
                        'Terminé',
                        style: FrenchDesignSystem.labelSmall.copyWith(
                          color: FrenchDesignSystem.success,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    else
                      Text(
                        'En cours',
                        style: FrenchDesignSystem.labelSmall.copyWith(
                          color: FrenchDesignSystem.warning,
                          fontWeight: FontWeight.w600,
                        ),
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

  Color _getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'urgent':
        return FrenchDesignSystem.error;
      case 'important':
        return FrenchDesignSystem.warning;
      case 'moyen':
        return FrenchDesignSystem.info;
      case 'terminé':
        return FrenchDesignSystem.success;
      default:
        return FrenchDesignSystem.gray400;
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'visa & titre de séjour':
        return Icons.credit_card;
      case 'banque & finance':
        return Icons.account_balance;
      case 'études & université':
        return Icons.school;
      case 'logement':
        return Icons.home;
      case 'santé & assurance':
        return Icons.health_and_safety;
      default:
        return Icons.help_outline;
    }
  }

  void _showAddTaskDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Nouvelle tâche',
          style: FrenchDesignSystem.titleLarge,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FrenchComponents.inputField(
              label: 'Titre de la tâche',
              hintText: 'Ex: Demande de visa',
            ),
            const SizedBox(height: FrenchDesignSystem.space4),
            FrenchComponents.inputField(
              label: 'Description',
              hintText: 'Décrivez la tâche...',
              maxLines: 3,
            ),
            const SizedBox(height: FrenchDesignSystem.space4),
            FrenchComponents.inputField(
              label: 'Catégorie',
              hintText: 'Sélectionnez une catégorie',
              suffixIcon: Icons.arrow_drop_down,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Annuler'),
          ),
          FrenchComponents.primaryButton(
            text: 'Ajouter',
            onPressed: () {
              Navigator.pop(context);
              // TODO: Ajouter la tâche
            },
          ),
        ],
      ),
    );
  }

  void _showTaskDetail(String title, String description, String category) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
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
              const Spacer(),
              Row(
                children: [
                  Expanded(
                    child: FrenchComponents.secondaryButton(
                      text: 'Modifier',
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  const SizedBox(width: FrenchDesignSystem.space3),
                  Expanded(
                    child: FrenchComponents.primaryButton(
                      text: 'Marquer terminé',
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
