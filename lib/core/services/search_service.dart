import '../../domain/entities/guide.dart';
import '../../domain/entities/tip.dart';
import '../../domain/entities/checklist_item.dart';
import '../../domain/entities/scanned_document.dart';
import '../../core/services/tips_and_tricks_service.dart';
import '../../core/services/checklist_service.dart';
import '../../core/services/document_scanner_service.dart';

class SearchResult {
  final String id;
  final String title;
  final String content;
  final String type; // 'guide', 'tip', 'checklist', 'document'
  final String? category;
  final DateTime? date;
  final bool isImportant;

  const SearchResult({
    required this.id,
    required this.title,
    required this.content,
    required this.type,
    this.category,
    this.date,
    this.isImportant = false,
  });
}

class SearchService {
  static SearchService? _instance;
  static SearchService get instance => _instance ??= SearchService._();
  SearchService._();

  final ChecklistService _checklistService = ChecklistService.instance;
  final DocumentScannerService _documentService = DocumentScannerService.instance;

  /// Effectue une recherche globale dans tous les contenus
  Future<List<SearchResult>> search(String query) async {
    if (query.isEmpty) return [];

    final List<SearchResult> results = [];
    final lowercaseQuery = query.toLowerCase();

    // Recherche dans les conseils
    final tipsByCategory = TipsAndTricksService.getTipsByCategory();
    for (final categoryTips in tipsByCategory.values) {
      for (final tip in categoryTips) {
        if (_matchesQuery(tip.title, lowercaseQuery) ||
            _matchesQuery(tip.description, lowercaseQuery) ||
            _matchesQuery(tip.category.toString(), lowercaseQuery)) {
          results.add(SearchResult(
            id: tip.id,
            title: tip.title,
            content: tip.description,
            type: 'tip',
            category: tip.category.toString(),
            date: tip.updatedAt,
            isImportant: tip.isImportant,
          ));
        }
      }
    }

    // Recherche dans la checklist
    final checklistItems = _checklistService.checklistItems;
    for (final item in checklistItems) {
      if (_matchesQuery(item.title, lowercaseQuery) ||
          _matchesQuery(item.description, lowercaseQuery)) {
        results.add(SearchResult(
          id: item.id,
          title: item.title,
          content: item.description,
          type: 'checklist',
          category: item.category,
          date: item.dueDate,
          isImportant: item.priority == ChecklistPriority.high,
        ));
      }
    }

    // Recherche dans les documents scannés
    final documents = _documentService.scannedDocuments;
    for (final document in documents) {
      if (_matchesQuery(document.name, lowercaseQuery) ||
          _matchesQuery(document.typeDisplayName, lowercaseQuery) ||
          _matchesQuery(document.notes ?? '', lowercaseQuery)) {
        results.add(SearchResult(
          id: document.id,
          title: document.name,
          content: document.notes ?? document.typeDisplayName,
          type: 'document',
          category: document.typeDisplayName,
          date: document.scannedAt,
          isImportant: document.isImportant,
        ));
      }
    }

    // Trier par importance et pertinence
    results.sort((a, b) {
      if (a.isImportant && !b.isImportant) return -1;
      if (!a.isImportant && b.isImportant) return 1;
      return 0;
    });

    return results;
  }

  /// Recherche dans une catégorie spécifique
  Future<List<SearchResult>> searchInCategory(String query, String category) async {
    final allResults = await search(query);
    return allResults.where((result) => 
      result.category?.toLowerCase().contains(category.toLowerCase()) ?? false
    ).toList();
  }

  /// Recherche par type de contenu
  Future<List<SearchResult>> searchByType(String query, String type) async {
    final allResults = await search(query);
    return allResults.where((result) => result.type == type).toList();
  }

  /// Recherche des suggestions
  Future<List<String>> getSuggestions(String partialQuery) async {
    if (partialQuery.length < 2) return [];

    final suggestions = <String>{};
    final lowercaseQuery = partialQuery.toLowerCase();

    // Suggestions basées sur les conseils
    final tipsByCategory = TipsAndTricksService.getTipsByCategory();
    for (final categoryTips in tipsByCategory.values) {
      for (final tip in categoryTips) {
        if (tip.title.toLowerCase().contains(lowercaseQuery)) {
          suggestions.add(tip.title);
        }
        if (tip.category.toString().toLowerCase().contains(lowercaseQuery)) {
          suggestions.add(tip.category.toString());
        }
      }
    }

    // Suggestions basées sur la checklist
    final checklistItems = _checklistService.checklistItems;
    for (final item in checklistItems) {
      if (item.title.toLowerCase().contains(lowercaseQuery)) {
        suggestions.add(item.title);
      }
      if (item.category?.toLowerCase().contains(lowercaseQuery) ?? false) {
        suggestions.add(item.category!);
      }
    }

    return suggestions.take(10).toList();
  }

  /// Recherche avancée avec filtres
  Future<List<SearchResult>> advancedSearch({
    required String query,
    List<String>? types,
    List<String>? categories,
    bool? isImportant,
    DateTime? dateFrom,
    DateTime? dateTo,
  }) async {
    var results = await search(query);

    // Filtrer par types
    if (types != null && types.isNotEmpty) {
      results = results.where((result) => types.contains(result.type)).toList();
    }

    // Filtrer par catégories
    if (categories != null && categories.isNotEmpty) {
      results = results.where((result) => 
        result.category != null && 
        categories.any((cat) => result.category!.toLowerCase().contains(cat.toLowerCase()))
      ).toList();
    }

    // Filtrer par importance
    if (isImportant != null) {
      results = results.where((result) => result.isImportant == isImportant).toList();
    }

    // Filtrer par date
    if (dateFrom != null) {
      results = results.where((result) => 
        result.date != null && result.date!.isAfter(dateFrom)
      ).toList();
    }

    if (dateTo != null) {
      results = results.where((result) => 
        result.date != null && result.date!.isBefore(dateTo)
      ).toList();
    }

    return results;
  }

  /// Obtient les recherches populaires
  List<String> getPopularSearches() {
    return [
      'inscription université',
      'logement étudiant',
      'visa étudiant',
      'mutuelle santé',
      'transport',
      'banque',
      'CAF',
      'bourse',
      'stage',
      'emploi',
    ];
  }

  /// Obtient les catégories de recherche
  List<String> getSearchCategories() {
    return [
      'Administratif',
      'Logement',
      'Santé',
      'Transport',
      'Éducation',
      'Emploi',
      'Vie pratique',
      'Urgences',
    ];
  }

  /// Vérifie si une chaîne correspond à la requête
  bool _matchesQuery(String text, String query) {
    return text.toLowerCase().contains(query);
  }

  /// Obtient les statistiques de recherche
  Map<String, dynamic> getSearchStatistics() {
    final tipsByCategory = TipsAndTricksService.getTipsByCategory();
    final totalTips = tipsByCategory.values.fold(0, (sum, tips) => sum + tips.length);
    final checklistItems = _checklistService.checklistItems;
    final documents = _documentService.scannedDocuments;

    return {
      'totalTips': totalTips,
      'totalChecklistItems': checklistItems.length,
      'totalDocuments': documents.length,
      'totalSearchableContent': totalTips + checklistItems.length + documents.length,
    };
  }
}
