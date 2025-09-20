import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../../data/services/firestore_guide_service.dart';
import '../../data/local/database.dart';
import '../../domain/entities/user_profile.dart';

class SyncService {
  final FirestoreGuideService _firestoreService = FirestoreGuideService();
  final AppDatabase _localDb = AppDatabase();
  final Connectivity _connectivity = Connectivity();
  
  StreamSubscription<ConnectivityResult>? _connectivitySubscription;
  Timer? _syncTimer;
  
  bool _isOnline = false;
  bool _isSyncing = false;
  
  // Streams pour notifier les changements
  final StreamController<bool> _onlineStatusController = StreamController<bool>.broadcast();
  final StreamController<bool> _syncStatusController = StreamController<bool>.broadcast();
  final StreamController<List<Guide>> _newGuidesController = StreamController<List<Guide>>.broadcast();
  
  Stream<bool> get onlineStatusStream => _onlineStatusController.stream;
  Stream<bool> get syncStatusStream => _syncStatusController.stream;
  Stream<List<Guide>> get newGuidesStream => _newGuidesController.stream;
  
  bool get isOnline => _isOnline;
  bool get isSyncing => _isSyncing;

  // Initialiser le service de synchronisation
  Future<void> initialize() async {
    // Vérifier la connectivité initiale
    await _checkConnectivity();
    
    // Écouter les changements de connectivité
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen((result) {
      _handleConnectivityChange(result);
    });
    
    // Démarrer la synchronisation périodique
    _startPeriodicSync();
  }

  // Vérifier la connectivité
  Future<void> _checkConnectivity() async {
    try {
      final result = await _connectivity.checkConnectivity();
      _isOnline = result != ConnectivityResult.none;
      _onlineStatusController.add(_isOnline);
    } catch (e) {
      _isOnline = false;
      _onlineStatusController.add(false);
    }
  }

  // Gérer les changements de connectivité
  void _handleConnectivityChange(ConnectivityResult result) {
    final wasOnline = _isOnline;
    _isOnline = result != ConnectivityResult.none;
    
    if (_isOnline != wasOnline) {
      _onlineStatusController.add(_isOnline);
      
      if (_isOnline) {
        // Synchroniser immédiatement quand on revient en ligne
        syncAllData();
      }
    }
  }

  // Démarrer la synchronisation périodique
  void _startPeriodicSync() {
    _syncTimer = Timer.periodic(const Duration(minutes: 5), (timer) {
      if (_isOnline && !_isSyncing) {
        syncAllData();
      }
    });
  }

  // Synchroniser toutes les données
  Future<void> syncAllData() async {
    if (_isSyncing || !_isOnline) return;
    
    _isSyncing = true;
    _syncStatusController.add(true);
    
    try {
      // Synchroniser les guides
      await syncGuides();
      
      // Synchroniser les données utilisateur si connecté
      await _syncUserData();
      
      print('Synchronisation terminée avec succès');
    } catch (e) {
      print('Erreur lors de la synchronisation: $e');
    } finally {
      _isSyncing = false;
      _syncStatusController.add(false);
    }
  }

  // Synchroniser les guides
  Future<void> syncGuides() async {
    try {
      // Vérifier s'il y a de nouveaux guides
      final hasNewGuides = await _firestoreService.hasNewGuides();
      
      if (hasNewGuides) {
        // Obtenir les guides mis à jour
        final updatedGuides = await _firestoreService.getUpdatedGuides();
        
        if (updatedGuides.isNotEmpty) {
          // Notifier les nouveaux guides
          _newGuidesController.add(updatedGuides);
        }
        
        // Synchroniser tous les guides
        await _firestoreService.syncGuidesFromFirestore();
      }
    } catch (e) {
      print('Erreur lors de la synchronisation des guides: $e');
    }
  }

  // Synchroniser les données utilisateur
  Future<void> _syncUserData() async {
    try {
      // Récupérer l'utilisateur actuel depuis la base locale
      final users = await _localDb.select(_localDb.users).get();
      if (users.isEmpty) return;
      
      final user = users.first;
      
      // Synchroniser le profil utilisateur
      await _firestoreService.syncUserDataToFirestore(user.id, {
        'email': user.email,
        'displayName': user.displayName,
        'photoUrl': user.photoUrl,
        'countryOfOrigin': user.countryOfOrigin,
        'university': user.university,
        'level': user.level,
        'phoneNumber': user.phoneNumber,
        'isFirstTime': user.isFirstTime,
        'updatedAt': FieldValue.serverTimestamp(),
      });
      
      // Synchroniser la progression
      final progressList = await _localDb.getUserProgresses(user.id);
      for (final progress in progressList) {
        await _firestoreService.syncUserProgressToFirestore(user.id, progress.guideId, {
          'userId': progress.userId,
          'guideId': progress.guideId,
          'stepProgress': progress.stepProgress,
          'isCompleted': progress.isCompleted,
          'completionPercentage': progress.completionPercentage,
          'startedAt': progress.startedAt,
          'completedAt': progress.completedAt,
          'lastUpdatedAt': progress.lastUpdatedAt,
        });
      }
      
      // Synchroniser les favoris
      final favorites = await _localDb.getUserFavorites(user.id);
      for (final favorite in favorites) {
        await _firestoreService.syncUserFavoritesToFirestore(
          user.id, 
          favorite.guideId, 
          true
        );
      }
      
      // Synchroniser l'historique
      final viewedGuides = await _localDb.getUserViewedGuides(user.id);
      for (final viewed in viewedGuides) {
        await _firestoreService.syncUserViewedGuidesToFirestore(
          user.id, 
          viewed.guideId
        );
      }
      
    } catch (e) {
      print('Erreur lors de la synchronisation des données utilisateur: $e');
    }
  }

  // Synchroniser la progression d'un guide
  Future<void> syncGuideProgress(String userId, String guideId, Map<String, bool> stepProgress) async {
    if (!_isOnline) return;
    
    try {
      await _firestoreService.syncUserProgressToFirestore(userId, guideId, {
        'userId': userId,
        'guideId': guideId,
        'stepProgress': stepProgress,
        'isCompleted': stepProgress.values.every((completed) => completed),
        'completionPercentage': (stepProgress.values.where((completed) => completed).length / stepProgress.length * 100).round(),
        'lastUpdatedAt': DateTime.now(),
      });
    } catch (e) {
      print('Erreur lors de la synchronisation de la progression: $e');
    }
  }

  // Synchroniser un favori
  Future<void> syncFavorite(String userId, String guideId, bool isFavorite) async {
    if (!_isOnline) return;
    
    try {
      await _firestoreService.syncUserFavoritesToFirestore(userId, guideId, isFavorite);
    } catch (e) {
      print('Erreur lors de la synchronisation du favori: $e');
    }
  }

  // Synchroniser un guide consulté
  Future<void> syncViewedGuide(String userId, String guideId) async {
    if (!_isOnline) return;
    
    try {
      await _firestoreService.syncUserViewedGuidesToFirestore(userId, guideId);
    } catch (e) {
      print('Erreur lors de la synchronisation du guide consulté: $e');
    }
  }

  // Forcer la synchronisation
  Future<void> forceSync() async {
    if (_isSyncing) return;
    
    await syncAllData();
  }

  // Obtenir le statut de synchronisation
  Future<Map<String, dynamic>> getSyncStatus() async {
    final guidesStatus = await _localDb.getSyncStatus('guides');
    final usersStatus = await _localDb.getSyncStatus('users');
    
    return {
      'isOnline': _isOnline,
      'isSyncing': _isSyncing,
      'lastGuidesSync': guidesStatus?.lastSyncAt,
      'lastUsersSync': usersStatus?.lastSyncAt,
      'guidesError': guidesStatus?.lastError,
      'usersError': usersStatus?.lastError,
    };
  }

  // Nettoyer les ressources
  void dispose() {
    _connectivitySubscription?.cancel();
    _syncTimer?.cancel();
    _onlineStatusController.close();
    _syncStatusController.close();
    _newGuidesController.close();
  }
}
