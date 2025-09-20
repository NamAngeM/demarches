import '../../domain/entities/user_profile.dart';

class BudgetBreakdown {
  final double totalMonthly;
  final Map<String, double> breakdown;
  final List<String> recommendations;

  const BudgetBreakdown({
    required this.totalMonthly,
    required this.breakdown,
    required this.recommendations,
  });
}

class InstallationBudget {
  final double totalCost;
  final Map<String, double> breakdown;
  final List<String> recommendations;

  const InstallationBudget({
    required this.totalCost,
    required this.breakdown,
    required this.recommendations,
  });
}

class SavingsCalculation {
  final double totalMonthlySavings;
  final Map<String, double> potentialSavings;
  final List<String> recommendations;

  const SavingsCalculation({
    required this.totalMonthlySavings,
    required this.potentialSavings,
    required this.recommendations,
  });
}

class BudgetCalculatorService {
  static BudgetBreakdown calculateMonthlyBudget(UserProfile userProfile) {
    // Calculs basés sur le profil utilisateur
    final breakdown = <String, double>{
      'Logement': 600.0,
      'Nourriture': 300.0,
      'Transport': 50.0,
      'Santé': 30.0,
      'Loisirs': 100.0,
      'Divers': 50.0,
    };

    final total = breakdown.values.fold(0.0, (sum, value) => sum + value);

    final recommendations = [
      'Cherchez un logement en colocation pour réduire les coûts',
      'Utilisez les transports en commun avec un abonnement étudiant',
      'Profitez des restaurants universitaires pour les repas',
    ];

    return BudgetBreakdown(
      totalMonthly: total,
      breakdown: breakdown,
      recommendations: recommendations,
    );
  }

  static InstallationBudget calculateInstallationBudget(UserProfile userProfile) {
    final breakdown = <String, double>{
      'Caution logement': 1200.0,
      'Premier loyer': 600.0,
      'Assurance habitation': 100.0,
      'Mobilier de base': 500.0,
      'Équipement cuisine': 200.0,
      'Frais administratifs': 150.0,
    };

    final total = breakdown.values.fold(0.0, (sum, value) => sum + value);

    final recommendations = [
      'Prévoyez 3 mois de loyer en avance',
      'Achetez du mobilier d\'occasion',
      'Comparez les assurances habitation',
    ];

    return InstallationBudget(
      totalCost: total,
      breakdown: breakdown,
      recommendations: recommendations,
    );
  }

  static SavingsCalculation calculateSavings(UserProfile userProfile) {
    final potentialSavings = <String, double>{
      'Logement en colocation': 200.0,
      'Transport étudiant': 30.0,
      'Restaurants universitaires': 50.0,
      'Réductions étudiantes': 20.0,
    };

    final total = potentialSavings.values.fold(0.0, (sum, value) => sum + value);

    final recommendations = [
      'Demandez la carte étudiante pour les réductions',
      'Utilisez les services gratuits de l\'université',
      'Partagez les coûts avec d\'autres étudiants',
    ];

    return SavingsCalculation(
      totalMonthlySavings: total,
      potentialSavings: potentialSavings,
      recommendations: recommendations,
    );
  }
}