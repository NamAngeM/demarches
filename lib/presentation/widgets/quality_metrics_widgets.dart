import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../../core/theme/app_text_styles.dart';

class QualityMetricsWidgets {
  // Widget de métrique avec graphique circulaire
  static Widget circularMetricCard({
    required String title,
    required int score,
    required int maxScore,
    required Color color,
    required IconData icon,
    required String description,
    String? trend,
    Color? trendColor,
  }) {
    final percentage = (score / maxScore * 100).round();
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 24),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                if (trend != null) ...[
                  Icon(
                    trend.startsWith('+') ? Icons.trending_up : Icons.trending_down,
                    color: trendColor ?? (trend.startsWith('+') ? Colors.green : Colors.red),
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    trend,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: trendColor ?? (trend.startsWith('+') ? Colors.green : Colors.red),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 16),
            CircularPercentIndicator(
              radius: 50,
              lineWidth: 8,
              percent: percentage / 100,
              center: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '$score',
                    style: AppTextStyles.headline3.copyWith(
                      color: color,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '/$maxScore',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              progressColor: color,
              backgroundColor: color.withOpacity(0.2),
              animation: true,
              animationDuration: 1000,
            ),
            const SizedBox(height: 12),
            Text(
              _getScoreStatus(percentage),
              style: AppTextStyles.bodySmall.copyWith(
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: AppTextStyles.bodySmall.copyWith(
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  // Widget de métrique avec barre de progression
  static Widget linearMetricCard({
    required String title,
    required int score,
    required int maxScore,
    required Color color,
    required IconData icon,
    required String description,
    String? trend,
    Color? trendColor,
  }) {
    final percentage = (score / maxScore * 100).round();
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 24),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  '$score/$maxScore',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (trend != null) ...[
                  const SizedBox(width: 8),
                  Icon(
                    trend.startsWith('+') ? Icons.trending_up : Icons.trending_down,
                    color: trendColor ?? (trend.startsWith('+') ? Colors.green : Colors.red),
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    trend,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: trendColor ?? (trend.startsWith('+') ? Colors.green : Colors.red),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 12),
            LinearPercentIndicator(
              width: double.infinity,
              lineHeight: 8,
              percent: percentage / 100,
              backgroundColor: color.withOpacity(0.2),
              progressColor: color,
              barRadius: const Radius.circular(4),
              animation: true,
              animationDuration: 1000,
            ),
            const SizedBox(height: 8),
            Text(
              _getScoreStatus(percentage),
              style: AppTextStyles.bodySmall.copyWith(
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              description,
              style: AppTextStyles.bodySmall.copyWith(
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget de comparaison avec benchmarks
  static Widget benchmarkComparisonCard({
    required String title,
    required int ourScore,
    required int industryScore,
    required Color color,
    required IconData icon,
  }) {
    final isAbove = ourScore > industryScore;
    final trendColor = isAbove ? Colors.green : Colors.orange;
    final trendIcon = isAbove ? Icons.trending_up : Icons.trending_down;
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 24),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        'Notre Score',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '$ourScore',
                        style: AppTextStyles.headline3.copyWith(
                          color: color,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Icon(trendIcon, color: trendColor, size: 20),
                    const SizedBox(height: 4),
                    Text(
                      isAbove ? 'Au-dessus' : 'En-dessous',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: trendColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        'Moyenne Industrie',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '$industryScore',
                        style: AppTextStyles.headline3.copyWith(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Widget de graphique de tendances
  static Widget trendChart({
    required String title,
    required List<double> data,
    required List<String> labels,
    required Color color,
    required String unit,
  }) {
    final maxValue = data.reduce((a, b) => a > b ? a : b);
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: AppTextStyles.sectionTitle,
            ),
            const SizedBox(height: 16),
            Container(
              height: 150,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: data.asMap().entries.map((entry) {
                  final index = entry.key;
                  final value = entry.value;
                  final height = (value / maxValue) * 120;
                  
                  return Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(
                              height: height,
                              decoration: BoxDecoration(
                                color: color.withOpacity(0.7),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Center(
                                child: Text(
                                  '${value.toInt()}$unit',
                                  style: AppTextStyles.bodySmall.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            labels[index],
                            style: AppTextStyles.bodySmall,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget de heat map
  static Widget heatMap({
    required String title,
    required List<List<double>> data,
    required List<String> rowLabels,
    required List<String> colLabels,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: AppTextStyles.sectionTitle,
            ),
            const SizedBox(height: 16),
            Container(
              height: 200,
              child: Column(
                children: data.asMap().entries.map((rowEntry) {
                  final rowIndex = rowEntry.key;
                  final row = rowEntry.value;
                  
                  return Expanded(
                    child: Row(
                      children: [
                        // Label de ligne
                        Container(
                          width: 60,
                          child: Text(
                            rowLabels[rowIndex],
                            style: AppTextStyles.bodySmall,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(width: 8),
                        // Données de la ligne
                        ...row.asMap().entries.map((colEntry) {
                          final colIndex = colEntry.key;
                          final value = colEntry.value;
                          final intensity = value.clamp(0.0, 1.0);
                          final color = Color.lerp(Colors.green, Colors.red, intensity)!;
                          
                          return Expanded(
                            child: Container(
                              margin: const EdgeInsets.all(1),
                              decoration: BoxDecoration(
                                color: color,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Center(
                                child: Text(
                                  '${(value * 100).round()}',
                                  style: AppTextStyles.bodySmall.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 8),
            // Légende
            Row(
              children: [
                Text('Faible', style: AppTextStyles.bodySmall),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    height: 8,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.green, Colors.red],
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text('Élevé', style: AppTextStyles.bodySmall),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Widget d'alerte
  static Widget alertCard({
    required String title,
    required String description,
    required AlertSeverity severity,
    required AlertCategory category,
    required DateTime createdAt,
    required AlertStatus status,
    required int priority,
  }) {
    final color = _getSeverityColor(severity);
    final icon = _getCategoryIcon(category);
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    _getSeverityLabel(severity),
                    style: AppTextStyles.bodySmall.copyWith(
                      color: color,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: AppTextStyles.bodySmall,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  'Priorité: $priority',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
                const Spacer(),
                Text(
                  _getStatusLabel(status),
                  style: AppTextStyles.bodySmall.copyWith(
                    color: _getStatusColor(status),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Widget de recommandation
  static Widget recommendationCard({
    required String title,
    required String description,
    required RecommendationPriority priority,
    required RecommendationCategory category,
    required String estimatedEffort,
    required String impact,
    required RecommendationStatus status,
  }) {
    final color = _getPriorityColor(priority);
    final icon = _getCategoryIcon(category);
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    _getPriorityLabel(priority),
                    style: AppTextStyles.bodySmall.copyWith(
                      color: color,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: AppTextStyles.bodySmall,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Effort estimé',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                      Text(
                        estimatedEffort,
                        style: AppTextStyles.bodySmall.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Impact',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                      Text(
                        impact,
                        style: AppTextStyles.bodySmall.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Méthodes utilitaires
  static String _getScoreStatus(int percentage) {
    if (percentage >= 90) return 'Excellent';
    if (percentage >= 80) return 'Bon';
    if (percentage >= 70) return 'Moyen';
    if (percentage >= 60) return 'À améliorer';
    return 'Critique';
  }

  static Color _getSeverityColor(AlertSeverity severity) {
    switch (severity) {
      case AlertSeverity.critical: return Colors.red;
      case AlertSeverity.high: return Colors.orange;
      case AlertSeverity.medium: return Colors.blue;
      case AlertSeverity.low: return Colors.grey;
      case AlertSeverity.info: return Colors.green;
    }
  }

  static String _getSeverityLabel(AlertSeverity severity) {
    switch (severity) {
      case AlertSeverity.critical: return 'Critique';
      case AlertSeverity.high: return 'Élevée';
      case AlertSeverity.medium: return 'Moyenne';
      case AlertSeverity.low: return 'Faible';
      case AlertSeverity.info: return 'Info';
    }
  }

  static IconData _getCategoryIcon(dynamic category) {
    if (category is AlertCategory) {
      switch (category) {
        case AlertCategory.performance: return Icons.speed;
        case AlertCategory.security: return Icons.security;
        case AlertCategory.testing: return Icons.bug_report;
        case AlertCategory.ux: return Icons.design_services;
        case AlertCategory.maintenance: return Icons.construction;
        case AlertCategory.bug: return Icons.error;
      }
    } else if (category is RecommendationCategory) {
      switch (category) {
        case RecommendationCategory.performance: return Icons.speed;
        case RecommendationCategory.security: return Icons.security;
        case RecommendationCategory.testing: return Icons.bug_report;
        case RecommendationCategory.ux: return Icons.design_services;
        case RecommendationCategory.maintenance: return Icons.construction;
        case RecommendationCategory.feature: return Icons.add;
      }
    }
    return Icons.info;
  }

  static String _getStatusLabel(AlertStatus status) {
    switch (status) {
      case AlertStatus.open: return 'Ouvert';
      case AlertStatus.inProgress: return 'En cours';
      case AlertStatus.resolved: return 'Résolu';
      case AlertStatus.closed: return 'Fermé';
    }
  }

  static Color _getStatusColor(AlertStatus status) {
    switch (status) {
      case AlertStatus.open: return Colors.red;
      case AlertStatus.inProgress: return Colors.orange;
      case AlertStatus.resolved: return Colors.green;
      case AlertStatus.closed: return Colors.grey;
    }
  }

  static Color _getPriorityColor(RecommendationPriority priority) {
    switch (priority) {
      case RecommendationPriority.high: return Colors.red;
      case RecommendationPriority.medium: return Colors.orange;
      case RecommendationPriority.low: return Colors.blue;
    }
  }

  static String _getPriorityLabel(RecommendationPriority priority) {
    switch (priority) {
      case RecommendationPriority.high: return 'Haute';
      case RecommendationPriority.medium: return 'Moyenne';
      case RecommendationPriority.low: return 'Basse';
    }
  }
}

// Enums pour les widgets
enum AlertSeverity { critical, high, medium, low, info }
enum AlertCategory { performance, security, testing, ux, maintenance, bug }
enum AlertStatus { open, inProgress, resolved, closed }
enum RecommendationPriority { high, medium, low }
enum RecommendationCategory { performance, security, testing, ux, maintenance, feature }
enum RecommendationStatus { pending, inProgress, completed, cancelled }
