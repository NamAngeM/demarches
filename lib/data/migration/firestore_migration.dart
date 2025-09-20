import 'package:cloud_firestore/cloud_firestore.dart';
import '../datasources/guides_local_data.dart';
import '../../domain/entities/guide.dart';

class FirestoreMigration {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Migrer tous les guides vers Firestore
  Future<void> migrateGuidesToFirestore() async {
    try {
      print('Début de la migration des guides vers Firestore...');
      
      final guides = GuidesLocalData.getAllGuides();
      
      for (final guide in guides) {
        await _migrateGuide(guide);
      }
      
      print('Migration des guides terminée avec succès!');
    } catch (e) {
      print('Erreur lors de la migration des guides: $e');
      rethrow;
    }
  }

  // Migrer un guide vers Firestore
  Future<void> _migrateGuide(Guide guide) async {
    try {
      // Migrer le guide principal
      await _firestore.collection('guides').doc(guide.id).set({
        'title': guide.title,
        'description': guide.description,
        'shortDescription': guide.shortDescription,
        'category': guide.category.name,
        'difficulty': guide.difficulty,
        'estimatedDuration': guide.estimatedDuration,
        'tags': guide.tags,
        'imageUrl': guide.imageUrl,
        'isPublished': true,
        'createdAt': Timestamp.fromDate(guide.createdAt),
        'updatedAt': Timestamp.fromDate(guide.updatedAt),
      });

      // Migrer les étapes du guide
      for (int i = 0; i < guide.steps.length; i++) {
        final step = guide.steps[i];
        await _firestore.collection('guide_steps').add({
          'guideId': guide.id,
          'stepNumber': i + 1,
          'title': step.title,
          'description': step.description,
          'requirements': step.requirements,
          'estimatedTime': step.estimatedTime,
          'cost': step.cost,
          'createdAt': Timestamp.fromDate(DateTime.now()),
          'updatedAt': Timestamp.fromDate(DateTime.now()),
        });
      }

      print('Guide migré: ${guide.title}');
    } catch (e) {
      print('Erreur lors de la migration du guide ${guide.title}: $e');
    }
  }

  // Créer les collections de base avec des données d'exemple
  Future<void> createBaseCollections() async {
    try {
      // Créer la collection des catégories
      await _createCategoriesCollection();
      
      // Créer la collection des universités
      await _createUniversitiesCollection();
      
      // Créer la collection des pays
      await _createCountriesCollection();
      
      print('Collections de base créées avec succès!');
    } catch (e) {
      print('Erreur lors de la création des collections de base: $e');
    }
  }

  // Créer la collection des catégories
  Future<void> _createCategoriesCollection() async {
    final categories = [
      {'id': 'visa', 'name': 'Visa', 'description': 'Procédures de visa et titres de séjour', 'icon': 'visa', 'color': '#FF6B6B'},
      {'id': 'housing', 'name': 'Logement', 'description': 'Trouver et gérer son logement', 'icon': 'home', 'color': '#4ECDC4'},
      {'id': 'banking', 'name': 'Banque', 'description': 'Ouvrir un compte bancaire et gérer ses finances', 'icon': 'account_balance', 'color': '#45B7D1'},
      {'id': 'health', 'name': 'Santé', 'description': 'Assurance maladie et soins de santé', 'icon': 'local_hospital', 'color': '#96CEB4'},
      {'id': 'transport', 'name': 'Transport', 'description': 'Transports en commun et mobilité', 'icon': 'directions_transit', 'color': '#FFEAA7'},
      {'id': 'work', 'name': 'Travail', 'description': 'Recherche d\'emploi et stages', 'icon': 'work', 'color': '#DDA0DD'},
      {'id': 'education', 'name': 'Éducation', 'description': 'Inscription et vie étudiante', 'icon': 'school', 'color': '#98D8C8'},
      {'id': 'culture', 'name': 'Culture', 'description': 'Découvrir la culture française', 'icon': 'palette', 'color': '#F7DC6F'},
    ];

    for (final category in categories) {
      await _firestore.collection('categories').doc(category['id']).set({
        'name': category['name'],
        'description': category['description'],
        'icon': category['icon'],
        'color': category['color'],
        'createdAt': Timestamp.fromDate(DateTime.now()),
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      });
    }
  }

  // Créer la collection des universités
  Future<void> _createUniversitiesCollection() async {
    final universities = [
      {'id': 'paris1', 'name': 'Université Paris 1 Panthéon-Sorbonne', 'city': 'Paris', 'type': 'public'},
      {'id': 'paris2', 'name': 'Université Paris 2 Panthéon-Assas', 'city': 'Paris', 'type': 'public'},
      {'id': 'sorbonne', 'name': 'Sorbonne Université', 'city': 'Paris', 'type': 'public'},
      {'id': 'lyon1', 'name': 'Université Claude Bernard Lyon 1', 'city': 'Lyon', 'type': 'public'},
      {'id': 'lyon2', 'name': 'Université Lumière Lyon 2', 'city': 'Lyon', 'type': 'public'},
      {'id': 'toulouse1', 'name': 'Université Toulouse 1 Capitole', 'city': 'Toulouse', 'type': 'public'},
      {'id': 'lille1', 'name': 'Université de Lille', 'city': 'Lille', 'type': 'public'},
      {'id': 'bordeaux', 'name': 'Université de Bordeaux', 'city': 'Bordeaux', 'type': 'public'},
      {'id': 'strasbourg', 'name': 'Université de Strasbourg', 'city': 'Strasbourg', 'type': 'public'},
      {'id': 'montpellier', 'name': 'Université de Montpellier', 'city': 'Montpellier', 'type': 'public'},
    ];

    for (final university in universities) {
      await _firestore.collection('universities').doc(university['id']).set({
        'name': university['name'],
        'city': university['city'],
        'type': university['type'],
        'createdAt': Timestamp.fromDate(DateTime.now()),
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      });
    }
  }

  // Créer la collection des pays
  Future<void> _createCountriesCollection() async {
    final countries = [
      {'id': 'germany', 'name': 'Allemagne', 'code': 'DE', 'continent': 'Europe'},
      {'id': 'belgium', 'name': 'Belgique', 'code': 'BE', 'continent': 'Europe'},
      {'id': 'canada', 'name': 'Canada', 'code': 'CA', 'continent': 'North America'},
      {'id': 'spain', 'name': 'Espagne', 'code': 'ES', 'continent': 'Europe'},
      {'id': 'usa', 'name': 'États-Unis', 'code': 'US', 'continent': 'North America'},
      {'id': 'italy', 'name': 'Italie', 'code': 'IT', 'continent': 'Europe'},
      {'id': 'morocco', 'name': 'Maroc', 'code': 'MA', 'continent': 'Africa'},
      {'id': 'portugal', 'name': 'Portugal', 'code': 'PT', 'continent': 'Europe'},
      {'id': 'uk', 'name': 'Royaume-Uni', 'code': 'GB', 'continent': 'Europe'},
      {'id': 'switzerland', 'name': 'Suisse', 'code': 'CH', 'continent': 'Europe'},
      {'id': 'tunisia', 'name': 'Tunisie', 'code': 'TN', 'continent': 'Africa'},
    ];

    for (final country in countries) {
      await _firestore.collection('countries').doc(country['id']).set({
        'name': country['name'],
        'code': country['code'],
        'continent': country['continent'],
        'createdAt': Timestamp.fromDate(DateTime.now()),
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      });
    }
  }

  // Créer des données d'analytics de base
  Future<void> createAnalyticsData() async {
    try {
      // Créer les statistiques globales
      await _firestore.collection('analytics').doc('global').set({
        'total_users': 0,
        'total_guides': 0,
        'total_views': 0,
        'total_completions': 0,
        'last_updated': Timestamp.fromDate(DateTime.now()),
      });

      // Créer les statistiques de catégories
      await _firestore.collection('analytics').doc('categories').set({
        'visa': 0,
        'housing': 0,
        'banking': 0,
        'health': 0,
        'transport': 0,
        'work': 0,
        'education': 0,
        'culture': 0,
        'last_updated': Timestamp.fromDate(DateTime.now()),
      });

      print('Données d\'analytics créées avec succès!');
    } catch (e) {
      print('Erreur lors de la création des données d\'analytics: $e');
    }
  }

  // Vérifier si la migration est nécessaire
  Future<bool> isMigrationNeeded() async {
    try {
      final snapshot = await _firestore.collection('guides').limit(1).get();
      return snapshot.docs.isEmpty;
    } catch (e) {
      return true;
    }
  }

  // Exécuter la migration complète
  Future<void> runFullMigration() async {
    try {
      print('Vérification de la nécessité de migration...');
      
      if (await isMigrationNeeded()) {
        print('Migration nécessaire, démarrage...');
        
        await createBaseCollections();
        await migrateGuidesToFirestore();
        await createAnalyticsData();
        
        print('Migration complète terminée avec succès!');
      } else {
        print('Migration non nécessaire, les données existent déjà.');
      }
    } catch (e) {
      print('Erreur lors de la migration complète: $e');
      rethrow;
    }
  }

  // Nettoyer les données de test
  Future<void> cleanupTestData() async {
    try {
      // Supprimer tous les guides
      final guidesSnapshot = await _firestore.collection('guides').get();
      for (final doc in guidesSnapshot.docs) {
        await doc.reference.delete();
      }

      // Supprimer toutes les étapes
      final stepsSnapshot = await _firestore.collection('guide_steps').get();
      for (final doc in stepsSnapshot.docs) {
        await doc.reference.delete();
      }

      print('Données de test nettoyées avec succès!');
    } catch (e) {
      print('Erreur lors du nettoyage des données de test: $e');
    }
  }
}
