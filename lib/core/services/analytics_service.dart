import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/guide.dart';
import '../../domain/entities/user_profile.dart';

class AnalyticsService {
  static final AnalyticsService _instance = AnalyticsService._internal();
  factory AnalyticsService() => _instance;
  AnalyticsService._internal();

  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Initialiser le service d'analytics
  Future<void> initialize() async {
    await _analytics.setAnalyticsCollectionEnabled(true);
  }

  // Événements de navigation
  Future<void> logScreenView(String screenName) async {
    await _analytics.logScreenView(screenName: screenName);
  }

  Future<void> logLogin(String method) async {
    await _analytics.logLogin(loginMethod: method);
  }

  Future<void> logSignUp(String method) async {
    await _analytics.logSignUp(signUpMethod: method);
  }

  Future<void> logLogout() async {
    await _analytics.logEvent(name: 'logout');
  }

  // Événements de guides
  Future<void> logGuideViewed(String guideId, String guideTitle, String category) async {
    await _analytics.logEvent(
      name: 'guide_viewed',
      parameters: {
        'guide_id': guideId,
        'guide_title': guideTitle,
        'guide_category': category,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      },
    );
  }

  Future<void> logGuideStarted(String guideId, String guideTitle) async {
    await _analytics.logEvent(
      name: 'guide_started',
      parameters: {
        'guide_id': guideId,
        'guide_title': guideTitle,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      },
    );
  }

  Future<void> logGuideCompleted(String guideId, String guideTitle, int durationMinutes) async {
    await _analytics.logEvent(
      name: 'guide_completed',
      parameters: {
        'guide_id': guideId,
        'guide_title': guideTitle,
        'duration_minutes': durationMinutes,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      },
    );
  }

  Future<void> logGuideStepCompleted(String guideId, int stepNumber, String stepTitle) async {
    await _analytics.logEvent(
      name: 'guide_step_completed',
      parameters: {
        'guide_id': guideId,
        'step_number': stepNumber,
        'step_title': stepTitle,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      },
    );
  }

  Future<void> logGuideFavorited(String guideId, String guideTitle, bool isFavorite) async {
    await _analytics.logEvent(
      name: isFavorite ? 'guide_favorited' : 'guide_unfavorited',
      parameters: {
        'guide_id': guideId,
        'guide_title': guideTitle,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      },
    );
  }

  Future<void> logGuideShared(String guideId, String guideTitle, String shareMethod) async {
    await _analytics.logEvent(
      name: 'guide_shared',
      parameters: {
        'guide_id': guideId,
        'guide_title': guideTitle,
        'share_method': shareMethod,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      },
    );
  }

  // Événements de recherche
  Future<void> logSearch(String query, int resultsCount) async {
    await _analytics.logSearch(
      searchTerm: query,
      parameters: {
        'results_count': resultsCount,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      },
    );
  }

  Future<void> logSearchFilter(String filterType, String filterValue) async {
    await _analytics.logEvent(
      name: 'search_filter_applied',
      parameters: {
        'filter_type': filterType,
        'filter_value': filterValue,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      },
    );
  }

  // Événements de profil
  Future<void> logProfileUpdated(String userId, Map<String, dynamic> changes) async {
    await _analytics.logEvent(
      name: 'profile_updated',
      parameters: {
        'user_id': userId,
        'changes': changes.toString(),
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      },
    );
  }

  Future<void> logProfileSetupCompleted(String userId, UserProfile profile) async {
    await _analytics.logEvent(
      name: 'profile_setup_completed',
      parameters: {
        'user_id': userId,
        'country': profile.countryOfOrigin,
        'university': profile.university,
        'level': profile.level.name,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      },
    );
  }

  // Événements de synchronisation
  Future<void> logSyncStarted(String syncType) async {
    await _analytics.logEvent(
      name: 'sync_started',
      parameters: {
        'sync_type': syncType,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      },
    );
  }

  Future<void> logSyncCompleted(String syncType, int itemsSynced, Duration duration) async {
    await _analytics.logEvent(
      name: 'sync_completed',
      parameters: {
        'sync_type': syncType,
        'items_synced': itemsSynced,
        'duration_seconds': duration.inSeconds,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      },
    );
  }

  Future<void> logSyncError(String syncType, String error) async {
    await _analytics.logEvent(
      name: 'sync_error',
      parameters: {
        'sync_type': syncType,
        'error': error,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      },
    );
  }

  // Événements de notifications
  Future<void> logNotificationReceived(String notificationType, String title) async {
    await _analytics.logEvent(
      name: 'notification_received',
      parameters: {
        'notification_type': notificationType,
        'title': title,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      },
    );
  }

  Future<void> logNotificationTapped(String notificationType, String title) async {
    await _analytics.logEvent(
      name: 'notification_tapped',
      parameters: {
        'notification_type': notificationType,
        'title': title,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      },
    );
  }

  // Événements d'erreur
  Future<void> logError(String errorType, String errorMessage, String? screenName) async {
    await _analytics.logEvent(
      name: 'error_occurred',
      parameters: {
        'error_type': errorType,
        'error_message': errorMessage,
        'screen_name': screenName ?? 'unknown',
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      },
    );
  }

  // Événements de performance
  Future<void> logPerformance(String operation, Duration duration) async {
    await _analytics.logEvent(
      name: 'performance_metric',
      parameters: {
        'operation': operation,
        'duration_ms': duration.inMilliseconds,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      },
    );
  }

  // Événements personnalisés
  Future<void> logCustomEvent(String eventName, Map<String, dynamic> parameters) async {
    await _analytics.logEvent(
      name: eventName,
      parameters: parameters,
    );
  }

  // Définir les propriétés utilisateur
  Future<void> setUserProperties(UserProfile profile) async {
    await _analytics.setUserId(id: profile.id);
    await _analytics.setUserProperty(name: 'country', value: profile.countryOfOrigin);
    await _analytics.setUserProperty(name: 'university', value: profile.university);
    await _analytics.setUserProperty(name: 'level', value: profile.level.name);
    await _analytics.setUserProperty(name: 'is_first_time', value: profile.isFirstTime.toString());
  }

  // Obtenir les statistiques d'usage depuis Firestore
  Future<Map<String, dynamic>> getUsageStats(String userId) async {
    try {
      final userDoc = await _firestore.collection('analytics').doc(userId).get();
      if (userDoc.exists) {
        return userDoc.data()!;
      }
      return {};
    } catch (e) {
      return {};
    }
  }

  // Enregistrer les statistiques d'usage dans Firestore
  Future<void> recordUsageStats(String userId, Map<String, dynamic> stats) async {
    try {
      await _firestore.collection('analytics').doc(userId).set({
        ...stats,
        'last_updated': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    } catch (e) {
      print('Erreur lors de l\'enregistrement des statistiques: $e');
    }
  }

  // Obtenir les statistiques globales
  Future<Map<String, dynamic>> getGlobalStats() async {
    try {
      final statsDoc = await _firestore.collection('analytics').doc('global').get();
      if (statsDoc.exists) {
        return statsDoc.data()!;
      }
      return {};
    } catch (e) {
      return {};
    }
  }

  // Enregistrer les statistiques globales
  Future<void> recordGlobalStats(Map<String, dynamic> stats) async {
    try {
      await _firestore.collection('analytics').doc('global').set({
        ...stats,
        'last_updated': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    } catch (e) {
      print('Erreur lors de l\'enregistrement des statistiques globales: $e');
    }
  }

  // Obtenir les statistiques de guides populaires
  Future<List<Map<String, dynamic>>> getPopularGuides({int limit = 10}) async {
    try {
      final snapshot = await _firestore
          .collection('analytics')
          .doc('guides')
          .collection('popularity')
          .orderBy('view_count', descending: true)
          .limit(limit)
          .get();
      
      return snapshot.docs.map((doc) => {
        'guide_id': doc.id,
        ...doc.data(),
      }).toList();
    } catch (e) {
      return [];
    }
  }

  // Enregistrer la popularité d'un guide
  Future<void> recordGuidePopularity(String guideId, String guideTitle, String category) async {
    try {
      await _firestore
          .collection('analytics')
          .doc('guides')
          .collection('popularity')
          .doc(guideId)
          .set({
        'guide_title': guideTitle,
        'category': category,
        'view_count': FieldValue.increment(1),
        'last_viewed': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    } catch (e) {
      print('Erreur lors de l\'enregistrement de la popularité: $e');
    }
  }

  // Obtenir les statistiques de catégories
  Future<Map<String, int>> getCategoryStats() async {
    try {
      final snapshot = await _firestore
          .collection('analytics')
          .doc('categories')
          .get();
      
      if (snapshot.exists) {
        final data = snapshot.data()!;
        return Map<String, int>.from(data);
      }
      return {};
    } catch (e) {
      return {};
    }
  }

  // Enregistrer les statistiques de catégorie
  Future<void> recordCategoryView(String category) async {
    try {
      await _firestore
          .collection('analytics')
          .doc('categories')
          .set({
        category: FieldValue.increment(1),
        'last_updated': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    } catch (e) {
      print('Erreur lors de l\'enregistrement des statistiques de catégorie: $e');
    }
  }
}
