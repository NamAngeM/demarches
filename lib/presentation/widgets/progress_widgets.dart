import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
// import 'package:circular_countdown_timer/circular_countdown_timer.dart'; // Commenté car package non disponible
import '../../core/theme/app_text_styles.dart';

class ProgressWidgets {
  // Barre de progression linéaire
  static Widget linearProgress({
    required BuildContext context,
    required double progress,
    required String label,
    String? subtitle,
    Color? progressColor,
    Color? backgroundColor,
    double height = 8.0,
    bool showPercentage = true,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: AppTextStyles.bodyLarge.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            if (showPercentage)
              Text(
                '${(progress * 100).round()}%',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: progressColor ?? Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
          ],
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: AppTextStyles.bodySmall.copyWith(
              color: Colors.grey[600],
            ),
          ),
        ],
        const SizedBox(height: 8),
        LinearPercentIndicator(
          width: double.infinity,
          lineHeight: height,
          percent: progress.clamp(0.0, 1.0),
          backgroundColor: backgroundColor ?? Colors.grey[300],
          progressColor: progressColor ?? Theme.of(context).colorScheme.primary,
          barRadius: const Radius.circular(4),
          animation: true,
          animationDuration: 1000,
        ),
      ],
    );
  }

  // Indicateur de progression circulaire
  static Widget circularProgress({
    required BuildContext context,
    required double progress,
    required String label,
    String? subtitle,
    Color? progressColor,
    Color? backgroundColor,
    double size = 120.0,
    double lineWidth = 8.0,
    bool showPercentage = true,
  }) {
    return Column(
      children: [
        CircularPercentIndicator(
          radius: size / 2,
          lineWidth: lineWidth,
          percent: progress.clamp(0.0, 1.0),
          center: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (showPercentage)
                Text(
                  '${(progress * 100).round()}%',
                  style: AppTextStyles.headline3.copyWith(
                    color: progressColor ?? Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              if (subtitle != null)
                Text(
                  subtitle,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),
            ],
          ),
          backgroundColor: backgroundColor ?? Colors.grey[300],
          progressColor: progressColor ?? Theme.of(context).colorScheme.primary,
          animation: true,
          animationDuration: 1000,
        ),
        const SizedBox(height: 16),
        Text(
          label,
          style: AppTextStyles.bodyLarge.copyWith(
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  // Progression par étapes
  static Widget stepProgress({
    required BuildContext context,
    required List<StepProgressItem> steps,
    required int currentStep,
    Color? activeColor,
    Color? inactiveColor,
    Color? completedColor,
  }) {
    return Column(
      children: steps.asMap().entries.map((entry) {
        final index = entry.key;
        final step = entry.value;
        final isCompleted = index < currentStep;
        final isActive = index == currentStep;
        final isPending = index > currentStep;

        return Row(
          children: [
            // Indicateur de l'étape
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: isCompleted
                    ? completedColor ?? Colors.green
                    : isActive
                        ? activeColor ?? Theme.of(context).colorScheme.primary
                        : inactiveColor ?? Colors.grey[300],
                shape: BoxShape.circle,
              ),
              child: Center(
                child: isCompleted
                    ? const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 20,
                      )
                    : Text(
                        '${index + 1}',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: isActive ? Colors.white : Colors.grey[600],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
            const SizedBox(width: 12),
            // Contenu de l'étape
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    step.title,
                    style: AppTextStyles.bodyLarge.copyWith(
                      fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                      color: isCompleted
                          ? Colors.grey[600]
                          : isActive
                              ? activeColor ?? Theme.of(context).colorScheme.primary
                              : Colors.grey[600],
                      decoration: isCompleted ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  if (step.subtitle != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      step.subtitle!,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ],
              ),
            ),
            // Indicateur de statut
            if (isCompleted)
              Icon(
                Icons.check_circle,
                color: completedColor ?? Colors.green,
                size: 20,
              )
            else if (isActive)
              Icon(
                Icons.radio_button_checked,
                color: activeColor ?? Theme.of(context).colorScheme.primary,
                size: 20,
              ),
          ],
        );
      }).toList(),
    );
  }

  // Progression avec estimation de temps
  static Widget timeProgress({
    required BuildContext context,
    required double progress,
    required String label,
    required Duration estimatedTime,
    required Duration elapsedTime,
    Color? progressColor,
    Color? backgroundColor,
  }) {
    final remainingTime = estimatedTime - elapsedTime;
    final isOverdue = remainingTime.isNegative;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.bodyLarge.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        LinearPercentIndicator(
          width: double.infinity,
          lineHeight: 8.0,
          percent: progress.clamp(0.0, 1.0),
          backgroundColor: backgroundColor ?? Colors.grey[300],
          progressColor: isOverdue
              ? Colors.red
              : progressColor ?? Theme.of(context).colorScheme.primary,
          barRadius: const Radius.circular(4),
          animation: true,
          animationDuration: 1000,
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Temps écoulé: ${_formatDuration(elapsedTime)}',
              style: AppTextStyles.bodySmall.copyWith(
                color: Colors.grey[600],
              ),
            ),
            Text(
              isOverdue
                  ? 'En retard de ${_formatDuration(-remainingTime)}'
                  : 'Temps restant: ${_formatDuration(remainingTime)}',
              style: AppTextStyles.bodySmall.copyWith(
                color: isOverdue ? Colors.red : Colors.grey[600],
                fontWeight: isOverdue ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Compteur circulaire avec temps restant (version simplifiée)
  static Widget circularCountdown({
    required BuildContext context,
    required Duration duration,
    required VoidCallback onComplete,
    String? label,
    Color? progressColor,
    Color? backgroundColor,
    double size = 120.0,
  }) {
    return Column(
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: backgroundColor ?? Colors.grey[300],
            border: Border.all(
              color: progressColor ?? Colors.blue,
              width: 8.0,
            ),
          ),
          child: Center(
            child: Text(
              '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}',
              style: AppTextStyles.headline3.copyWith(
                color: progressColor ?? Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        if (label != null) ...[
          const SizedBox(height: 16),
          Text(
            label,
            style: AppTextStyles.bodyLarge.copyWith(
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );
  }

  // Progression avec statistiques
  static Widget statsProgress({
    required BuildContext context,
    required Map<String, int> stats,
    required String title,
    Color? primaryColor,
  }) {
    final total = stats.values.fold(0, (sum, value) => sum + value);
    
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: AppTextStyles.sectionTitle,
            ),
            const SizedBox(height: 16),
            ...stats.entries.map((entry) {
              final percentage = total > 0 ? entry.value / total : 0.0;
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          entry.key,
                          style: AppTextStyles.bodyMedium,
                        ),
                        Text(
                          '${entry.value} (${(percentage * 100).round()}%)',
                          style: AppTextStyles.bodyMedium.copyWith(
                            fontWeight: FontWeight.w600,
                            color: primaryColor ?? Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    LinearPercentIndicator(
                      width: double.infinity,
                      lineHeight: 6.0,
                      percent: percentage,
                      backgroundColor: Colors.grey[300],
                      progressColor: primaryColor ?? Theme.of(context).colorScheme.primary,
                      barRadius: const Radius.circular(3),
                      animation: true,
                      animationDuration: 1000,
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  // Progression avec objectifs
  static Widget goalProgress({
    required BuildContext context,
    required int current,
    required int target,
    required String label,
    String? unit,
    Color? progressColor,
    Color? backgroundColor,
  }) {
    final progress = target > 0 ? current / target : 0.0;
    final isCompleted = current >= target;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: AppTextStyles.bodyLarge.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              '$current${unit ?? ''} / $target${unit ?? ''}',
              style: AppTextStyles.bodyMedium.copyWith(
                color: isCompleted
                    ? Colors.green
                    : progressColor ?? Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        LinearPercentIndicator(
          width: double.infinity,
          lineHeight: 8.0,
          percent: progress.clamp(0.0, 1.0),
          backgroundColor: backgroundColor ?? Colors.grey[300],
          progressColor: isCompleted
              ? Colors.green
              : progressColor ?? Theme.of(context).colorScheme.primary,
          barRadius: const Radius.circular(4),
          animation: true,
          animationDuration: 1000,
        ),
        if (isCompleted) ...[
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 16,
              ),
              const SizedBox(width: 4),
              Text(
                'Objectif atteint !',
                style: AppTextStyles.bodySmall.copyWith(
                  color: Colors.green,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  // Formater une durée
  static String _formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else if (minutes > 0) {
      return '${minutes}m ${seconds}s';
    } else {
      return '${seconds}s';
    }
  }
}

// Classe pour les éléments de progression par étapes
class StepProgressItem {
  final String title;
  final String? subtitle;
  final bool isCompleted;
  final bool isActive;

  const StepProgressItem({
    required this.title,
    this.subtitle,
    this.isCompleted = false,
    this.isActive = false,
  });
}
