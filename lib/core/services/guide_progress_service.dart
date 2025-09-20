import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class GuideProgressService {
  static const String _progressKey = 'guide_progress';
  
  // Récupérer la progression d'un guide
  static Future<Map<String, bool>> getGuideProgress(String guideId) async {
    final prefs = await SharedPreferences.getInstance();
    final progressJson = prefs.getString('${_progressKey}_$guideId');
    
    if (progressJson != null) {
      final Map<String, dynamic> progressMap = json.decode(progressJson);
      return progressMap.map((key, value) => MapEntry(key, value as bool));
    }
    
    return {};
  }
  
  // Marquer une étape comme terminée
  static Future<void> markStepAsCompleted(String guideId, int stepNumber) async {
    final progress = await getGuideProgress(guideId);
    progress[stepNumber.toString()] = true;
    await _saveGuideProgress(guideId, progress);
  }
  
  // Marquer une étape comme non terminée
  static Future<void> markStepAsIncomplete(String guideId, int stepNumber) async {
    final progress = await getGuideProgress(guideId);
    progress[stepNumber.toString()] = false;
    await _saveGuideProgress(guideId, progress);
  }
  
  // Marquer toutes les étapes comme terminées
  static Future<void> markGuideAsCompleted(String guideId, int totalSteps) async {
    final progress = <String, bool>{};
    for (int i = 1; i <= totalSteps; i++) {
      progress[i.toString()] = true;
    }
    await _saveGuideProgress(guideId, progress);
  }
  
  // Réinitialiser la progression d'un guide
  static Future<void> resetGuideProgress(String guideId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('${_progressKey}_$guideId');
  }
  
  // Vérifier si un guide est complètement terminé
  static Future<bool> isGuideCompleted(String guideId, int totalSteps) async {
    final progress = await getGuideProgress(guideId);
    for (int i = 1; i <= totalSteps; i++) {
      if (progress[i.toString()] != true) {
        return false;
      }
    }
    return true;
  }
  
  // Obtenir le pourcentage de progression
  static Future<double> getProgressPercentage(String guideId, int totalSteps) async {
    final progress = await getGuideProgress(guideId);
    int completedSteps = 0;
    
    for (int i = 1; i <= totalSteps; i++) {
      if (progress[i.toString()] == true) {
        completedSteps++;
      }
    }
    
    return totalSteps > 0 ? completedSteps / totalSteps : 0.0;
  }
  
  // Sauvegarder la progression d'un guide
  static Future<void> _saveGuideProgress(String guideId, Map<String, bool> progress) async {
    final prefs = await SharedPreferences.getInstance();
    final progressJson = json.encode(progress);
    await prefs.setString('${_progressKey}_$guideId', progressJson);
  }
  
  // Obtenir tous les guides avec leur progression
  static Future<Map<String, double>> getAllGuidesProgress() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys().where((key) => key.startsWith(_progressKey)).toList();
    final Map<String, double> allProgress = {};
    
    for (final key in keys) {
      final guideId = key.replaceFirst('${_progressKey}_', '');
      final progressJson = prefs.getString(key);
      
      if (progressJson != null) {
        final Map<String, dynamic> progressMap = json.decode(progressJson);
        final totalSteps = progressMap.length;
        int completedSteps = 0;
        
        for (final value in progressMap.values) {
          if (value == true) {
            completedSteps++;
          }
        }
        
        allProgress[guideId] = totalSteps > 0 ? completedSteps / totalSteps : 0.0;
      }
    }
    
    return allProgress;
  }
}
