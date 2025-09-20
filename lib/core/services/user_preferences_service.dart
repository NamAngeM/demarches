import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/user_profile.dart';

class UserPreferencesService {
  static const String _userProfileKey = 'user_profile';
  static const String _viewedGuidesKey = 'viewed_guides';
  static const String _favoriteGuidesKey = 'favorite_guides';
  static const String _completedGuidesKey = 'completed_guides';
  static const String _themeModeKey = 'theme_mode';
  static const String _languageKey = 'language';
  static const String _notificationsKey = 'notifications_enabled';

  // Sauvegarder le profil utilisateur
  static Future<void> saveUserProfile(UserProfile profile) async {
    final prefs = await SharedPreferences.getInstance();
    final profileJson = json.encode(profile.toJson());
    await prefs.setString(_userProfileKey, profileJson);
  }

  // Charger le profil utilisateur
  static Future<UserProfile?> loadUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final profileJson = prefs.getString(_userProfileKey);
    
    if (profileJson != null) {
      try {
        final Map<String, dynamic> profileMap = json.decode(profileJson);
        return UserProfile.fromJson(profileMap);
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  // Supprimer le profil utilisateur
  static Future<void> clearUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userProfileKey);
  }

  // Sauvegarder les guides consultés
  static Future<void> addViewedGuide(String guideId) async {
    final prefs = await SharedPreferences.getInstance();
    final viewedGuides = await getViewedGuides();
    
    if (!viewedGuides.contains(guideId)) {
      viewedGuides.add(guideId);
      await prefs.setStringList(_viewedGuidesKey, viewedGuides);
    }
  }

  // Obtenir les guides consultés
  static Future<List<String>> getViewedGuides() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_viewedGuidesKey) ?? [];
  }

  // Sauvegarder les guides favoris
  static Future<void> addFavoriteGuide(String guideId) async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteGuides = await getFavoriteGuides();
    
    if (!favoriteGuides.contains(guideId)) {
      favoriteGuides.add(guideId);
      await prefs.setStringList(_favoriteGuidesKey, favoriteGuides);
    }
  }

  // Retirer des favoris
  static Future<void> removeFavoriteGuide(String guideId) async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteGuides = await getFavoriteGuides();
    favoriteGuides.remove(guideId);
    await prefs.setStringList(_favoriteGuidesKey, favoriteGuides);
  }

  // Obtenir les guides favoris
  static Future<List<String>> getFavoriteGuides() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_favoriteGuidesKey) ?? [];
  }

  // Vérifier si un guide est en favori
  static Future<bool> isFavoriteGuide(String guideId) async {
    final favoriteGuides = await getFavoriteGuides();
    return favoriteGuides.contains(guideId);
  }

  // Sauvegarder les guides terminés
  static Future<void> addCompletedGuide(String guideId) async {
    final prefs = await SharedPreferences.getInstance();
    final completedGuides = await getCompletedGuides();
    
    if (!completedGuides.contains(guideId)) {
      completedGuides.add(guideId);
      await prefs.setStringList(_completedGuidesKey, completedGuides);
    }
  }

  // Obtenir les guides terminés
  static Future<List<String>> getCompletedGuides() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_completedGuidesKey) ?? [];
  }

  // Vérifier si un guide est terminé
  static Future<bool> isCompletedGuide(String guideId) async {
    final completedGuides = await getCompletedGuides();
    return completedGuides.contains(guideId);
  }

  // Sauvegarder le mode de thème
  static Future<void> saveThemeMode(String themeMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeModeKey, themeMode);
  }

  // Charger le mode de thème
  static Future<String> loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_themeModeKey) ?? 'system';
  }

  // Sauvegarder la langue
  static Future<void> saveLanguage(String language) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languageKey, language);
  }

  // Charger la langue
  static Future<String> loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_languageKey) ?? 'fr';
  }

  // Sauvegarder les préférences de notifications
  static Future<void> saveNotificationsEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_notificationsKey, enabled);
  }

  // Charger les préférences de notifications
  static Future<bool> loadNotificationsEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_notificationsKey) ?? true;
  }

  // Obtenir les statistiques utilisateur
  static Future<Map<String, int>> getUserStats() async {
    final viewedGuides = await getViewedGuides();
    final favoriteGuides = await getFavoriteGuides();
    final completedGuides = await getCompletedGuides();
    
    return {
      'viewedGuides': viewedGuides.length,
      'favoriteGuides': favoriteGuides.length,
      'completedGuides': completedGuides.length,
    };
  }

  // Effacer toutes les préférences
  static Future<void> clearAllPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userProfileKey);
    await prefs.remove(_viewedGuidesKey);
    await prefs.remove(_favoriteGuidesKey);
    await prefs.remove(_completedGuidesKey);
    await prefs.remove(_themeModeKey);
    await prefs.remove(_languageKey);
    await prefs.remove(_notificationsKey);
  }

  // Sauvegarder les préférences de profil personnalisées
  static Future<void> saveProfilePreferences({
    String? countryOfOrigin,
    String? university,
    UserLevel? level,
    String? phoneNumber,
  }) async {
    final profile = await loadUserProfile();
    if (profile != null) {
      final updatedProfile = profile.copyWith(
        countryOfOrigin: countryOfOrigin,
        university: university,
        level: level,
        phoneNumber: phoneNumber,
        updatedAt: DateTime.now(),
        isFirstTime: false,
      );
      await saveUserProfile(updatedProfile);
    }
  }
}
