import 'dart:convert';
import 'package:algolia/algolia.dart';
import 'package:fuse_dart/fuse_dart.dart';
import '../../domain/entities/guide.dart';
import '../../data/services/firestore_guide_service.dart';

class AdvancedSearchService {
  final FirestoreGuideService _guideService = FirestoreGuideService();
  final Algolia _algolia = Algolia.init(
    applicationId: 'YOUR_ALGOLIA_APP_ID',
    apiKey: 'YOUR_ALGOLIA_SEARCH_KEY',
  );

  // Configuration Fuse pour la recherche locale
  late Fuse<Guide> _fuse;
  List<Guide> _allGuides = [];

  // Initialiser le service de recherche
  Future<void> initialize() async {
    try {
      _allGuides = await _guideService.getAllGuides();
      _initializeFuse();
    } catch (e) {
      print('Erreur lors de l\'initialisation du service de recherche: $e');
    }
  }

  // Initialiser Fuse pour la recherche locale
  void _initializeFuse() {
    final options = FuseOptions<Guide>(
      keys: [
        WeightedKey(WeightedProperty('title', 0.3)),
        WeightedKey(WeightedProperty('description', 0.2)),
        WeightedKey(WeightedProperty('shortDescription', 0.1)),
        WeightedKey(WeightedProperty('tags', 0.2)),
        WeightedKey(WeightedProperty('category', 0.1)),
        WeightedKey(WeightedProperty('difficulty', 0.1)),
      ],
      threshold: 0.3,
      distance: 100,
      includeScore: true,
    );

    _fuse = Fuse<Guide>(_allGuides, options);
  }

  // Recherche full-text avec Algolia
  Future<List<Guide>> searchWithAlgolia(String query, {
    String? category,
    String? difficulty,
    String? duration,
    int limit = 20,
  }) async {
    try {
      final algoliaQuery = _algolia.index('guides');
      
      var searchQuery = algoliaQuery.query(query);
      
      // Appliquer les filtres
      if (category != null) {
        searchQuery = searchQuery.filters('category:$category');
      }
      if (difficulty != null) {
        searchQuery = searchQuery.filters('difficulty:$difficulty');
      }
      if (duration != null) {
        searchQuery = searchQuery.filters('duration:$duration');
      }
      
      final searchResult = await searchQuery
          .hitsPerPage(limit)
          .getObjects();
      
      return _convertAlgoliaResultsToGuides(searchResult.hits);
    } catch (e) {
      print('Erreur lors de la recherche Algolia: $e');
      // Fallback vers la recherche locale
      return searchLocally(query, category: category, difficulty: difficulty, duration: duration);
    }
  }

  // Recherche locale avec Fuse
  List<Guide> searchLocally(String query, {
    String? category,
    String? difficulty,
    String? duration,
  }) {
    try {
      if (query.isEmpty) {
        return _applyFilters(_allGuides, category: category, difficulty: difficulty, duration: duration);
      }

      final searchResults = _fuse.search(query);
      final guides = searchResults.map((result) => result.item).toList();
      
      return _applyFilters(guides, category: category, difficulty: difficulty, duration: duration);
    } catch (e) {
      print('Erreur lors de la recherche locale: $e');
      return [];
    }
  }

  // Appliquer les filtres
  List<Guide> _applyFilters(List<Guide> guides, {
    String? category,
    String? difficulty,
    String? duration,
  }) {
    return guides.where((guide) {
      if (category != null && guide.category.name != category) return false;
      if (difficulty != null && guide.difficulty != difficulty) return false;
      if (duration != null && !_matchesDuration(guide.estimatedDuration, duration)) return false;
      return true;
    }).toList();
  }

  // Vérifier si la durée correspond au filtre
  bool _matchesDuration(String guideDuration, String filterDuration) {
    final guideLower = guideDuration.toLowerCase();
    final filterLower = filterDuration.toLowerCase();
    
    if (filterLower.contains('court')) {
      return guideLower.contains('jour') || guideLower.contains('semaine');
    } else if (filterLower.contains('moyen')) {
      return guideLower.contains('semaine') || guideLower.contains('mois');
    } else if (filterLower.contains('long')) {
      return guideLower.contains('mois');
    }
    
    return true;
  }

  // Convertir les résultats Algolia en guides
  List<Guide> _convertAlgoliaResultsToGuides(List<AlgoliaObjectSnapshot> hits) {
    return hits.map((hit) {
      final data = hit.data;
      return Guide(
        id: data['objectID'] as String,
        title: data['title'] as String,
        description: data['description'] as String,
        shortDescription: data['shortDescription'] as String,
        category: GuideCategory.values.firstWhere(
          (e) => e.name == data['category'],
          orElse: () => GuideCategory.visa,
        ),
        steps: [], // Les étapes ne sont pas indexées
        difficulty: data['difficulty'] as String,
        estimatedDuration: data['estimatedDuration'] as String,
        tags: List<String>.from(data['tags'] as List),
        imageUrl: data['imageUrl'] as String?,
        isFavorite: false,
        createdAt: DateTime.parse(data['createdAt'] as String),
        updatedAt: DateTime.parse(data['updatedAt'] as String),
      );
    }).toList();
  }

  // Obtenir des suggestions de recherche
  Future<List<String>> getSearchSuggestions(String query) async {
    try {
      if (query.length < 2) return [];

      final suggestions = <String>{};
      
      // Suggestions basées sur les titres
      for (final guide in _allGuides) {
        if (guide.title.toLowerCase().contains(query.toLowerCase())) {
          suggestions.add(guide.title);
        }
      }
      
      // Suggestions basées sur les tags
      for (final guide in _allGuides) {
        for (final tag in guide.tags) {
          if (tag.toLowerCase().contains(query.toLowerCase())) {
            suggestions.add(tag);
          }
        }
      }
      
      // Suggestions basées sur les catégories
      for (final category in GuideCategory.values) {
        if (category.displayName.toLowerCase().contains(query.toLowerCase())) {
          suggestions.add(category.displayName);
        }
      }

      return suggestions.take(10).toList();
    } catch (e) {
      print('Erreur lors de la récupération des suggestions: $e');
      return [];
    }
  }

  // Obtenir l'historique de recherche
  Future<List<String>> getSearchHistory() async {
    try {
      // TODO: Implémenter la sauvegarde de l'historique
      return [];
    } catch (e) {
      print('Erreur lors de la récupération de l\'historique: $e');
      return [];
    }
  }

  // Sauvegarder une recherche dans l'historique
  Future<void> saveSearchToHistory(String query) async {
    try {
      // TODO: Implémenter la sauvegarde de l'historique
    } catch (e) {
      print('Erreur lors de la sauvegarde de l\'historique: $e');
    }
  }

  // Effacer l'historique de recherche
  Future<void> clearSearchHistory() async {
    try {
      // TODO: Implémenter l'effacement de l'historique
    } catch (e) {
      print('Erreur lors de l\'effacement de l\'historique: $e');
    }
  }

  // Obtenir les filtres disponibles
  Map<String, List<String>> getAvailableFilters() {
    return {
      'categories': GuideCategory.values.map((e) => e.displayName).toList(),
      'difficulties': ['Facile', 'Moyen', 'Difficile'],
      'durations': ['Court (1-7 jours)', 'Moyen (1-4 semaines)', 'Long (1+ mois)'],
    };
  }

  // Obtenir les guides populaires
  Future<List<Guide>> getPopularGuides({int limit = 10}) async {
    try {
      // Simuler la popularité basée sur les tags
      final popularGuides = _allGuides.where((guide) {
        return guide.tags.contains('populaire') ||
               guide.tags.contains('essentiel') ||
               guide.category.name == 'visa';
      }).toList();

      return popularGuides.take(limit).toList();
    } catch (e) {
      print('Erreur lors de la récupération des guides populaires: $e');
      return [];
    }
  }

  // Obtenir les guides récents
  Future<List<Guide>> getRecentGuides({int limit = 10}) async {
    try {
      final recentGuides = List<Guide>.from(_allGuides)
        ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
      
      return recentGuides.take(limit).toList();
    } catch (e) {
      print('Erreur lors de la récupération des guides récents: $e');
      return [];
    }
  }

  // Obtenir les guides recommandés
  Future<List<Guide>> getRecommendedGuides(String userId, {int limit = 10}) async {
    try {
      // TODO: Implémenter la logique de recommandation basée sur l'historique
      return getPopularGuides(limit: limit);
    } catch (e) {
      print('Erreur lors de la récupération des guides recommandés: $e');
      return [];
    }
  }

  // Recherche avancée avec plusieurs critères
  Future<List<Guide>> advancedSearch({
    String? query,
    List<String>? categories,
    List<String>? difficulties,
    List<String>? durations,
    List<String>? tags,
    String? sortBy,
    bool ascending = true,
    int limit = 20,
  }) async {
    try {
      List<Guide> results = _allGuides;

      // Filtrer par catégories
      if (categories != null && categories.isNotEmpty) {
        results = results.where((guide) => 
          categories.contains(guide.category.displayName)
        ).toList();
      }

      // Filtrer par difficultés
      if (difficulties != null && difficulties.isNotEmpty) {
        results = results.where((guide) => 
          difficulties.contains(guide.difficulty)
        ).toList();
      }

      // Filtrer par durées
      if (durations != null && durations.isNotEmpty) {
        results = results.where((guide) => 
          durations.any((duration) => _matchesDuration(guide.estimatedDuration, duration))
        ).toList();
      }

      // Filtrer par tags
      if (tags != null && tags.isNotEmpty) {
        results = results.where((guide) => 
          tags.any((tag) => guide.tags.any((guideTag) => 
            guideTag.toLowerCase().contains(tag.toLowerCase())
          ))
        ).toList();
      }

      // Recherche textuelle
      if (query != null && query.isNotEmpty) {
        results = searchLocally(query, 
          category: categories?.isNotEmpty == true ? categories!.first : null,
          difficulty: difficulties?.isNotEmpty == true ? difficulties!.first : null,
          duration: durations?.isNotEmpty == true ? durations!.first : null,
        );
      }

      // Trier les résultats
      if (sortBy != null) {
        results = _sortResults(results, sortBy, ascending);
      }

      return results.take(limit).toList();
    } catch (e) {
      print('Erreur lors de la recherche avancée: $e');
      return [];
    }
  }

  // Trier les résultats
  List<Guide> _sortResults(List<Guide> guides, String sortBy, bool ascending) {
    switch (sortBy) {
      case 'title':
        guides.sort((a, b) => ascending 
          ? a.title.compareTo(b.title)
          : b.title.compareTo(a.title));
        break;
      case 'difficulty':
        final difficultyOrder = {'Facile': 1, 'Moyen': 2, 'Difficile': 3};
        guides.sort((a, b) => ascending
          ? (difficultyOrder[a.difficulty] ?? 0).compareTo(difficultyOrder[b.difficulty] ?? 0)
          : (difficultyOrder[b.difficulty] ?? 0).compareTo(difficultyOrder[a.difficulty] ?? 0));
        break;
      case 'duration':
        guides.sort((a, b) => ascending
          ? a.estimatedDuration.compareTo(b.estimatedDuration)
          : b.estimatedDuration.compareTo(a.estimatedDuration));
        break;
      case 'updated':
        guides.sort((a, b) => ascending
          ? a.updatedAt.compareTo(b.updatedAt)
          : b.updatedAt.compareTo(a.updatedAt));
        break;
    }
    
    return guides;
  }
}
