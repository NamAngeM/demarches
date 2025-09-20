import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/guide.dart';
import '../../domain/entities/user_profile.dart';
import '../../data/services/comprehensive_guide_service.dart';
import '../../core/services/tips_and_tricks_service.dart';
import '../../core/services/emergency_contacts_service.dart';
import '../../core/services/budget_calculator_service.dart';
import '../../core/providers/auth_provider.dart';
import '../widgets/buttons/buttons.dart';
import '../../core/theme/app_text_styles.dart';

class ComprehensiveGuidesPage extends ConsumerStatefulWidget {
  const ComprehensiveGuidesPage({super.key});

  @override
  ConsumerState<ComprehensiveGuidesPage> createState() => _ComprehensiveGuidesPageState();
}

class _ComprehensiveGuidesPageState extends ConsumerState<ComprehensiveGuidesPage> {
  final List<Guide> _comprehensiveGuides = ComprehensiveGuideService.createComprehensiveGuides();
  final Map<String, List<Tip>> _tipsByCategory = TipsAndTricksService.getTipsByCategory();
  final List<EmergencyContact> _emergencyContacts = EmergencyContactsService.getAllContacts();
  
  String _selectedCategory = 'all';
  String _selectedSection = 'guides';

  @override
  Widget build(BuildContext context) {
    final userProfile = ref.watch(authNotifierProvider).value;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Guide Complet des Démarches'),
        actions: [
          AppIconButton(
            icon: Icons.search,
            onPressed: () {
              // TODO: Implémenter la recherche
            },
            tooltip: 'Rechercher',
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Column(
        children: [
          // Sections
          _buildSectionSelector(),
          
          // Contenu principal
          Expanded(
            child: _buildContent(userProfile),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionSelector() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          _buildSectionButton('guides', 'Guides', Icons.book),
          const SizedBox(width: 8),
          _buildSectionButton('tips', 'Astuces', Icons.lightbulb),
          const SizedBox(width: 8),
          _buildSectionButton('contacts', 'Contacts', Icons.phone),
          const SizedBox(width: 8),
          _buildSectionButton('budget', 'Budget', Icons.euro),
        ],
      ),
    );
  }

  Widget _buildSectionButton(String section, String label, IconData icon) {
    final isSelected = _selectedSection == section;
    return Expanded(
      child: AppButton(
        text: label,
        icon: icon,
        type: isSelected ? AppButtonType.primary : AppButtonType.outline,
        onPressed: () {
          setState(() {
            _selectedSection = section;
          });
        },
      ),
    );
  }

  Widget _buildContent(UserProfile? userProfile) {
    switch (_selectedSection) {
      case 'guides':
        return _buildGuidesSection();
      case 'tips':
        return _buildTipsSection();
      case 'contacts':
        return _buildContactsSection();
      case 'budget':
        return _buildBudgetSection(userProfile);
      default:
        return _buildGuidesSection();
    }
  }

  Widget _buildGuidesSection() {
    return Column(
      children: [
        // Filtres par catégorie
        _buildCategoryFilter(),
        
        // Liste des guides
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: _getFilteredGuides().length,
            itemBuilder: (context, index) {
              final guide = _getFilteredGuides()[index];
              return _buildGuideCard(guide);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryFilter() {
    final categories = ['all', 'visa', 'housing', 'banking', 'health', 'transport', 'education', 'work', 'culture', 'emergency'];
    
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = _selectedCategory == category;
          
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: Text(_getCategoryDisplayName(category)),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  _selectedCategory = category;
                });
              },
            ),
          );
        },
      ),
    );
  }

  String _getCategoryDisplayName(String category) {
    switch (category) {
      case 'all': return 'Tous';
      case 'visa': return 'Visa';
      case 'housing': return 'Logement';
      case 'banking': return 'Banque';
      case 'health': return 'Santé';
      case 'transport': return 'Transport';
      case 'education': return 'Éducation';
      case 'work': return 'Travail';
      case 'culture': return 'Culture';
      case 'emergency': return 'Urgences';
      default: return category;
    }
  }

  List<Guide> _getFilteredGuides() {
    if (_selectedCategory == 'all') {
      return _comprehensiveGuides;
    }
    
    return _comprehensiveGuides.where((guide) {
      return guide.category.name == _selectedCategory;
    }).toList();
  }

  Widget _buildGuideCard(Guide guide) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () {
          // TODO: Naviguer vers le guide détaillé
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      guide.category.displayName,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: _getDifficultyColor(guide.difficulty).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      guide.difficulty,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: _getDifficultyColor(guide.difficulty),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                guide.title,
                style: AppTextStyles.bodyLarge.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                guide.shortDescription,
                style: AppTextStyles.bodyMedium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(
                    Icons.schedule,
                    size: 16,
                    color: Colors.grey[600],
                  ),
                  const SizedBox(width: 4),
                  Text(
                    guide.estimatedDuration,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Icon(
                    Icons.list,
                    size: 16,
                    color: Colors.grey[600],
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${guide.steps.length} étapes',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: Colors.grey[600],
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

  Widget _buildTipsSection() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Astuces et Conseils Pratiques',
          style: AppTextStyles.sectionTitle,
        ),
        const SizedBox(height: 16),
        
        ..._tipsByCategory.entries.map((entry) {
          return _buildTipsCategory(entry.key, entry.value);
        }).toList(),
      ],
    );
  }

  Widget _buildTipsCategory(String category, List<Tip> tips) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _getCategoryDisplayName(category),
              style: AppTextStyles.bodyLarge.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            
            ...tips.map((tip) => _buildTipItem(tip)).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildTipItem(Tip tip) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            tip.isImportant ? Icons.priority_high : Icons.info,
            size: 16,
            color: tip.isImportant ? Colors.red : Colors.blue,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tip.title,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  tip.description,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactsSection() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Contacts d\'Urgence et Numéros Utiles',
          style: AppTextStyles.sectionTitle,
        ),
        const SizedBox(height: 16),
        
        _buildContactsCategory('Numéros d\'urgence', EmergencyContactsService.getEmergencyNumbers()),
        _buildContactsCategory('Services de santé étudiants', EmergencyContactsService.getStudentHealthServices()),
        _buildContactsCategory('Services d\'aide', EmergencyContactsService.getSupportServices()),
        _buildContactsCategory('Urgences logement', EmergencyContactsService.getHousingEmergencyServices()),
        _buildContactsCategory('Services administratifs', EmergencyContactsService.getAdministrativeServices()),
        _buildContactsCategory('Aides financières', EmergencyContactsService.getFinancialEmergencyServices()),
      ],
    );
  }

  Widget _buildContactsCategory(String title, List<EmergencyContact> contacts) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: AppTextStyles.bodyLarge.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            
            ...contacts.map((contact) => _buildContactItem(contact)).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildContactItem(EmergencyContact contact) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(
            _getContactIcon(contact.category),
            size: 20,
            color: _getPriorityColor(contact.priority),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  contact.name,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  contact.number,
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  contact.description,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          if (contact.isAvailable24h)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '24h/24',
                style: AppTextStyles.bodySmall.copyWith(
                  color: Colors.green,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildBudgetSection(UserProfile? userProfile) {
    if (userProfile == null) {
      return const Center(
        child: Text('Connectez-vous pour calculer votre budget'),
      );
    }

    final budget = BudgetCalculatorService.calculateMonthlyBudget(userProfile);
    final installationBudget = BudgetCalculatorService.calculateInstallationBudget(userProfile);
    final savings = BudgetCalculatorService.calculateSavings(userProfile);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Calculateur de Budget Étudiant',
          style: AppTextStyles.sectionTitle,
        ),
        const SizedBox(height: 16),
        
        // Budget mensuel
        _buildBudgetCard(
          'Budget Mensuel',
          '${budget.totalMonthly.toStringAsFixed(0)}€',
          budget.breakdown,
          budget.recommendations,
        ),
        
        const SizedBox(height: 16),
        
        // Budget d'installation
        _buildBudgetCard(
          'Budget d\'Installation',
          '${installationBudget.totalCost.toStringAsFixed(0)}€',
          installationBudget.breakdown,
          installationBudget.recommendations,
        ),
        
        const SizedBox(height: 16),
        
        // Économies possibles
        _buildBudgetCard(
          'Économies Possibles',
          '${savings.totalMonthlySavings.toStringAsFixed(0)}€/mois',
          savings.potentialSavings,
          savings.recommendations,
        ),
      ],
    );
  }

  Widget _buildBudgetCard(String title, String total, Map<String, double> breakdown, List<String> recommendations) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: AppTextStyles.bodyLarge.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  total,
                  style: AppTextStyles.headline3.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Répartition des dépenses
            ...breakdown.entries.map((entry) {
              final percentage = breakdown.values.fold(0.0, (sum, value) => sum + value) > 0
                  ? (entry.value / breakdown.values.fold(0.0, (sum, value) => sum + value) * 100).round()
                  : 0;
              
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      entry.key,
                      style: AppTextStyles.bodyMedium,
                    ),
                    Text(
                      '${entry.value.toStringAsFixed(0)}€ ($percentage%)',
                      style: AppTextStyles.bodyMedium.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
            
            const SizedBox(height: 16),
            
            // Recommandations
            Text(
              'Recommandations:',
              style: AppTextStyles.bodyMedium.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            
            ...recommendations.map((recommendation) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.lightbulb_outline,
                      size: 16,
                      color: Colors.orange,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        recommendation,
                        style: AppTextStyles.bodySmall,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty) {
      case 'Facile': return Colors.green;
      case 'Moyen': return Colors.orange;
      case 'Difficile': return Colors.red;
      default: return Colors.grey;
    }
  }


  IconData _getContactIcon(String category) {
    switch (category) {
      case 'medical': return Icons.local_hospital;
      case 'security': return Icons.security;
      case 'fire': return Icons.local_fire_department;
      case 'european': return Icons.public;
      case 'accessibility': return Icons.accessibility;
      case 'violence': return Icons.warning;
      case 'mental_health': return Icons.psychology;
      default: return Icons.phone;
    }
  }
}
