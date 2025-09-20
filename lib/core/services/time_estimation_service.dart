import 'dart:math';
import '../../domain/entities/guide.dart';
import '../../domain/entities/user_profile.dart';

class TimeEstimationService {
  // Estimer le temps pour une étape de guide
  Duration estimateStepTime(GuideStep step, UserProfile profile) {
    int baseMinutes = 30; // Temps de base en minutes

    // Ajuster selon la complexité de l'étape
    if (step.requirements != null && step.requirements!.isNotEmpty) {
      baseMinutes += step.requirements!.length * 15; // +15 min par document requis
    }

    // Ajuster selon le niveau d'expérience
    switch (profile.level) {
      case UserLevel.beginner:
        baseMinutes = (baseMinutes * 1.5).round(); // +50% pour les débutants
        break;
      case UserLevel.intermediate:
        baseMinutes = (baseMinutes * 1.1).round(); // +10% pour les intermédiaires
        break;
      case UserLevel.advanced:
        baseMinutes = (baseMinutes * 0.8).round(); // -20% pour les avancés
        break;
    }

    // Ajuster selon le pays d'origine
    if (_isNonEUCountry(profile.countryOfOrigin)) {
      baseMinutes = (baseMinutes * 1.3).round(); // +30% pour les pays hors UE
    }

    // Ajuster selon l'université (Paris = plus long)
    if (profile.university.contains('Paris')) {
      baseMinutes = (baseMinutes * 1.2).round(); // +20% pour Paris
    }

    return Duration(minutes: baseMinutes);
  }

  // Estimer le temps total pour un guide
  Duration estimateGuideTime(Guide guide, UserProfile profile) {
    int totalMinutes = 0;

    for (final step in guide.steps) {
      totalMinutes += estimateStepTime(step, profile).inMinutes;
    }

    // Ajouter du temps pour la préparation et la révision
    totalMinutes = (totalMinutes * 1.2).round(); // +20% pour la préparation

    return Duration(minutes: totalMinutes);
  }

  // Estimer le temps de préparation
  Duration estimatePreparationTime(Guide guide, UserProfile profile) {
    int preparationMinutes = 15; // Temps de base

    // Ajuster selon le nombre d'étapes
    preparationMinutes += guide.steps.length * 5;

    // Ajuster selon la complexité
    if (guide.difficulty == 'Difficile') {
      preparationMinutes = (preparationMinutes * 1.5).round();
    } else if (guide.difficulty == 'Moyen') {
      preparationMinutes = (preparationMinutes * 1.2).round();
    }

    // Ajuster selon le niveau d'expérience
    switch (profile.level) {
      case UserLevel.beginner:
        preparationMinutes = (preparationMinutes * 1.3).round();
        break;
      case UserLevel.intermediate:
        preparationMinutes = (preparationMinutes * 1.1).round();
        break;
      case UserLevel.advanced:
        preparationMinutes = (preparationMinutes * 0.9).round();
        break;
    }

    return Duration(minutes: preparationMinutes);
  }

  // Estimer le temps d'attente
  Duration estimateWaitingTime(Guide guide, UserProfile profile) {
    int waitingDays = 0;

    // Temps d'attente selon la catégorie
    switch (guide.category) {
      case GuideCategory.visa:
        waitingDays = _isNonEUCountry(profile.countryOfOrigin) ? 30 : 15;
        break;
      case GuideCategory.housing:
        waitingDays = 7;
        break;
      case GuideCategory.banking:
        waitingDays = 3;
        break;
      case GuideCategory.health:
        waitingDays = 10;
        break;
      case GuideCategory.transport:
        waitingDays = 1;
        break;
      case GuideCategory.work:
        waitingDays = 14;
        break;
      case GuideCategory.education:
        waitingDays = 5;
        break;
      case GuideCategory.culture:
        waitingDays = 0;
        break;
      case GuideCategory.emergency:
        waitingDays = 1;
        break;
    }

    // Ajuster selon l'université
    if (profile.university.contains('Paris')) {
      waitingDays = (waitingDays * 1.5).round(); // +50% pour Paris
    }

    return Duration(days: waitingDays);
  }

  // Estimer le temps total avec attente
  Duration estimateTotalTime(Guide guide, UserProfile profile) {
    final activeTime = estimateGuideTime(guide, profile);
    final waitingTime = estimateWaitingTime(guide, profile);
    
    return Duration(
      days: activeTime.inDays + waitingTime.inDays,
      hours: activeTime.inHours.remainder(24) + waitingTime.inHours.remainder(24),
      minutes: activeTime.inMinutes.remainder(60) + waitingTime.inMinutes.remainder(60),
    );
  }

  // Générer un plan de temps détaillé
  Map<String, dynamic> generateTimePlan(Guide guide, UserProfile profile) {
    final preparationTime = estimatePreparationTime(guide, profile);
    final totalActiveTime = estimateGuideTime(guide, profile);
    final waitingTime = estimateWaitingTime(guide, profile);
    final totalTime = estimateTotalTime(guide, profile);

    final stepTimes = <Map<String, dynamic>>[];
    for (int i = 0; i < guide.steps.length; i++) {
      final step = guide.steps[i];
      final stepTime = estimateStepTime(step, profile);
      
      stepTimes.add({
        'stepNumber': i + 1,
        'title': step.title,
        'estimatedTime': stepTime,
        'estimatedMinutes': stepTime.inMinutes,
        'difficulty': _calculateStepDifficulty(step, profile),
      });
    }

    return {
      'preparationTime': preparationTime,
      'totalActiveTime': totalActiveTime,
      'waitingTime': waitingTime,
      'totalTime': totalTime,
      'stepTimes': stepTimes,
      'recommendations': _generateTimeRecommendations(guide, profile),
      'deadlines': _generateDeadlines(guide, profile),
    };
  }

  // Calculer la difficulté d'une étape
  String _calculateStepDifficulty(GuideStep step, UserProfile profile) {
    int difficultyScore = 0;

    // Score de base
    difficultyScore += 1;

    // Ajuster selon les documents requis
    if (step.requirements != null) {
      difficultyScore += step.requirements!.length;
    }

    // Ajuster selon le niveau d'expérience
    switch (profile.level) {
      case UserLevel.beginner:
        difficultyScore += 2;
        break;
      case UserLevel.intermediate:
        difficultyScore += 1;
        break;
      case UserLevel.advanced:
        difficultyScore += 0;
        break;
    }

    // Ajuster selon le pays
    if (_isNonEUCountry(profile.countryOfOrigin)) {
      difficultyScore += 1;
    }

    if (difficultyScore <= 2) return 'Facile';
    if (difficultyScore <= 4) return 'Moyen';
    return 'Difficile';
  }

  // Générer des recommandations de temps
  List<String> _generateTimeRecommendations(Guide guide, UserProfile profile) {
    final recommendations = <String>[];

    // Recommandations selon le niveau
    switch (profile.level) {
      case UserLevel.beginner:
        recommendations.add('Prévoyez 50% de temps en plus pour chaque étape');
        recommendations.add('Prenez des pauses régulières pour éviter la surcharge');
        recommendations.add('N\'hésitez pas à demander de l\'aide si nécessaire');
        break;
      case UserLevel.intermediate:
        recommendations.add('Vous pouvez suivre le planning normal');
        recommendations.add('Prévoyez un peu de temps de marge pour les imprévus');
        break;
      case UserLevel.advanced:
        recommendations.add('Vous pouvez accélérer le processus');
        recommendations.add('Aidez d\'autres étudiants si vous avez le temps');
        break;
    }

    // Recommandations selon le pays
    if (_isNonEUCountry(profile.countryOfOrigin)) {
      recommendations.add('Les démarches peuvent prendre plus de temps pour les non-ressortissants UE');
      recommendations.add('Vérifiez les délais spécifiques à votre pays d\'origine');
    }

    // Recommandations selon l'université
    if (profile.university.contains('Paris')) {
      recommendations.add('Les démarches à Paris peuvent être plus longues, prévoyez du temps');
      recommendations.add('Évitez les heures de pointe pour les rendez-vous');
    }

    // Recommandations générales
    recommendations.add('Commencez tôt le matin pour être plus efficace');
    recommendations.add('Préparez tous les documents à l\'avance');
    recommendations.add('Gardez une trace de vos démarches');

    return recommendations;
  }

  // Générer des échéances
  List<Map<String, dynamic>> _generateDeadlines(Guide guide, UserProfile profile) {
    final deadlines = <Map<String, dynamic>>[];
    final now = DateTime.now();
    
    // Échéance de préparation
    deadlines.add({
      'title': 'Préparation',
      'deadline': now.add(estimatePreparationTime(guide, profile)),
      'type': 'preparation',
      'priority': 'high',
    });

    // Échéances par étape
    DateTime currentDeadline = now.add(estimatePreparationTime(guide, profile));
    for (int i = 0; i < guide.steps.length; i++) {
      final step = guide.steps[i];
      final stepTime = estimateStepTime(step, profile);
      currentDeadline = currentDeadline.add(stepTime);
      
      deadlines.add({
        'title': 'Étape ${i + 1}: ${step.title}',
        'deadline': currentDeadline,
        'type': 'step',
        'priority': i == 0 ? 'high' : 'medium',
      });
    }

    // Échéance finale
    deadlines.add({
      'title': 'Finalisation',
      'deadline': now.add(estimateTotalTime(guide, profile)),
      'type': 'completion',
      'priority': 'high',
    });

    return deadlines;
  }

  // Vérifier si le pays est hors UE
  bool _isNonEUCountry(String country) {
    const euCountries = [
      'Allemagne', 'Belgique', 'Espagne', 'Italie', 'Portugal', 'Royaume-Uni'
    ];
    return !euCountries.contains(country);
  }

  // Formater une durée en texte lisible
  String formatDuration(Duration duration) {
    if (duration.inDays > 0) {
      return '${duration.inDays} jour${duration.inDays > 1 ? 's' : ''}';
    } else if (duration.inHours > 0) {
      return '${duration.inHours} heure${duration.inHours > 1 ? 's' : ''}';
    } else if (duration.inMinutes > 0) {
      return '${duration.inMinutes} minute${duration.inMinutes > 1 ? 's' : ''}';
    } else {
      return '${duration.inSeconds} seconde${duration.inSeconds > 1 ? 's' : ''}';
    }
  }

  // Obtenir une estimation rapide
  String getQuickEstimate(Guide guide, UserProfile profile) {
    final totalTime = estimateTotalTime(guide, profile);
    return formatDuration(totalTime);
  }

  // Calculer la probabilité de réussite dans les temps
  double calculateSuccessProbability(Guide guide, UserProfile profile) {
    double probability = 0.8; // Probabilité de base

    // Ajuster selon le niveau d'expérience
    switch (profile.level) {
      case UserLevel.beginner:
        probability -= 0.2;
        break;
      case UserLevel.intermediate:
        probability -= 0.1;
        break;
      case UserLevel.advanced:
        probability += 0.1;
        break;
    }

    // Ajuster selon le pays
    if (_isNonEUCountry(profile.countryOfOrigin)) {
      probability -= 0.15;
    }

    // Ajuster selon l'université
    if (profile.university.contains('Paris')) {
      probability -= 0.1;
    }

    // Ajuster selon la difficulté
    if (guide.difficulty == 'Difficile') {
      probability -= 0.2;
    } else if (guide.difficulty == 'Moyen') {
      probability -= 0.1;
    }

    return probability.clamp(0.0, 1.0);
  }
}
