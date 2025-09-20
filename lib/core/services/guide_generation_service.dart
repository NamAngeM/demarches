import 'dart:math';
import '../../domain/entities/guide.dart';
import '../../domain/entities/user_profile.dart';
import '../../data/services/firestore_guide_service.dart';

class GuideGenerationService {
  final FirestoreGuideService _guideService = FirestoreGuideService();

  // Générer des guides personnalisés selon le profil utilisateur
  Future<List<Guide>> generatePersonalizedGuides(UserProfile profile) async {
    try {
      final allGuides = await _guideService.getAllGuides();
      final personalizedGuides = <Guide>[];

      // Guides prioritaires selon le pays d'origine
      final countryGuides = _getGuidesByCountry(allGuides, profile.countryOfOrigin);
      personalizedGuides.addAll(countryGuides);

      // Guides selon le niveau d'expérience
      final levelGuides = _getGuidesByLevel(allGuides, profile.level);
      personalizedGuides.addAll(levelGuides);

      // Guides selon l'université
      final universityGuides = _getGuidesByUniversity(allGuides, profile.university);
      personalizedGuides.addAll(universityGuides);

      // Guides essentiels pour tous
      final essentialGuides = _getEssentialGuides(allGuides);
      personalizedGuides.addAll(essentialGuides);

      // Supprimer les doublons et trier par priorité
      final uniqueGuides = _removeDuplicatesAndSort(personalizedGuides, profile);

      return uniqueGuides.take(10).toList();
    } catch (e) {
      print('Erreur lors de la génération de guides personnalisés: $e');
      return [];
    }
  }

  // Obtenir les guides prioritaires selon le pays d'origine
  List<Guide> _getGuidesByCountry(List<Guide> guides, String country) {
    final countryPriorities = {
      'Allemagne': ['visa', 'banking', 'health'],
      'Belgique': ['visa', 'housing', 'transport'],
      'Canada': ['visa', 'banking', 'work'],
      'Espagne': ['visa', 'housing', 'culture'],
      'États-Unis': ['visa', 'banking', 'work'],
      'Italie': ['visa', 'housing', 'culture'],
      'Maroc': ['visa', 'housing', 'health'],
      'Portugal': ['visa', 'housing', 'culture'],
      'Royaume-Uni': ['visa', 'banking', 'work'],
      'Suisse': ['visa', 'banking', 'health'],
      'Tunisie': ['visa', 'housing', 'health'],
    };

    final priorities = countryPriorities[country] ?? ['visa', 'housing', 'banking'];
    
    return guides.where((guide) {
      return priorities.contains(guide.category.name);
    }).toList();
  }

  // Obtenir les guides selon le niveau d'expérience
  List<Guide> _getGuidesByLevel(List<Guide> guides, UserLevel level) {
    switch (level) {
      case UserLevel.beginner:
        return guides.where((guide) {
          return guide.difficulty == 'Facile' && 
                 ['visa', 'housing', 'banking', 'health'].contains(guide.category.name);
        }).toList();
      
      case UserLevel.intermediate:
        return guides.where((guide) {
          return ['Facile', 'Moyen'].contains(guide.difficulty) &&
                 ['work', 'education', 'transport'].contains(guide.category.name);
        }).toList();
      
      case UserLevel.advanced:
        return guides.where((guide) {
          return guide.difficulty == 'Difficile' &&
                 ['work', 'culture', 'emergency'].contains(guide.category.name);
        }).toList();
    }
  }

  // Obtenir les guides selon l'université
  List<Guide> _getGuidesByUniversity(List<Guide> guides, String university) {
    final universityKeywords = {
      'Paris': ['transport', 'culture', 'housing'],
      'Lyon': ['transport', 'housing', 'culture'],
      'Toulouse': ['transport', 'housing', 'culture'],
      'Lille': ['transport', 'housing', 'culture'],
      'Bordeaux': ['transport', 'housing', 'culture'],
      'Strasbourg': ['transport', 'housing', 'culture'],
      'Montpellier': ['transport', 'housing', 'culture'],
    };

    final keywords = universityKeywords.entries
        .where((entry) => university.contains(entry.key))
        .map((entry) => entry.value)
        .expand((list) => list)
        .toList();

    if (keywords.isEmpty) {
      return guides.where((guide) => guide.category.name == 'education').toList();
    }

    return guides.where((guide) {
      return keywords.contains(guide.category.name);
    }).toList();
  }

  // Obtenir les guides essentiels
  List<Guide> _getEssentialGuides(List<Guide> guides) {
    return guides.where((guide) {
      return guide.tags.contains('essentiel') || 
             guide.tags.contains('important') ||
             guide.category.name == 'visa';
    }).toList();
  }

  // Supprimer les doublons et trier par priorité
  List<Guide> _removeDuplicatesAndSort(List<Guide> guides, UserProfile profile) {
    final uniqueGuides = <String, Guide>{};
    
    for (final guide in guides) {
      uniqueGuides[guide.id] = guide;
    }

    final sortedGuides = uniqueGuides.values.toList();
    sortedGuides.sort((a, b) => _calculatePriority(b, profile).compareTo(_calculatePriority(a, profile)));

    return sortedGuides;
  }

  // Calculer la priorité d'un guide
  int _calculatePriority(Guide guide, UserProfile profile) {
    int priority = 0;

    // Priorité selon la catégorie
    final categoryPriorities = {
      'visa': 100,
      'housing': 90,
      'banking': 80,
      'health': 70,
      'transport': 60,
      'work': 50,
      'education': 40,
      'culture': 30,
      'emergency': 20,
    };
    priority += categoryPriorities[guide.category.name] ?? 0;

    // Priorité selon le niveau de difficulté
    final difficultyPriorities = {
      'Facile': 30,
      'Moyen': 20,
      'Difficile': 10,
    };
    priority += difficultyPriorities[guide.difficulty] ?? 0;

    // Priorité selon les tags
    if (guide.tags.contains('essentiel')) priority += 50;
    if (guide.tags.contains('important')) priority += 30;
    if (guide.tags.contains('urgent')) priority += 40;

    // Priorité selon le profil utilisateur
    if (guide.category.name == 'visa' && profile.isFirstTime) priority += 100;
    if (guide.category.name == 'housing' && profile.level == UserLevel.beginner) priority += 50;
    if (guide.category.name == 'work' && profile.level == UserLevel.advanced) priority += 30;

    return priority;
  }

  // Générer un plan d'action personnalisé
  Future<Map<String, dynamic>> generateActionPlan(UserProfile profile) async {
    try {
      final personalizedGuides = await generatePersonalizedGuides(profile);
      
      final actionPlan = {
        'userProfile': profile,
        'totalGuides': personalizedGuides.length,
        'estimatedDuration': _calculateTotalDuration(personalizedGuides),
        'priorityCategories': _getPriorityCategories(personalizedGuides),
        'weeklyPlan': _generateWeeklyPlan(personalizedGuides),
        'milestones': _generateMilestones(personalizedGuides),
        'recommendations': _generateRecommendations(profile, personalizedGuides),
      };

      return actionPlan;
    } catch (e) {
      print('Erreur lors de la génération du plan d\'action: $e');
      return {};
    }
  }

  // Calculer la durée totale estimée
  String _calculateTotalDuration(List<Guide> guides) {
    int totalDays = 0;
    
    for (final guide in guides) {
      final duration = guide.estimatedDuration.toLowerCase();
      if (duration.contains('semaine')) {
        final weeks = int.tryParse(duration.split(' ')[0]) ?? 1;
        totalDays += weeks * 7;
      } else if (duration.contains('jour')) {
        totalDays += int.tryParse(duration.split(' ')[0]) ?? 1;
      } else if (duration.contains('mois')) {
        final months = int.tryParse(duration.split(' ')[0]) ?? 1;
        totalDays += months * 30;
      }
    }

    if (totalDays < 7) {
      return '$totalDays jours';
    } else if (totalDays < 30) {
      final weeks = (totalDays / 7).ceil();
      return '$weeks semaine${weeks > 1 ? 's' : ''}';
    } else {
      final months = (totalDays / 30).ceil();
      return '$months mois';
    }
  }

  // Obtenir les catégories prioritaires
  List<String> _getPriorityCategories(List<Guide> guides) {
    final categoryCount = <String, int>{};
    
    for (final guide in guides) {
      categoryCount[guide.category.name] = (categoryCount[guide.category.name] ?? 0) + 1;
    }

    final sortedCategories = categoryCount.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return sortedCategories.take(3).map((e) => e.key).toList();
  }

  // Générer un plan hebdomadaire
  List<Map<String, dynamic>> _generateWeeklyPlan(List<Guide> guides) {
    final weeklyPlan = <Map<String, dynamic>>[];
    final shuffledGuides = List<Guide>.from(guides)..shuffle();

    for (int week = 1; week <= 4 && week <= guides.length; week++) {
      final weekGuides = shuffledGuides.take(2).toList();
      shuffledGuides.removeRange(0, weekGuides.length);

      weeklyPlan.add({
        'week': week,
        'guides': weekGuides.map((g) => {
          'id': g.id,
          'title': g.title,
          'category': g.category.name,
          'difficulty': g.difficulty,
          'estimatedDuration': g.estimatedDuration,
        }).toList(),
        'focus': _getWeekFocus(weekGuides),
      });
    }

    return weeklyPlan;
  }

  // Obtenir le focus de la semaine
  String _getWeekFocus(List<Guide> guides) {
    if (guides.isEmpty) return 'Aucun guide';
    
    final categories = guides.map((g) => g.category.name).toSet();
    if (categories.contains('visa')) return 'Visa et titres de séjour';
    if (categories.contains('housing')) return 'Logement et installation';
    if (categories.contains('banking')) return 'Finances et banque';
    if (categories.contains('health')) return 'Santé et assurance';
    if (categories.contains('work')) return 'Travail et emploi';
    if (categories.contains('education')) return 'Éducation et université';
    if (categories.contains('culture')) return 'Culture et intégration';
    
    return 'Diverses démarches';
  }

  // Générer les jalons
  List<Map<String, dynamic>> _generateMilestones(List<Guide> guides) {
    final milestones = <Map<String, dynamic>>[];
    int completedGuides = 0;

    for (int i = 0; i < guides.length; i += 3) {
      completedGuides += 3;
      final percentage = ((completedGuides / guides.length) * 100).round();
      
      milestones.add({
        'title': '${completedGuides} guides terminés',
        'description': 'Vous avez terminé $completedGuides guides sur ${guides.length}',
        'percentage': percentage,
        'isCompleted': false,
      });
    }

    return milestones;
  }

  // Générer des recommandations personnalisées
  List<String> _generateRecommendations(UserProfile profile, List<Guide> guides) {
    final recommendations = <String>[];

    // Recommandations selon le pays
    if (profile.countryOfOrigin == 'Maroc' || profile.countryOfOrigin == 'Tunisie') {
      recommendations.add('Commencez par les démarches de visa, elles peuvent prendre plus de temps');
    }

    // Recommandations selon le niveau
    if (profile.level == UserLevel.beginner) {
      recommendations.add('Priorisez les guides "Facile" pour commencer en douceur');
      recommendations.add('N\'hésitez pas à demander de l\'aide si vous avez des questions');
    } else if (profile.level == UserLevel.advanced) {
      recommendations.add('Vous pouvez vous attaquer aux guides plus complexes');
      recommendations.add('Aidez d\'autres étudiants en partageant votre expérience');
    }

    // Recommandations selon l'université
    if (profile.university.contains('Paris')) {
      recommendations.add('Les démarches à Paris peuvent être plus longues, prévoyez du temps');
    }

    // Recommandations générales
    recommendations.add('Consultez régulièrement l\'application pour de nouveaux guides');
    recommendations.add('Utilisez les rappels pour ne pas oublier vos démarches');

    return recommendations;
  }

  // Obtenir des guides similaires
  Future<List<Guide>> getSimilarGuides(String guideId) async {
    try {
      final allGuides = await _guideService.getAllGuides();
      final targetGuide = allGuides.firstWhere((g) => g.id == guideId);
      
      final similarGuides = allGuides.where((guide) {
        return guide.id != guideId &&
               (guide.category == targetGuide.category ||
                guide.tags.any((tag) => targetGuide.tags.contains(tag)));
      }).toList();

      return similarGuides.take(5).toList();
    } catch (e) {
      print('Erreur lors de la récupération des guides similaires: $e');
      return [];
    }
  }

  // Obtenir des guides populaires
  Future<List<Guide>> getPopularGuides({int limit = 10}) async {
    try {
      final allGuides = await _guideService.getAllGuides();
      
      // Simuler la popularité basée sur les tags et catégories
      final popularGuides = allGuides.where((guide) {
        return guide.tags.contains('populaire') ||
               guide.category.name == 'visa' ||
               guide.category.name == 'housing' ||
               guide.difficulty == 'Facile';
      }).toList();

      return popularGuides.take(limit).toList();
    } catch (e) {
      print('Erreur lors de la récupération des guides populaires: $e');
      return [];
    }
  }
}
