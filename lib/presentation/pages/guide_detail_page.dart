import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/guide.dart';
import '../widgets/buttons/buttons.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/services/guide_progress_service.dart';
import '../../core/services/share_service.dart';

class GuideDetailPage extends ConsumerStatefulWidget {
  final Guide guide;

  const GuideDetailPage({
    super.key,
    required this.guide,
  });

  @override
  ConsumerState<GuideDetailPage> createState() => _GuideDetailPageState();
}

class _GuideDetailPageState extends ConsumerState<GuideDetailPage> {
  bool _isFavorite = false;
  Map<String, bool> _stepProgress = {};
  double _progressPercentage = 0.0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.guide.isFavorite;
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    final progress = await GuideProgressService.getGuideProgress(widget.guide.id);
    final percentage = await GuideProgressService.getProgressPercentage(
      widget.guide.id,
      widget.guide.steps.length,
    );
    
    setState(() {
      _stepProgress = progress;
      _progressPercentage = percentage;
      _isLoading = false;
    });
  }

  Future<void> _toggleStepCompletion(int stepNumber) async {
    final isCompleted = _stepProgress[stepNumber.toString()] ?? false;
    
    if (isCompleted) {
      await GuideProgressService.markStepAsIncomplete(widget.guide.id, stepNumber);
    } else {
      await GuideProgressService.markStepAsCompleted(widget.guide.id, stepNumber);
    }
    
    await _loadProgress();
  }

  Future<void> _markGuideAsCompleted() async {
    await GuideProgressService.markGuideAsCompleted(
      widget.guide.id,
      widget.guide.steps.length,
    );
    await _loadProgress();
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('🎉 Guide "${widget.guide.title}" marqué comme terminé!'),
          backgroundColor: Colors.green,
          action: SnackBarAction(
            label: 'Partager',
            textColor: Colors.white,
            onPressed: () => _shareProgress(),
          ),
        ),
      );
    }
  }

  Future<void> _shareGuide() async {
    await ShareService.shareGuide(widget.guide);
  }

  Future<void> _shareProgress() async {
    await ShareService.shareGuideProgress(widget.guide, _progressPercentage);
  }

  Future<void> _shareStep(GuideStep step) async {
    await ShareService.shareGuideStep(widget.guide, step);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.guide.title,
          style: AppTextStyles.titleMedium.copyWith(
            color: Colors.white,
          ),
        ),
        actions: [
          AppIconButton(
            icon: _isFavorite ? Icons.favorite : Icons.favorite_border,
            onPressed: () {
              setState(() {
                _isFavorite = !_isFavorite;
              });
              // TODO: Implémenter la logique de favoris
            },
            tooltip: _isFavorite ? 'Retirer des favoris' : 'Ajouter aux favoris',
          ),
          const SizedBox(width: 8),
          AppIconButton(
            icon: Icons.share,
            onPressed: _shareGuide,
            tooltip: 'Partager le guide',
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // En-tête du guide
            _buildGuideHeader(),
            const SizedBox(height: 24),
            
            // Informations générales
            _buildGuideInfo(),
            const SizedBox(height: 24),
            
            // Description
            _buildDescription(),
            const SizedBox(height: 24),
            
            // Étapes du guide
            _buildSteps(),
            const SizedBox(height: 24),
            
            // Tags
            _buildTags(),
            const SizedBox(height: 24),
            
            // Actions
            _buildActions(),
          ],
        ),
      ),
      floatingActionButton: AppFab(
        onPressed: () {
          // TODO: Implémenter l'ajout d'une note personnelle
        },
        label: 'Ajouter une note',
        icon: Icons.note_add,
      ),
    );
  }

  Widget _buildGuideHeader() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  widget.guide.categoryIcon,
                  style: const TextStyle(fontSize: 32),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.guide.title,
                        style: AppTextStyles.headline3,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.guide.categoryDisplayName,
                        style: AppTextStyles.bodyLarge.copyWith(
                          color: Theme.of(context).colorScheme.primary,
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

  Widget _buildGuideInfo() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Informations',
              style: AppTextStyles.sectionTitle,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildInfoItem(
                    icon: Icons.schedule,
                    label: 'Durée estimée',
                    value: widget.guide.estimatedDuration,
                    color: Colors.blue,
                  ),
                ),
                Expanded(
                  child: _buildInfoItem(
                    icon: Icons.trending_up,
                    label: 'Difficulté',
                    value: widget.guide.difficulty,
                    color: _getDifficultyColor(widget.guide.difficulty),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildInfoItem(
                    icon: Icons.list,
                    label: 'Nombre d\'étapes',
                    value: '${widget.guide.steps.length} étapes',
                    color: Colors.green,
                  ),
                ),
                Expanded(
                  child: _buildInfoItem(
                    icon: Icons.update,
                    label: 'Dernière mise à jour',
                    value: _formatDate(widget.guide.updatedAt),
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            
            if (!_isLoading) ...[
              const SizedBox(height: 16),
              _buildProgressSection(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildProgressSection() {
    final completedSteps = _stepProgress.values.where((completed) => completed).length;
    final totalSteps = widget.guide.steps.length;
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.track_changes,
                color: Theme.of(context).colorScheme.primary,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Progression',
                style: AppTextStyles.bodyLarge.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const Spacer(),
              Text(
                '${(completedSteps / totalSteps * 100).toInt()}%',
                style: AppTextStyles.bodyLarge.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: _progressPercentage,
            backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
            valueColor: AlwaysStoppedAnimation<Color>(
              Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '$completedSteps/$totalSteps étapes terminées',
            style: AppTextStyles.bodySmall.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 20, color: color),
            const SizedBox(width: 8),
            Text(
              label,
              style: AppTextStyles.bodySmall.copyWith(
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: AppTextStyles.bodyMedium.copyWith(
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildDescription() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Description',
              style: AppTextStyles.sectionTitle,
            ),
            const SizedBox(height: 12),
            Text(
              widget.guide.description,
              style: AppTextStyles.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSteps() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Étapes du guide',
              style: AppTextStyles.sectionTitle,
            ),
            const SizedBox(height: 16),
            ...widget.guide.steps.asMap().entries.map((entry) {
              final index = entry.key;
              final step = entry.value;
              return _buildStepItem(step, index + 1);
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildStepItem(GuideStep step, int stepNumber) {
    final isCompleted = _stepProgress[stepNumber.toString()] ?? false;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isCompleted 
            ? Colors.green.withOpacity(0.1)
            : Theme.of(context).colorScheme.primary.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isCompleted 
              ? Colors.green.withOpacity(0.3)
              : Theme.of(context).colorScheme.primary.withOpacity(0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Checkbox pour marquer l'étape comme terminée
              Checkbox(
                value: isCompleted,
                onChanged: (value) => _toggleStepCompletion(stepNumber),
                activeColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: isCompleted 
                      ? Colors.green
                      : Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: isCompleted
                      ? const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 20,
                        )
                      : Text(
                          stepNumber.toString(),
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  step.title,
                  style: AppTextStyles.cardTitle.copyWith(
                    decoration: isCompleted ? TextDecoration.lineThrough : null,
                    color: isCompleted ? Colors.grey[600] : null,
                  ),
                ),
              ),
              // Bouton de partage de l'étape
              AppIconButton(
                icon: Icons.share,
                size: AppIconButtonSize.small,
                type: AppIconButtonType.text,
                onPressed: () => _shareStep(step),
                tooltip: 'Partager cette étape',
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            step.description,
            style: AppTextStyles.bodyMedium,
          ),
          if (step.requirements != null && step.requirements!.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(
              'Documents requis :',
              style: AppTextStyles.bodySmall.copyWith(
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 4),
            ...step.requirements!.map((req) => Padding(
              padding: const EdgeInsets.only(left: 8, top: 2),
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    size: 16,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      req,
                      style: AppTextStyles.bodySmall,
                    ),
                  ),
                ],
              ),
            )).toList(),
          ],
          if (step.estimatedTime != null || step.cost != null) ...[
            const SizedBox(height: 12),
            Row(
              children: [
                if (step.estimatedTime != null) ...[
                  _buildStepInfo(
                    icon: Icons.schedule,
                    label: 'Durée',
                    value: step.estimatedTime!,
                    color: Colors.blue,
                  ),
                  const SizedBox(width: 16),
                ],
                if (step.cost != null)
                  _buildStepInfo(
                    icon: Icons.euro,
                    label: 'Coût',
                    value: step.cost!,
                    color: Colors.green,
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStepInfo({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 4),
        Text(
          '$label: ',
          style: AppTextStyles.bodySmall.copyWith(
            color: Colors.grey[600],
          ),
        ),
        Text(
          value,
          style: AppTextStyles.bodySmall.copyWith(
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildTags() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tags',
              style: AppTextStyles.sectionTitle,
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: widget.guide.tags.map((tag) {
                return Chip(
                  label: Text(tag),
                  backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  labelStyle: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 12,
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActions() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Actions',
              style: AppTextStyles.sectionTitle,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    text: _progressPercentage == 1.0 ? 'Guide terminé!' : 'Commencer le guide',
                    icon: _progressPercentage == 1.0 ? Icons.check_circle : Icons.play_arrow,
                    type: _progressPercentage == 1.0 ? AppButtonType.secondary : AppButtonType.primary,
                    onPressed: _progressPercentage == 1.0 ? null : () {
                      // TODO: Implémenter le suivi du guide
                    },
                    isFullWidth: true,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: AppButton(
                    text: 'Partager',
                    icon: Icons.share,
                    type: AppButtonType.outline,
                    onPressed: _shareGuide,
                    isFullWidth: true,
                  ),
                ),
              ],
            ),
            
            if (_progressPercentage > 0 && _progressPercentage < 1.0) ...[
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: AppButton(
                      text: 'Marquer comme terminé',
                      icon: Icons.check_circle_outline,
                      type: AppButtonType.secondary,
                      onPressed: _markGuideAsCompleted,
                      isFullWidth: true,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: AppButton(
                      text: 'Partager progression',
                      icon: Icons.share,
                      type: AppButtonType.text,
                      onPressed: _shareProgress,
                      isFullWidth: true,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'facile':
        return Colors.green;
      case 'moyen':
        return Colors.orange;
      case 'difficile':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date).inDays;
    
    if (difference == 0) {
      return 'Aujourd\'hui';
    } else if (difference == 1) {
      return 'Hier';
    } else if (difference < 7) {
      return 'Il y a $difference jours';
    } else if (difference < 30) {
      final weeks = (difference / 7).floor();
      return 'Il y a $weeks semaine${weeks > 1 ? 's' : ''}';
    } else {
      final months = (difference / 30).floor();
      return 'Il y a $months mois';
    }
  }
}
