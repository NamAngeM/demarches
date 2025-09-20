import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../../core/theme/app_text_styles.dart';
import '../widgets/buttons/buttons.dart';

class QualityDashboardPage extends ConsumerStatefulWidget {
  const QualityDashboardPage({super.key});

  @override
  ConsumerState<QualityDashboardPage> createState() => _QualityDashboardPageState();
}

class _QualityDashboardPageState extends ConsumerState<QualityDashboardPage> {
  int _selectedTimeframe = 0; // 0: 4 semaines, 1: 3 mois, 2: 6 mois
  String _selectedView = 'overview'; // overview, technical, trends, alerts

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quality Dashboard - Student Guide France'),
        actions: [
          AppIconButton(
            icon: Icons.refresh,
            onPressed: () {
              // TODO: Actualiser les données
            },
            tooltip: 'Actualiser',
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Column(
        children: [
          // Sélecteurs
          _buildSelectors(),
          
          // Contenu principal
          Expanded(
            child: _buildContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectors() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Sélecteur de période
          Row(
            children: [
              Text('Période:', style: AppTextStyles.bodyMedium),
              const SizedBox(width: 16),
              Expanded(
                child: Row(
                  children: [
                    _buildTimeframeButton('4 semaines', 0),
                    const SizedBox(width: 8),
                    _buildTimeframeButton('3 mois', 1),
                    const SizedBox(width: 8),
                    _buildTimeframeButton('6 mois', 2),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Sélecteur de vue
          Row(
            children: [
              Text('Vue:', style: AppTextStyles.bodyMedium),
              const SizedBox(width: 16),
              Expanded(
                child: Row(
                  children: [
                    _buildViewButton('Vue d\'ensemble', 'overview', Icons.dashboard),
                    const SizedBox(width: 8),
                    _buildViewButton('Technique', 'technical', Icons.code),
                    const SizedBox(width: 8),
                    _buildViewButton('Tendances', 'trends', Icons.trending_up),
                    const SizedBox(width: 8),
                    _buildViewButton('Alertes', 'alerts', Icons.warning),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimeframeButton(String label, int value) {
    final isSelected = _selectedTimeframe == value;
    return Expanded(
      child: AppButton(
        text: label,
        type: isSelected ? AppButtonType.primary : AppButtonType.outline,
        onPressed: () {
          setState(() {
            _selectedTimeframe = value;
          });
        },
      ),
    );
  }

  Widget _buildViewButton(String label, String value, IconData icon) {
    final isSelected = _selectedView == value;
    return Expanded(
      child: AppButton(
        text: label,
        icon: icon,
        type: isSelected ? AppButtonType.primary : AppButtonType.outline,
        onPressed: () {
          setState(() {
            _selectedView = value;
          });
        },
      ),
    );
  }

  Widget _buildContent() {
    switch (_selectedView) {
      case 'overview':
        return _buildOverviewView();
      case 'technical':
        return _buildTechnicalView();
      case 'trends':
        return _buildTrendsView();
      case 'alerts':
        return _buildAlertsView();
      default:
        return _buildOverviewView();
    }
  }

  Widget _buildOverviewView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Métriques principales
          _buildMainMetrics(),
          const SizedBox(height: 24),
          
          // Graphiques de progression
          _buildProgressCharts(),
          const SizedBox(height: 24),
          
          // Résumé exécutif
          _buildExecutiveSummary(),
        ],
      ),
    );
  }

  Widget _buildMainMetrics() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Métriques Principales',
              style: AppTextStyles.sectionTitle,
            ),
            const SizedBox(height: 16),
            
            Row(
              children: [
                Expanded(child: _buildMetricCard('Code Quality', 87, Colors.blue, Icons.code)),
                const SizedBox(width: 16),
                Expanded(child: _buildMetricCard('Security', 92, Colors.green, Icons.security)),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: _buildMetricCard('Performance', 78, Colors.orange, Icons.speed)),
                const SizedBox(width: 16),
                Expanded(child: _buildMetricCard('UX Score', 85, Colors.purple, Icons.design_services)),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: _buildMetricCard('Test Coverage', 73, Colors.teal, Icons.bug_report)),
                const SizedBox(width: 16),
                Expanded(child: _buildMetricCard('Technical Debt', 65, Colors.red, Icons.construction)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricCard(String title, int score, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 24),
              const SizedBox(width: 8),
              Text(
                title,
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          CircularPercentIndicator(
            radius: 40,
            lineWidth: 8,
            percent: score / 100,
            center: Text(
              '$score',
              style: AppTextStyles.headline3.copyWith(
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
            progressColor: color,
            backgroundColor: color.withOpacity(0.2),
            animation: true,
            animationDuration: 1000,
          ),
          const SizedBox(height: 8),
          Text(
            _getScoreStatus(score),
            style: AppTextStyles.bodySmall.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  String _getScoreStatus(int score) {
    if (score >= 90) return 'Excellent';
    if (score >= 80) return 'Bon';
    if (score >= 70) return 'Moyen';
    if (score >= 60) return 'À améliorer';
    return 'Critique';
  }

  Widget _buildProgressCharts() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Évolution des Scores (4 dernières semaines)',
              style: AppTextStyles.sectionTitle,
            ),
            const SizedBox(height: 16),
            
            // Graphique de progression
            Container(
              height: 200,
              child: _buildTrendChart(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrendChart() {
    // Données simulées pour l'évolution
    final weeks = ['Sem 1', 'Sem 2', 'Sem 3', 'Sem 4'];
    final codeQuality = [82, 85, 87, 87];
    final security = [88, 90, 91, 92];
    final performance = [75, 76, 77, 78];
    final ux = [80, 82, 84, 85];
    
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: weeks.asMap().entries.map((entry) {
        final index = entry.key;
        final week = entry.value;
        
        return Expanded(
          child: Column(
            children: [
              // Barres de progression
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(right: 2),
                        height: (codeQuality[index] / 100) * 150,
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(right: 2),
                        height: (security[index] / 100) * 150,
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(right: 2),
                        height: (performance[index] / 100) * 150,
                        decoration: BoxDecoration(
                          color: Colors.orange.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: (ux[index] / 100) * 150,
                        decoration: BoxDecoration(
                          color: Colors.purple.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                week,
                style: AppTextStyles.bodySmall,
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildExecutiveSummary() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Résumé Exécutif',
              style: AppTextStyles.sectionTitle,
            ),
            const SizedBox(height: 16),
            
            _buildSummaryItem(
              'État Général',
              'L\'application Student Guide France présente une qualité technique solide avec des scores élevés en sécurité (92/100) et en qualité de code (87/100).',
              Colors.green,
              Icons.check_circle,
            ),
            
            _buildSummaryItem(
              'Points d\'Amélioration',
              'Performance (78/100) et couverture de tests (73%) nécessitent une attention particulière pour atteindre les standards industriels.',
              Colors.orange,
              Icons.warning,
            ),
            
            _buildSummaryItem(
              'Recommandations',
              'Prioriser l\'optimisation des performances et l\'augmentation de la couverture de tests pour améliorer la robustesse.',
              Colors.blue,
              Icons.lightbulb,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryItem(String title, String description, Color color, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: AppTextStyles.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTechnicalView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Détails techniques
          _buildTechnicalDetails(),
          const SizedBox(height: 24),
          
          // Benchmarks industriels
          _buildIndustryBenchmarks(),
          const SizedBox(height: 24),
          
          // Heat map des problèmes
          _buildProblemHeatMap(),
        ],
      ),
    );
  }

  Widget _buildTechnicalDetails() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Détails Techniques',
              style: AppTextStyles.sectionTitle,
            ),
            const SizedBox(height: 16),
            
            _buildTechnicalMetric('Code Quality Score', 87, 100, 'Analyse statique, complexité cyclomatique, duplication'),
            _buildTechnicalMetric('Security Score', 92, 100, 'Vulnerabilities, OWASP compliance, data protection'),
            _buildTechnicalMetric('Performance Score', 78, 100, 'App startup time, memory usage, frame rate'),
            _buildTechnicalMetric('UX Score', 85, 100, 'Usability testing, accessibility, user satisfaction'),
            _buildTechnicalMetric('Test Coverage', 73, 100, 'Unit tests, integration tests, widget tests'),
            _buildTechnicalMetric('Technical Debt', 65, 100, 'Code smells, refactoring needed, legacy code'),
          ],
        ),
      ),
    );
  }

  Widget _buildTechnicalMetric(String title, int current, int max, String description) {
    final percentage = (current / max * 100).round();
    final color = _getMetricColor(percentage);
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '$current/$max',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: color,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
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
          const SizedBox(height: 4),
          Text(
            description,
            style: AppTextStyles.bodySmall.copyWith(
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Color _getMetricColor(int percentage) {
    if (percentage >= 90) return Colors.green;
    if (percentage >= 80) return Colors.blue;
    if (percentage >= 70) return Colors.orange;
    return Colors.red;
  }

  Widget _buildIndustryBenchmarks() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Benchmarks Industriels Flutter',
              style: AppTextStyles.sectionTitle,
            ),
            const SizedBox(height: 16),
            
            _buildBenchmarkComparison('Code Quality', 87, 85, 'Flutter Apps'),
            _buildBenchmarkComparison('Security', 92, 88, 'Flutter Apps'),
            _buildBenchmarkComparison('Performance', 78, 82, 'Flutter Apps'),
            _buildBenchmarkComparison('UX Score', 85, 87, 'Flutter Apps'),
            _buildBenchmarkComparison('Test Coverage', 73, 80, 'Flutter Apps'),
          ],
        ),
      ),
    );
  }

  Widget _buildBenchmarkComparison(String metric, int ourScore, int industryAvg, String category) {
    final isAbove = ourScore > industryAvg;
    final color = isAbove ? Colors.green : Colors.orange;
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(
            child: Text(
              metric,
              style: AppTextStyles.bodyMedium,
            ),
          ),
          Text(
            '$ourScore',
            style: AppTextStyles.bodyMedium.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            'vs $industryAvg ($category)',
            style: AppTextStyles.bodySmall.copyWith(
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(width: 8),
          Icon(
            isAbove ? Icons.trending_up : Icons.trending_down,
            color: color,
            size: 16,
          ),
        ],
      ),
    );
  }

  Widget _buildProblemHeatMap() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Heat Map des Problèmes',
              style: AppTextStyles.sectionTitle,
            ),
            const SizedBox(height: 16),
            
            // Simulation d'une heat map
            Container(
              height: 200,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  childAspectRatio: 1,
                ),
                itemCount: 28, // 4 semaines x 7 jours
                itemBuilder: (context, index) {
                  final intensity = (index % 4) / 3.0; // Simulation d'intensité
                  final color = Color.lerp(Colors.green, Colors.red, intensity)!;
                  
                  return Container(
                    margin: const EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(
                      child: Text(
                        '${index + 1}',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrendsView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tendances de performance
          _buildPerformanceTrends(),
          const SizedBox(height: 24),
          
          // Velocity et issues
          _buildVelocityAndIssues(),
          const SizedBox(height: 24),
          
          // Roadmap recommendations
          _buildRoadmapRecommendations(),
        ],
      ),
    );
  }

  Widget _buildPerformanceTrends() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tendances de Performance',
              style: AppTextStyles.sectionTitle,
            ),
            const SizedBox(height: 16),
            
            // Graphique de tendances
            Container(
              height: 150,
              child: _buildTrendLineChart(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrendLineChart() {
    // Données simulées pour les tendances
    final data = [65, 70, 75, 78, 80, 82, 85, 87];
    
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: data.asMap().entries.map((entry) {
        final index = entry.key;
        final value = entry.value;
        
        return Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 2),
            height: (value / 100) * 120,
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.7),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Center(
              child: Text(
                '$value',
                style: AppTextStyles.bodySmall.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildVelocityAndIssues() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Velocity et Issues',
              style: AppTextStyles.sectionTitle,
            ),
            const SizedBox(height: 16),
            
            Row(
              children: [
                Expanded(
                  child: _buildVelocityCard('Velocity', '12.5', 'points/semaine', Colors.green),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildVelocityCard('Issues Résolues', '24', 'cette semaine', Colors.blue),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildVelocityCard('Issues Créées', '18', 'cette semaine', Colors.orange),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildVelocityCard('Temps de Résolution', '2.3', 'jours moyen', Colors.purple),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVelocityCard(String title, String value, String unit, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: AppTextStyles.headline3.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            unit,
            style: AppTextStyles.bodySmall.copyWith(
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoadmapRecommendations() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recommandations Roadmap',
              style: AppTextStyles.sectionTitle,
            ),
            const SizedBox(height: 16),
            
            _buildRecommendationItem(
              'Priorité Haute',
              'Optimiser les performances de l\'application',
              'Améliorer le score de performance de 78 à 85+',
              Colors.red,
              Icons.priority_high,
            ),
            
            _buildRecommendationItem(
              'Priorité Moyenne',
              'Augmenter la couverture de tests',
              'Atteindre 80% de couverture de tests',
              Colors.orange,
              Icons.bug_report,
            ),
            
            _buildRecommendationItem(
              'Priorité Basse',
              'Réduire la dette technique',
              'Refactoriser le code legacy et améliorer la qualité',
              Colors.blue,
              Icons.construction,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecommendationItem(String priority, String title, String description, Color color, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  priority,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  title,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  description,
                  style: AppTextStyles.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAlertsView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Alertes critiques
          _buildCriticalAlerts(),
          const SizedBox(height: 24),
          
          // Régressions détectées
          _buildRegressions(),
          const SizedBox(height: 24),
          
          // Améliorations remarquables
          _buildImprovements(),
        ],
      ),
    );
  }

  Widget _buildCriticalAlerts() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.warning, color: Colors.red, size: 24),
                const SizedBox(width: 8),
                Text(
                  'Alertes Critiques',
                  style: AppTextStyles.sectionTitle.copyWith(
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            _buildAlertItem(
              'Memory Leak Détecté',
              'Fuite mémoire dans la gestion des images',
              'Critique',
              Colors.red,
              Icons.memory,
            ),
            
            _buildAlertItem(
              'Vulnerabilité de Sécurité',
              'Dépendance obsolète avec CVE-2024-1234',
              'Critique',
              Colors.red,
              Icons.security,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRegressions() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.trending_down, color: Colors.orange, size: 24),
                const SizedBox(width: 8),
                Text(
                  'Régressions Détectées',
                  style: AppTextStyles.sectionTitle.copyWith(
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            _buildAlertItem(
              'Performance Dégradée',
              'Temps de chargement +15% depuis la v1.2.0',
              'Moyenne',
              Colors.orange,
              Icons.speed,
            ),
            
            _buildAlertItem(
              'Tests Échoués',
              '3 tests d\'intégration échouent après mise à jour',
              'Moyenne',
              Colors.orange,
              Icons.bug_report,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImprovements() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.trending_up, color: Colors.green, size: 24),
                const SizedBox(width: 8),
                Text(
                  'Améliorations Remarquables',
                  style: AppTextStyles.sectionTitle.copyWith(
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            _buildAlertItem(
              'Sécurité Renforcée',
              'Score de sécurité passé de 85 à 92',
              'Excellente',
              Colors.green,
              Icons.security,
            ),
            
            _buildAlertItem(
              'UX Améliorée',
              'Temps de réponse utilisateur -30%',
              'Excellente',
              Colors.green,
              Icons.design_services,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAlertItem(String title, String description, String severity, Color color, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.bodyMedium.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        severity,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: color,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: AppTextStyles.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
