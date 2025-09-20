import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/budget_item.dart';

class BudgetCalculatorService {
  static BudgetCalculatorService? _instance;
  static BudgetCalculatorService get instance => _instance ??= BudgetCalculatorService._();
  BudgetCalculatorService._();

  static const String _budgetKey = 'student_budget';
  List<BudgetItem> _budgetItems = [];

  List<BudgetItem> get budgetItems => List.unmodifiable(_budgetItems);

  /// Initialise le budget avec les éléments par défaut
  Future<void> initializeBudget() async {
    if (_budgetItems.isNotEmpty) return;
    _budgetItems = _getDefaultBudgetItems();
    await _saveBudget();
  }

  /// Obtient le budget par défaut pour un étudiant
  List<BudgetItem> _getDefaultBudgetItems() {
    return [
      BudgetItem(
        id: 'rent',
        name: 'Loyer',
        category: BudgetCategory.housing,
        amount: 400.0,
        frequency: 'monthly',
        description: 'Loyer mensuel (studio ou colocation)',
        isEssential: true,
      ),
      BudgetItem(
        id: 'utilities',
        name: 'Charges (eau, électricité, gaz)',
        category: BudgetCategory.housing,
        amount: 80.0,
        frequency: 'monthly',
        description: 'Charges mensuelles',
        isEssential: true,
      ),
      BudgetItem(
        id: 'groceries',
        name: 'Courses alimentaires',
        category: BudgetCategory.food,
        amount: 200.0,
        frequency: 'monthly',
        description: 'Courses mensuelles',
        isEssential: true,
      ),
      BudgetItem(
        id: 'transport_pass',
        name: 'Abonnement transport',
        category: BudgetCategory.transport,
        amount: 25.0,
        frequency: 'monthly',
        description: 'Pass Navigo, TCL, RTM, etc.',
        isEssential: true,
      ),
      BudgetItem(
        id: 'health_insurance',
        name: 'Mutuelle santé',
        category: BudgetCategory.health,
        amount: 30.0,
        frequency: 'monthly',
        description: 'Mutuelle étudiante complémentaire',
        isEssential: true,
      ),
      BudgetItem(
        id: 'tuition_fees',
        name: 'Frais de scolarité',
        category: BudgetCategory.education,
        amount: 243.0,
        frequency: 'yearly',
        description: 'Frais de scolarité universitaire (Master)',
        isEssential: true,
      ),
      BudgetItem(
        id: 'phone',
        name: 'Téléphone',
        category: BudgetCategory.miscellaneous,
        amount: 20.0,
        frequency: 'monthly',
        description: 'Forfait mobile',
        isEssential: true,
      ),
    ];
  }

  /// Calcule le budget total mensuel
  double getTotalMonthlyBudget() {
    return _budgetItems.fold(0.0, (sum, item) => sum + item.monthlyAmount);
  }

  /// Calcule le budget total annuel
  double getTotalYearlyBudget() {
    return _budgetItems.fold(0.0, (sum, item) => sum + item.yearlyAmount);
  }

  /// Calcule le budget par catégorie
  Map<BudgetCategory, double> getBudgetByCategory() {
    final Map<BudgetCategory, double> budgetByCategory = {};
    
    for (final category in BudgetCategory.values) {
      budgetByCategory[category] = _budgetItems
          .where((item) => item.category == category)
          .fold(0.0, (sum, item) => sum + item.monthlyAmount);
    }
    
    return budgetByCategory;
  }

  /// Calcule le budget essentiel
  double getEssentialBudget() {
    return _budgetItems
        .where((item) => item.isEssential)
        .fold(0.0, (sum, item) => sum + item.monthlyAmount);
  }

  /// Obtient les recommandations de budget selon la ville
  Map<String, double> getBudgetRecommendations(String city) {
    switch (city.toLowerCase()) {
      case 'paris':
        return {'logement': 600.0, 'transport': 35.0, 'alimentation': 250.0, 'total': 1200.0};
      case 'lyon':
        return {'logement': 450.0, 'transport': 25.0, 'alimentation': 200.0, 'total': 900.0};
      case 'marseille':
        return {'logement': 400.0, 'transport': 20.0, 'alimentation': 180.0, 'total': 800.0};
      default:
        return {'logement': 400.0, 'transport': 25.0, 'alimentation': 200.0, 'total': 900.0};
    }
  }

  /// Sauvegarde le budget
  Future<void> _saveBudget() async {
    final prefs = await SharedPreferences.getInstance();
    final budgetJson = _budgetItems.map((item) => _itemToJson(item)).toList();
    await prefs.setString(_budgetKey, jsonEncode(budgetJson));
  }

  /// Charge le budget
  Future<void> loadBudget() async {
    final prefs = await SharedPreferences.getInstance();
    final budgetString = prefs.getString(_budgetKey);
    
    if (budgetString != null) {
      final List<dynamic> budgetJson = jsonDecode(budgetString);
      _budgetItems = budgetJson.map((json) => _itemFromJson(json)).toList();
    } else {
      await initializeBudget();
    }
  }

  Map<String, dynamic> _itemToJson(BudgetItem item) {
    return {
      'id': item.id,
      'name': item.name,
      'category': item.category.index,
      'amount': item.amount,
      'frequency': item.frequency,
      'description': item.description,
      'isEssential': item.isEssential,
      'city': item.city,
    };
  }

  BudgetItem _itemFromJson(Map<String, dynamic> json) {
    return BudgetItem(
      id: json['id'],
      name: json['name'],
      category: BudgetCategory.values[json['category']],
      amount: json['amount'].toDouble(),
      frequency: json['frequency'],
      description: json['description'],
      isEssential: json['isEssential'] ?? false,
      city: json['city'],
    );
  }
}