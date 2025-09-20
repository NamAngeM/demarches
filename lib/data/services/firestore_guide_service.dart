import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/guide.dart';
import '../local/database.dart';

class FirestoreGuideService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AppDatabase _localDb = AppDatabase();

  // Collection references
  CollectionReference get _guidesCollection => _firestore.collection('guides');
  CollectionReference get _guideStepsCollection => _firestore.collection('guide_steps');

  // Synchroniser tous les guides depuis Firestore
  Future<void> syncGuidesFromFirestore() async {
    try {
      final QuerySnapshot guidesSnapshot = await _guidesCollection.get();
      
      for (final doc in guidesSnapshot.docs) {
        final guideData = doc.data() as Map<String, dynamic>;
        final guideId = doc.id;
        
        // Convertir les données Firestore en modèle local
        final guide = GuidesCompanion.insert(
          id: guideId,
          title: guideData['title'] as String,
          description: guideData['description'] as String,
          shortDescription: guideData['shortDescription'] as String,
          category: guideData['category'] as String,
          difficulty: guideData['difficulty'] as String,
          estimatedDuration: guideData['estimatedDuration'] as String,
          tags: List<String>.from(guideData['tags'] as List),
          imageUrl: guideData['imageUrl'] as String?,
          isPublished: guideData['isPublished'] as bool? ?? true,
          createdAt: (guideData['createdAt'] as Timestamp).toDate(),
          updatedAt: (guideData['updatedAt'] as Timestamp).toDate(),
        );
        
        // Insérer ou mettre à jour dans la base locale
        await _localDb.insertGuide(guide);
        
        // Synchroniser les étapes du guide
        await _syncGuideSteps(guideId);
      }
      
      // Mettre à jour le statut de synchronisation
      await _localDb.updateSyncStatus(SyncStatusCompanion.insert(
        id: 'guides',
        tableName: 'guides',
        lastSyncAt: DateTime.now(),
        isOnline: true,
        lastError: null,
      ));
    } catch (e) {
      // Enregistrer l'erreur
      await _localDb.updateSyncStatus(SyncStatusCompanion.insert(
        id: 'guides',
        tableName: 'guides',
        lastSyncAt: DateTime.now(),
        isOnline: false,
        lastError: e.toString(),
      ));
      rethrow;
    }
  }

  // Synchroniser les étapes d'un guide
  Future<void> _syncGuideSteps(String guideId) async {
    try {
      final QuerySnapshot stepsSnapshot = await _guideStepsCollection
          .where('guideId', isEqualTo: guideId)
          .orderBy('stepNumber')
          .get();
      
      // Supprimer les anciennes étapes
      await _localDb.deleteGuideSteps(guideId);
      
      for (final doc in stepsSnapshot.docs) {
        final stepData = doc.data() as Map<String, dynamic>;
        
        final step = GuideStepsCompanion.insert(
          id: doc.id,
          guideId: guideId,
          stepNumber: stepData['stepNumber'] as int,
          title: stepData['title'] as String,
          description: stepData['description'] as String,
          requirements: stepData['requirements'] != null 
              ? List<String>.from(stepData['requirements'] as List)
              : null,
          estimatedTime: stepData['estimatedTime'] as String?,
          cost: stepData['cost'] as String?,
          createdAt: (stepData['createdAt'] as Timestamp).toDate(),
          updatedAt: (stepData['updatedAt'] as Timestamp).toDate(),
        );
        
        await _localDb.insertGuideStep(step);
      }
    } catch (e) {
      print('Erreur lors de la synchronisation des étapes: $e');
    }
  }

  // Obtenir tous les guides (local d'abord, puis Firestore si nécessaire)
  Future<List<Guide>> getAllGuides({bool forceRefresh = false}) async {
    if (forceRefresh) {
      await syncGuidesFromFirestore();
    }
    
    final localGuides = await _localDb.getAllGuides();
    
    // Si pas de données locales, synchroniser depuis Firestore
    if (localGuides.isEmpty) {
      await syncGuidesFromFirestore();
      return await _localDb.getAllGuides();
    }
    
    return localGuides;
  }

  // Obtenir un guide par ID
  Future<Guide?> getGuideById(String id, {bool forceRefresh = false}) async {
    if (forceRefresh) {
      await syncGuidesFromFirestore();
    }
    
    return await _localDb.getGuideById(id);
  }

  // Obtenir les guides par catégorie
  Future<List<Guide>> getGuidesByCategory(String category, {bool forceRefresh = false}) async {
    if (forceRefresh) {
      await syncGuidesFromFirestore();
    }
    
    return await _localDb.getGuidesByCategory(category);
  }

  // Rechercher des guides
  Future<List<Guide>> searchGuides(String query, {bool forceRefresh = false}) async {
    if (forceRefresh) {
      await syncGuidesFromFirestore();
    }
    
    return await _localDb.searchGuides(query);
  }

  // Obtenir les étapes d'un guide
  Future<List<GuideStep>> getGuideSteps(String guideId) async {
    return await _localDb.getStepsForGuide(guideId);
  }

  // Vérifier s'il y a de nouveaux guides
  Future<bool> hasNewGuides() async {
    try {
      final lastSync = await _localDb.getSyncStatus('guides');
      if (lastSync == null) return true;
      
      final QuerySnapshot snapshot = await _guidesCollection
          .where('updatedAt', isGreaterThan: Timestamp.fromDate(lastSync.lastSyncAt))
          .get();
      
      return snapshot.docs.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  // Obtenir les guides mis à jour depuis la dernière synchronisation
  Future<List<Guide>> getUpdatedGuides() async {
    try {
      final lastSync = await _localDb.getSyncStatus('guides');
      if (lastSync == null) return [];
      
      final QuerySnapshot snapshot = await _guidesCollection
          .where('updatedAt', isGreaterThan: Timestamp.fromDate(lastSync.lastSyncAt))
          .get();
      
      final List<Guide> updatedGuides = [];
      for (final doc in snapshot.docs) {
        final guideData = doc.data() as Map<String, dynamic>;
        final guide = Guide(
          id: doc.id,
          title: guideData['title'] as String,
          description: guideData['description'] as String,
          shortDescription: guideData['shortDescription'] as String,
          category: GuideCategory.values.firstWhere(
            (e) => e.name == guideData['category'],
            orElse: () => GuideCategory.visa,
          ),
          difficulty: guideData['difficulty'] as String,
          estimatedDuration: guideData['estimatedDuration'] as String,
          tags: List<String>.from(guideData['tags'] as List),
          imageUrl: guideData['imageUrl'] as String?,
          isFavorite: false, // Sera mis à jour par le service local
          createdAt: (guideData['createdAt'] as Timestamp).toDate(),
          updatedAt: (guideData['updatedAt'] as Timestamp).toDate(),
        );
        updatedGuides.add(guide);
      }
      
      return updatedGuides;
    } catch (e) {
      return [];
    }
  }

  // Synchroniser les données utilisateur vers Firestore
  Future<void> syncUserDataToFirestore(String userId, Map<String, dynamic> userData) async {
    try {
      await _firestore.collection('users').doc(userId).set(userData, SetOptions(merge: true));
    } catch (e) {
      print('Erreur lors de la synchronisation des données utilisateur: $e');
    }
  }

  // Synchroniser la progression utilisateur vers Firestore
  Future<void> syncUserProgressToFirestore(String userId, String guideId, Map<String, dynamic> progressData) async {
    try {
      await _firestore
          .collection('user_progress')
          .doc('${userId}_$guideId')
          .set(progressData, SetOptions(merge: true));
    } catch (e) {
      print('Erreur lors de la synchronisation de la progression: $e');
    }
  }

  // Synchroniser les favoris vers Firestore
  Future<void> syncUserFavoritesToFirestore(String userId, String guideId, bool isFavorite) async {
    try {
      if (isFavorite) {
        await _firestore
            .collection('user_favorites')
            .doc('${userId}_$guideId')
            .set({
          'userId': userId,
          'guideId': guideId,
          'addedAt': FieldValue.serverTimestamp(),
        });
      } else {
        await _firestore
            .collection('user_favorites')
            .doc('${userId}_$guideId')
            .delete();
      }
    } catch (e) {
      print('Erreur lors de la synchronisation des favoris: $e');
    }
  }

  // Synchroniser l'historique des guides consultés vers Firestore
  Future<void> syncUserViewedGuidesToFirestore(String userId, String guideId) async {
    try {
      await _firestore
          .collection('user_viewed_guides')
          .doc('${userId}_$guideId')
          .set({
        'userId': userId,
        'guideId': guideId,
        'viewedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Erreur lors de la synchronisation de l\'historique: $e');
    }
  }

  // Obtenir les statistiques d'usage depuis Firestore
  Future<Map<String, int>> getUserUsageStats(String userId) async {
    try {
      final progressSnapshot = await _firestore
          .collection('user_progress')
          .where('userId', isEqualTo: userId)
          .get();
      
      final favoritesSnapshot = await _firestore
          .collection('user_favorites')
          .where('userId', isEqualTo: userId)
          .get();
      
      final viewedSnapshot = await _firestore
          .collection('user_viewed_guides')
          .where('userId', isEqualTo: userId)
          .get();
      
      return {
        'completedGuides': progressSnapshot.docs.length,
        'favoriteGuides': favoritesSnapshot.docs.length,
        'viewedGuides': viewedSnapshot.docs.length,
      };
    } catch (e) {
      return {'completedGuides': 0, 'favoriteGuides': 0, 'viewedGuides': 0};
    }
  }

  // Écouter les changements en temps réel
  Stream<List<Guide>> watchGuides() {
    return _guidesCollection
        .orderBy('updatedAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Guide(
          id: doc.id,
          title: data['title'] as String,
          description: data['description'] as String,
          shortDescription: data['shortDescription'] as String,
          category: GuideCategory.values.firstWhere(
            (e) => e.name == data['category'],
            orElse: () => GuideCategory.visa,
          ),
          difficulty: data['difficulty'] as String,
          estimatedDuration: data['estimatedDuration'] as String,
          tags: List<String>.from(data['tags'] as List),
          imageUrl: data['imageUrl'] as String?,
          isFavorite: false,
          createdAt: (data['createdAt'] as Timestamp).toDate(),
          updatedAt: (data['updatedAt'] as Timestamp).toDate(),
        );
      }).toList();
    });
  }
}
