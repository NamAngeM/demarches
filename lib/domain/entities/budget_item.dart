import 'package:equatable/equatable.dart';

enum BudgetCategory {
  housing,
  food,
  transport,
  health,
  education,
  entertainment,
  miscellaneous,
}

class BudgetItem extends Equatable {
  final String id;
  final String name;
  final BudgetCategory category;
  final double amount;
  final String frequency; // monthly, yearly, oneTime
  final String? description;
  final bool isEssential;
  final String? city; // Pour les coûts spécifiques à la ville

  const BudgetItem({
    required this.id,
    required this.name,
    required this.category,
    required this.amount,
    required this.frequency,
    this.description,
    this.isEssential = false,
    this.city,
  });

  BudgetItem copyWith({
    String? id,
    String? name,
    BudgetCategory? category,
    double? amount,
    String? frequency,
    String? description,
    bool? isEssential,
    String? city,
  }) {
    return BudgetItem(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      amount: amount ?? this.amount,
      frequency: frequency ?? this.frequency,
      description: description ?? this.description,
      isEssential: isEssential ?? this.isEssential,
      city: city ?? this.city,
    );
  }

  double get monthlyAmount {
    switch (frequency) {
      case 'monthly':
        return amount;
      case 'yearly':
        return amount / 12;
      case 'oneTime':
        return amount;
      default:
        return amount;
    }
  }

  double get yearlyAmount {
    switch (frequency) {
      case 'monthly':
        return amount * 12;
      case 'yearly':
        return amount;
      case 'oneTime':
        return amount;
      default:
        return amount;
    }
  }

  String get categoryDisplayName {
    switch (category) {
      case BudgetCategory.housing:
        return 'Logement';
      case BudgetCategory.food:
        return 'Alimentation';
      case BudgetCategory.transport:
        return 'Transport';
      case BudgetCategory.health:
        return 'Santé';
      case BudgetCategory.education:
        return 'Éducation';
      case BudgetCategory.entertainment:
        return 'Loisirs';
      case BudgetCategory.miscellaneous:
        return 'Divers';
    }
  }

  static String getCategoryDisplayName(BudgetCategory category) {
    switch (category) {
      case BudgetCategory.housing:
        return 'Logement';
      case BudgetCategory.food:
        return 'Alimentation';
      case BudgetCategory.transport:
        return 'Transport';
      case BudgetCategory.health:
        return 'Santé';
      case BudgetCategory.education:
        return 'Éducation';
      case BudgetCategory.entertainment:
        return 'Loisirs';
      case BudgetCategory.miscellaneous:
        return 'Divers';
    }
  }

  @override
  List<Object?> get props => [
        id,
        name,
        category,
        amount,
        frequency,
        description,
        isEssential,
        city,
      ];
}
