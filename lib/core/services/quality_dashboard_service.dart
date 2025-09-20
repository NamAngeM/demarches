import 'dart:math';

class QualityDashboardService {
  // Métriques principales
  static QualityMetrics getCurrentMetrics() {
    return QualityMetrics(
      codeQualityScore: 87,
      securityScore: 92,
      performanceScore: 78,
      uxScore: 85,
      testCoverage: 73,
      technicalDebt: 65,
      lastUpdated: DateTime.now(),
    );
  }

  // Évolution des scores sur 4 semaines
  static List<WeeklyMetrics> getWeeklyTrends() {
    return [
      WeeklyMetrics(
        week: 1,
        codeQuality: 82,
        security: 88,
        performance: 75,
        ux: 80,
        testCoverage: 68,
        technicalDebt: 72,
      ),
      WeeklyMetrics(
        week: 2,
        codeQuality: 85,
        security: 90,
        performance: 76,
        ux: 82,
        testCoverage: 70,
        technicalDebt: 70,
      ),
      WeeklyMetrics(
        week: 3,
        codeQuality: 87,
        security: 91,
        performance: 77,
        ux: 84,
        testCoverage: 72,
        technicalDebt: 68,
      ),
      WeeklyMetrics(
        week: 4,
        codeQuality: 87,
        security: 92,
        performance: 78,
        ux: 85,
        testCoverage: 73,
        technicalDebt: 65,
      ),
    ];
  }

  // Benchmarks industriels Flutter
  static IndustryBenchmarks getIndustryBenchmarks() {
    return IndustryBenchmarks(
      codeQuality: 85,
      security: 88,
      performance: 82,
      ux: 87,
      testCoverage: 80,
      technicalDebt: 70,
    );
  }

  // Alertes et problèmes
  static List<QualityAlert> getCriticalAlerts() {
    return [
      QualityAlert(
        id: 'memory_leak_001',
        title: 'Memory Leak Détecté',
        description: 'Fuite mémoire dans la gestion des images lors du scroll rapide',
        severity: AlertSeverity.critical,
        category: AlertCategory.performance,
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
        status: AlertStatus.open,
        priority: 1,
      ),
      QualityAlert(
        id: 'security_vuln_001',
        title: 'Vulnerabilité de Sécurité',
        description: 'Dépendance obsolète avec CVE-2024-1234 dans package http',
        severity: AlertSeverity.critical,
        category: AlertCategory.security,
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        status: AlertStatus.open,
        priority: 1,
      ),
    ];
  }

  static List<QualityAlert> getRegressions() {
    return [
      QualityAlert(
        id: 'perf_regression_001',
        title: 'Performance Dégradée',
        description: 'Temps de chargement +15% depuis la v1.2.0',
        severity: AlertSeverity.high,
        category: AlertCategory.performance,
        createdAt: DateTime.now().subtract(const Duration(days: 3)),
        status: AlertStatus.open,
        priority: 2,
      ),
      QualityAlert(
        id: 'test_failure_001',
        title: 'Tests Échoués',
        description: '3 tests d\'intégration échouent après mise à jour',
        severity: AlertSeverity.medium,
        category: AlertCategory.testing,
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        status: AlertStatus.open,
        priority: 3,
      ),
    ];
  }

  static List<QualityAlert> getImprovements() {
    return [
      QualityAlert(
        id: 'security_improvement_001',
        title: 'Sécurité Renforcée',
        description: 'Score de sécurité passé de 85 à 92 grâce aux audits',
        severity: AlertSeverity.info,
        category: AlertCategory.security,
        createdAt: DateTime.now().subtract(const Duration(days: 5)),
        status: AlertStatus.resolved,
        priority: 4,
      ),
      QualityAlert(
        id: 'ux_improvement_001',
        title: 'UX Améliorée',
        description: 'Temps de réponse utilisateur -30% avec optimisations',
        severity: AlertSeverity.info,
        category: AlertCategory.ux,
        createdAt: DateTime.now().subtract(const Duration(days: 7)),
        status: AlertStatus.resolved,
        priority: 4,
      ),
    ];
  }

  // Métriques de velocity et issues
  static VelocityMetrics getVelocityMetrics() {
    return VelocityMetrics(
      currentVelocity: 12.5,
      velocityTrend: 0.8, // +8% par rapport à la semaine précédente
      issuesResolved: 24,
      issuesCreated: 18,
      averageResolutionTime: 2.3, // jours
      backlogSize: 45,
    );
  }

  // Heat map des problèmes
  static List<ProblemHeatMapData> getProblemHeatMap() {
    final random = Random();
    final data = <ProblemHeatMapData>[];
    
    // Générer des données pour 4 semaines
    for (int week = 0; week < 4; week++) {
      for (int day = 0; day < 7; day++) {
        final intensity = random.nextDouble();
        final problemCount = (intensity * 10).round();
        
        data.add(ProblemHeatMapData(
          week: week + 1,
          day: day + 1,
          intensity: intensity,
          problemCount: problemCount,
          date: DateTime.now().subtract(Duration(days: (3 - week) * 7 + (6 - day))),
        ));
      }
    }
    
    return data;
  }

  // Recommandations roadmap
  static List<RoadmapRecommendation> getRoadmapRecommendations() {
    return [
      RoadmapRecommendation(
        id: 'perf_optimization',
        title: 'Optimisation des Performances',
        description: 'Améliorer le score de performance de 78 à 85+',
        priority: RecommendationPriority.high,
        category: RecommendationCategory.performance,
        estimatedEffort: '2-3 semaines',
        impact: 'Amélioration significative de l\'expérience utilisateur',
        status: RecommendationStatus.pending,
      ),
      RoadmapRecommendation(
        id: 'test_coverage',
        title: 'Augmentation de la Couverture de Tests',
        description: 'Atteindre 80% de couverture de tests',
        priority: RecommendationPriority.medium,
        category: RecommendationCategory.testing,
        estimatedEffort: '3-4 semaines',
        impact: 'Réduction des bugs en production',
        status: RecommendationStatus.pending,
      ),
      RoadmapRecommendation(
        id: 'technical_debt',
        title: 'Réduction de la Dette Technique',
        description: 'Refactoriser le code legacy et améliorer la qualité',
        priority: RecommendationPriority.low,
        category: RecommendationCategory.maintenance,
        estimatedEffort: '4-6 semaines',
        impact: 'Amélioration de la maintenabilité',
        status: RecommendationStatus.pending,
      ),
    ];
  }

  // Calculer le score global de qualité
  static double calculateOverallQualityScore() {
    final metrics = getCurrentMetrics();
    return (metrics.codeQualityScore + 
            metrics.securityScore + 
            metrics.performanceScore + 
            metrics.uxScore + 
            (100 - metrics.technicalDebt)) / 5;
  }

  // Obtenir le statut de qualité global
  static QualityStatus getOverallQualityStatus() {
    final score = calculateOverallQualityScore();
    
    if (score >= 90) return QualityStatus.excellent;
    if (score >= 80) return QualityStatus.good;
    if (score >= 70) return QualityStatus.fair;
    if (score >= 60) return QualityStatus.poor;
    return QualityStatus.critical;
  }

  // Générer un rapport exécutif
  static ExecutiveSummary generateExecutiveSummary() {
    final metrics = getCurrentMetrics();
    final status = getOverallQualityStatus();
    final velocity = getVelocityMetrics();
    
    return ExecutiveSummary(
      overallScore: calculateOverallQualityScore(),
      status: status,
      keyStrengths: [
        'Sécurité excellente (92/100)',
        'Qualité de code élevée (87/100)',
        'Expérience utilisateur solide (85/100)',
      ],
      keyConcerns: [
        'Performance à améliorer (78/100)',
        'Couverture de tests insuffisante (73%)',
        'Dette technique élevée (65/100)',
      ],
      recommendations: [
        'Prioriser l\'optimisation des performances',
        'Augmenter la couverture de tests',
        'Planifier la réduction de la dette technique',
      ],
      velocity: velocity.currentVelocity,
      issuesTrend: velocity.issuesResolved - velocity.issuesCreated,
    );
  }
}

// Modèles de données
class QualityMetrics {
  final int codeQualityScore;
  final int securityScore;
  final int performanceScore;
  final int uxScore;
  final int testCoverage;
  final int technicalDebt;
  final DateTime lastUpdated;

  const QualityMetrics({
    required this.codeQualityScore,
    required this.securityScore,
    required this.performanceScore,
    required this.uxScore,
    required this.testCoverage,
    required this.technicalDebt,
    required this.lastUpdated,
  });
}

class WeeklyMetrics {
  final int week;
  final int codeQuality;
  final int security;
  final int performance;
  final int ux;
  final int testCoverage;
  final int technicalDebt;

  const WeeklyMetrics({
    required this.week,
    required this.codeQuality,
    required this.security,
    required this.performance,
    required this.ux,
    required this.testCoverage,
    required this.technicalDebt,
  });
}

class IndustryBenchmarks {
  final int codeQuality;
  final int security;
  final int performance;
  final int ux;
  final int testCoverage;
  final int technicalDebt;

  const IndustryBenchmarks({
    required this.codeQuality,
    required this.security,
    required this.performance,
    required this.ux,
    required this.testCoverage,
    required this.technicalDebt,
  });
}

class QualityAlert {
  final String id;
  final String title;
  final String description;
  final AlertSeverity severity;
  final AlertCategory category;
  final DateTime createdAt;
  final AlertStatus status;
  final int priority;

  const QualityAlert({
    required this.id,
    required this.title,
    required this.description,
    required this.severity,
    required this.category,
    required this.createdAt,
    required this.status,
    required this.priority,
  });
}

class VelocityMetrics {
  final double currentVelocity;
  final double velocityTrend;
  final int issuesResolved;
  final int issuesCreated;
  final double averageResolutionTime;
  final int backlogSize;

  const VelocityMetrics({
    required this.currentVelocity,
    required this.velocityTrend,
    required this.issuesResolved,
    required this.issuesCreated,
    required this.averageResolutionTime,
    required this.backlogSize,
  });
}

class ProblemHeatMapData {
  final int week;
  final int day;
  final double intensity;
  final int problemCount;
  final DateTime date;

  const ProblemHeatMapData({
    required this.week,
    required this.day,
    required this.intensity,
    required this.problemCount,
    required this.date,
  });
}

class RoadmapRecommendation {
  final String id;
  final String title;
  final String description;
  final RecommendationPriority priority;
  final RecommendationCategory category;
  final String estimatedEffort;
  final String impact;
  final RecommendationStatus status;

  const RoadmapRecommendation({
    required this.id,
    required this.title,
    required this.description,
    required this.priority,
    required this.category,
    required this.estimatedEffort,
    required this.impact,
    required this.status,
  });
}

class ExecutiveSummary {
  final double overallScore;
  final QualityStatus status;
  final List<String> keyStrengths;
  final List<String> keyConcerns;
  final List<String> recommendations;
  final double velocity;
  final int issuesTrend;

  const ExecutiveSummary({
    required this.overallScore,
    required this.status,
    required this.keyStrengths,
    required this.keyConcerns,
    required this.recommendations,
    required this.velocity,
    required this.issuesTrend,
  });
}

// Enums
enum AlertSeverity { critical, high, medium, low, info }
enum AlertCategory { performance, security, testing, ux, maintenance, bug }
enum AlertStatus { open, inProgress, resolved, closed }
enum QualityStatus { excellent, good, fair, poor, critical }
enum RecommendationPriority { high, medium, low }
enum RecommendationCategory { performance, security, testing, ux, maintenance, feature }
enum RecommendationStatus { pending, inProgress, completed, cancelled }
