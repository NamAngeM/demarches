import 'package:flutter/material.dart';
import '../../domain/entities/budget_item.dart';
import '../../core/services/budget_calculator_service.dart';

class BudgetCalculatorPage extends StatefulWidget {
  const BudgetCalculatorPage({super.key});

  @override
  State<BudgetCalculatorPage> createState() => _BudgetCalculatorPageState();
}

class _BudgetCalculatorPageState extends State<BudgetCalculatorPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final BudgetCalculatorService _budgetService = BudgetCalculatorService.instance;
  
  List<BudgetItem> _budgetItems = [];
  bool _isLoading = true;
  String _selectedCity = 'France';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _initializeData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _initializeData() async {
    await _budgetService.loadBudget();
    setState(() {
      _budgetItems = _budgetService.budgetItems;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculatrice de Budget'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Vue d\'ensemble', icon: Icon(Icons.dashboard)),
            Tab(text: 'Par catégorie', icon: Icon(Icons.category)),
            Tab(text: 'Recommandations', icon: Icon(Icons.trending_up)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOverviewTab(),
          _buildCategoryTab(),
          _buildRecommendationsTab(),
        ],
      ),
    );
  }

  Widget _buildOverviewTab() {
    final totalMonthly = _budgetService.getTotalMonthlyBudget();
    final totalYearly = _budgetService.getTotalYearlyBudget();
    final essential = _budgetService.getEssentialBudget();
    final nonEssential = totalMonthly - essential;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildBudgetSummaryCard(totalMonthly, totalYearly, essential, nonEssential),
          const SizedBox(height: 16),
          _buildBudgetBreakdownCard(),
          const SizedBox(height: 16),
          _buildBudgetItemsList(),
        ],
      ),
    );
  }

  Widget _buildBudgetSummaryCard(double monthly, double yearly, double essential, double nonEssential) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Résumé du Budget',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildSummaryItem(
                    'Budget Mensuel',
                    '${monthly.toStringAsFixed(0)}€',
                    Colors.blue,
                    Icons.calendar_month,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildSummaryItem(
                    'Budget Annuel',
                    '${yearly.toStringAsFixed(0)}€',
                    Colors.green,
                    Icons.calendar_today,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildSummaryItem(
                    'Essentiel',
                    '${essential.toStringAsFixed(0)}€',
                    Colors.orange,
                    Icons.priority_high,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildSummaryItem(
                    'Non-essentiel',
                    '${nonEssential.toStringAsFixed(0)}€',
                    Colors.purple,
                    Icons.star,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: color,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildBudgetBreakdownCard() {
    final budgetByCategory = _budgetService.getBudgetByCategory();
    final total = _budgetService.getTotalMonthlyBudget();

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Répartition par Catégorie',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ...budgetByCategory.entries.map((entry) {
              if (entry.value > 0) {
                final percentage = total > 0 ? (entry.value / total * 100) : 0;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(BudgetItem.getCategoryDisplayName(entry.key)),
                          Text('${entry.value.toStringAsFixed(0)}€ (${percentage.toStringAsFixed(1)}%)'),
                        ],
                      ),
                      const SizedBox(height: 4),
                      LinearProgressIndicator(
                        value: total > 0 ? entry.value / total : 0,
                        backgroundColor: Colors.grey[300],
                        valueColor: AlwaysStoppedAnimation<Color>(_getCategoryColor(entry.key)),
                      ),
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildBudgetItemsList() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Détail des Dépenses',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ..._budgetItems.map((item) => _buildBudgetItemTile(item)).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildBudgetItemTile(BudgetItem item) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: _getCategoryColor(item.category).withOpacity(0.1),
        child: Icon(
          _getCategoryIcon(item.category),
          color: _getCategoryColor(item.category),
        ),
      ),
      title: Text(item.name),
      subtitle: Text(item.description ?? ''),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '${item.monthlyAmount.toStringAsFixed(0)}€/mois',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          if (item.frequency != 'monthly')
            Text(
              '(${item.amount.toStringAsFixed(0)}€/${item.frequency == 'yearly' ? 'an' : 'fois'})',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
        ],
      ),
      isThreeLine: false,
    );
  }

  Widget _buildCategoryTab() {
    final budgetByCategory = _budgetService.getBudgetByCategory();
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: budgetByCategory.entries
            .where((entry) => entry.value > 0)
            .map((entry) => _buildCategoryCard(entry.key, entry.value))
            .toList(),
      ),
    );
  }

  Widget _buildCategoryCard(BudgetCategory category, double amount) {
    final items = _budgetItems.where((item) => item.category == category).toList();
    
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(_getCategoryIcon(category), color: _getCategoryColor(category)),
                const SizedBox(width: 8),
                Text(
                  BudgetItem.getCategoryDisplayName(category),
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Text(
                  '${amount.toStringAsFixed(0)}€/mois',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...items.map((item) => Padding(
              padding: const EdgeInsets.only(left: 16, bottom: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(item.name),
                  Text('${item.monthlyAmount.toStringAsFixed(0)}€'),
                ],
              ),
            )).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildRecommendationsTab() {
    final recommendations = _budgetService.getBudgetRecommendations(_selectedCity);
    final currentTotal = _budgetService.getTotalMonthlyBudget();
    final recommendedTotal = recommendations['total'] ?? 0.0;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Recommandations par Ville',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  DropdownButton<String>(
                    value: _selectedCity,
                    isExpanded: true,
                    items: const [
                      DropdownMenuItem(value: 'France', child: Text('France (moyenne)')),
                      DropdownMenuItem(value: 'Paris', child: Text('Paris')),
                      DropdownMenuItem(value: 'Lyon', child: Text('Lyon')),
                      DropdownMenuItem(value: 'Marseille', child: Text('Marseille')),
                      DropdownMenuItem(value: 'Toulouse', child: Text('Toulouse')),
                      DropdownMenuItem(value: 'Nice', child: Text('Nice')),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _selectedCity = value!;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Budget Recommandé',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  _buildRecommendationItem('Logement', recommendations['logement'] ?? 0.0, Icons.home),
                  _buildRecommendationItem('Transport', recommendations['transport'] ?? 0.0, Icons.train),
                  _buildRecommendationItem('Alimentation', recommendations['alimentation'] ?? 0.0, Icons.restaurant),
                  const Divider(),
                  _buildRecommendationItem('Total Recommandé', recommendations['total'] ?? 0.0, Icons.calculate),
                  _buildRecommendationItem('Votre Budget', currentTotal, Icons.account_balance_wallet),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: currentTotal <= recommendedTotal ? Colors.green.withOpacity(0.1) : Colors.orange.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: currentTotal <= recommendedTotal ? Colors.green : Colors.orange,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          currentTotal <= recommendedTotal ? Icons.check_circle : Icons.warning,
                          color: currentTotal <= recommendedTotal ? Colors.green : Colors.orange,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            currentTotal <= recommendedTotal
                                ? 'Votre budget est dans les normes recommandées !'
                                : 'Votre budget dépasse les recommandations. Considérez réduire certaines dépenses.',
                            style: TextStyle(
                              color: currentTotal <= recommendedTotal ? Colors.green : Colors.orange,
                              fontWeight: FontWeight.bold,
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
        ],
      ),
    );
  }

  Widget _buildRecommendationItem(String label, double amount, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, size: 20),
          const SizedBox(width: 12),
          Expanded(child: Text(label)),
          Text(
            '${amount.toStringAsFixed(0)}€/mois',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Color _getCategoryColor(BudgetCategory category) {
    switch (category) {
      case BudgetCategory.housing:
        return Colors.blue;
      case BudgetCategory.food:
        return Colors.green;
      case BudgetCategory.transport:
        return Colors.orange;
      case BudgetCategory.health:
        return Colors.red;
      case BudgetCategory.education:
        return Colors.purple;
      case BudgetCategory.entertainment:
        return Colors.pink;
      case BudgetCategory.miscellaneous:
        return Colors.grey;
    }
  }

  IconData _getCategoryIcon(BudgetCategory category) {
    switch (category) {
      case BudgetCategory.housing:
        return Icons.home;
      case BudgetCategory.food:
        return Icons.restaurant;
      case BudgetCategory.transport:
        return Icons.train;
      case BudgetCategory.health:
        return Icons.health_and_safety;
      case BudgetCategory.education:
        return Icons.school;
      case BudgetCategory.entertainment:
        return Icons.movie;
      case BudgetCategory.miscellaneous:
        return Icons.more_horiz;
    }
  }
}
