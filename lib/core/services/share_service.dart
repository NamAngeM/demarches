import 'package:share_plus/share_plus.dart';
import '../../domain/entities/guide.dart';

class ShareService {
  // Partager un guide complet
  static Future<void> shareGuide(Guide guide) async {
    final shareText = _buildGuideShareText(guide);
    await Share.share(shareText, subject: 'Guide: ${guide.title}');
  }
  
  // Partager une étape spécifique
  static Future<void> shareGuideStep(Guide guide, GuideStep step) async {
    final shareText = _buildStepShareText(guide, step);
    await Share.share(shareText, subject: 'Étape ${step.stepNumber}: ${step.title}');
  }
  
  // Partager la progression d'un guide
  static Future<void> shareGuideProgress(Guide guide, double progressPercentage) async {
    final shareText = _buildProgressShareText(guide, progressPercentage);
    await Share.share(shareText, subject: 'Progression: ${guide.title}');
  }
  
  // Construire le texte de partage pour un guide complet
  static String _buildGuideShareText(Guide guide) {
    final buffer = StringBuffer();
    
    buffer.writeln('📚 ${guide.title}');
    buffer.writeln('${guide.categoryIcon} ${guide.categoryDisplayName}');
    buffer.writeln('');
    buffer.writeln('📝 Description:');
    buffer.writeln(guide.description);
    buffer.writeln('');
    buffer.writeln('⏱️ Durée estimée: ${guide.estimatedDuration}');
    buffer.writeln('📊 Difficulté: ${guide.difficulty}');
    buffer.writeln('📋 Nombre d\'étapes: ${guide.steps.length}');
    buffer.writeln('');
    buffer.writeln('📋 Étapes:');
    
    for (final step in guide.steps) {
      buffer.writeln('${step.stepNumber}. ${step.title}');
      if (step.estimatedTime != null) {
        buffer.writeln('   ⏱️ Durée: ${step.estimatedTime}');
      }
      if (step.cost != null) {
        buffer.writeln('   💰 Coût: ${step.cost}');
      }
      buffer.writeln('');
    }
    
    buffer.writeln('🏷️ Tags: ${guide.tags.join(', ')}');
    buffer.writeln('');
    buffer.writeln('📱 Découvrez plus de guides dans Démarches App!');
    
    return buffer.toString();
  }
  
  // Construire le texte de partage pour une étape
  static String _buildStepShareText(Guide guide, GuideStep step) {
    final buffer = StringBuffer();
    
    buffer.writeln('📚 ${guide.title}');
    buffer.writeln('${guide.categoryIcon} ${guide.categoryDisplayName}');
    buffer.writeln('');
    buffer.writeln('📋 Étape ${step.stepNumber}: ${step.title}');
    buffer.writeln('');
    buffer.writeln('📝 Description:');
    buffer.writeln(step.description);
    buffer.writeln('');
    
    if (step.requirements != null && step.requirements!.isNotEmpty) {
      buffer.writeln('📄 Documents requis:');
      for (final requirement in step.requirements!) {
        buffer.writeln('• $requirement');
      }
      buffer.writeln('');
    }
    
    if (step.estimatedTime != null) {
      buffer.writeln('⏱️ Durée estimée: ${step.estimatedTime}');
    }
    if (step.cost != null) {
      buffer.writeln('💰 Coût: ${step.cost}');
    }
    
    buffer.writeln('');
    buffer.writeln('📱 Découvrez le guide complet dans Démarches App!');
    
    return buffer.toString();
  }
  
  // Construire le texte de partage pour la progression
  static String _buildProgressShareText(Guide guide, double progressPercentage) {
    final buffer = StringBuffer();
    
    buffer.writeln('📚 ${guide.title}');
    buffer.writeln('${guide.categoryIcon} ${guide.categoryDisplayName}');
    buffer.writeln('');
    buffer.writeln('📊 Progression: ${(progressPercentage * 100).toInt()}%');
    buffer.writeln('✅ Étapes terminées: ${(progressPercentage * guide.steps.length).toInt()}/${guide.steps.length}');
    buffer.writeln('');
    
    if (progressPercentage == 1.0) {
      buffer.writeln('🎉 Félicitations! Vous avez terminé ce guide!');
    } else {
      buffer.writeln('💪 Continuez, vous y êtes presque!');
    }
    
    buffer.writeln('');
    buffer.writeln('📱 Découvrez plus de guides dans Démarches App!');
    
    return buffer.toString();
  }
  
  // Partager une liste de guides
  static Future<void> shareGuidesList(List<Guide> guides) async {
    final shareText = _buildGuidesListShareText(guides);
    await Share.share(shareText, subject: 'Mes guides favoris - Démarches App');
  }
  
  // Construire le texte de partage pour une liste de guides
  static String _buildGuidesListShareText(List<Guide> guides) {
    final buffer = StringBuffer();
    
    buffer.writeln('📚 Mes guides favoris - Démarches App');
    buffer.writeln('');
    
    for (int i = 0; i < guides.length; i++) {
      final guide = guides[i];
      buffer.writeln('${i + 1}. ${guide.title}');
      buffer.writeln('   ${guide.categoryIcon} ${guide.categoryDisplayName}');
      buffer.writeln('   ⏱️ ${guide.estimatedDuration} • 📊 ${guide.difficulty}');
      buffer.writeln('');
    }
    
    buffer.writeln('📱 Découvrez tous les guides dans Démarches App!');
    
    return buffer.toString();
  }
}
