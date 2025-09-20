import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/guide.dart';
import '../../core/services/advanced_search_service.dart';
import '../../core/services/analytics_service.dart';
import '../widgets/buttons/buttons.dart';
import '../../core/theme/app_text_styles.dart';

class AdvancedSearchPage extends ConsumerStatefulWidget {
  const AdvancedSearchPage({super.key});

  @override
  ConsumerState<AdvancedSearchPage> createState() => _AdvancedSearchPageState();
}

class _AdvancedSearchPageState extends ConsumerState<AdvancedSearchPage> {
  final AdvancedSearchService _searchService = AdvancedSearchService();
  final AnalyticsService _analytics = AnalyticsService();
  
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  
  List<Guide> _searchResults = [];
  List<String> _searchHistory = [];
  List<String> _suggestions = [];
  Map<String, List<String>> _availableFilters = {};
  
  String _selectedCategory = '';
  String _selectedDifficulty = '';
  String _selectedDuration = '';
  String _sortBy = 'relevance';
  bool _isAscending = true;
  
  bool _isLoading = false;
  bool _showFilters = false;
  bool _showSuggestions = false;

  @override
  void initState() {
    super.initState();
    _initializeSearch();
  }

  Future<void> _initializeSearch() async {
    await _searchService.initialize();
    _availableFilters = _searchService.getAvailableFilters();
    _searchHistory = await _searchService.getSearchHistory();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _performSearch() async {
    if (_searchController.text.trim().isEmpty) return;

    setState(() {
      _isLoading = true;
      _showSuggestions = false;
    });

    try {
      // Enregistrer la recherche dans l'historique
      await _searchService.saveSearchToHistory(_searchController.text.trim());
      
      // Effectuer la recherche
      final results = await _searchService.advancedSearch(
        query: _searchController.text.trim(),
        categories: _selectedCategory.isNotEmpty ? [_selectedCategory] : null,
        difficulties: _selectedDifficulty.isNotEmpty ? [_selectedDifficulty] : null,
        durations: _selectedDuration.isNotEmpty ? [_selectedDuration] : null,
        sortBy: _sortBy,
        ascending: _isAscending,
      );

      setState(() {
        _searchResults = results;
        _isLoading = false;
      });

      // Enregistrer l'événement de recherche
      _analytics.logSearch(_searchController.text.trim(), results.length);
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      _showErrorSnackBar('Erreur lors de la recherche: $e');
    }
  }

  Future<void> _getSuggestions() async {
    if (_searchController.text.length < 2) {
      setState(() {
        _suggestions = [];
        _showSuggestions = false;
      });
      return;
    }

    try {
      final suggestions = await _searchService.getSearchSuggestions(_searchController.text);
      setState(() {
        _suggestions = suggestions;
        _showSuggestions = suggestions.isNotEmpty;
      });
    } catch (e) {
      setState(() {
        _suggestions = [];
        _showSuggestions = false;
      });
    }
  }

  void _clearSearch() {
    _searchController.clear();
    setState(() {
      _searchResults = [];
      _suggestions = [];
      _showSuggestions = false;
    });
  }

  void _applyFilter(String filterType, String value) {
    setState(() {
      switch (filterType) {
        case 'category':
          _selectedCategory = _selectedCategory == value ? '' : value;
          break;
        case 'difficulty':
          _selectedDifficulty = _selectedDifficulty == value ? '' : value;
          break;
        case 'duration':
          _selectedDuration = _selectedDuration == value ? '' : value;
          break;
      }
    });
    _performSearch();
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recherche avancée'),
        actions: [
          AppIconButton(
            icon: _showFilters ? Icons.filter_list : Icons.filter_list_outlined,
            onPressed: () {
              setState(() {
                _showFilters = !_showFilters;
              });
            },
            tooltip: 'Filtres',
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Column(
        children: [
          // Barre de recherche
          _buildSearchBar(),
          
          // Filtres
          if (_showFilters) _buildFilters(),
          
          // Résultats
          Expanded(
            child: _buildResults(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Rechercher des guides...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: _clearSearch,
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onChanged: (value) {
              setState(() {});
              _getSuggestions();
            },
            onSubmitted: (value) => _performSearch(),
          ),
          
          // Suggestions
          if (_showSuggestions && _suggestions.isNotEmpty)
            Container(
              margin: const EdgeInsets.only(top: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: _suggestions.map((suggestion) => ListTile(
                  title: Text(suggestion),
                  onTap: () {
                    _searchController.text = suggestion;
                    setState(() {
                      _showSuggestions = false;
                    });
                    _performSearch();
                  },
                )).toList(),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.withOpacity(0.2),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Filtres',
            style: AppTextStyles.sectionTitle,
          ),
          const SizedBox(height: 16),
          
          // Filtres par catégorie
          _buildFilterSection(
            'Catégorie',
            _availableFilters['categories'] ?? [],
            _selectedCategory,
            (value) => _applyFilter('category', value),
          ),
          
          const SizedBox(height: 16),
          
          // Filtres par difficulté
          _buildFilterSection(
            'Difficulté',
            _availableFilters['difficulties'] ?? [],
            _selectedDifficulty,
            (value) => _applyFilter('difficulty', value),
          ),
          
          const SizedBox(height: 16),
          
          // Filtres par durée
          _buildFilterSection(
            'Durée',
            _availableFilters['durations'] ?? [],
            _selectedDuration,
            (value) => _applyFilter('duration', value),
          ),
          
          const SizedBox(height: 16),
          
          // Tri
          Row(
            children: [
              Text(
                'Trier par: ',
                style: AppTextStyles.bodyMedium,
              ),
              DropdownButton<String>(
                value: _sortBy,
                onChanged: (value) {
                  setState(() {
                    _sortBy = value!;
                  });
                  _performSearch();
                },
                items: const [
                  DropdownMenuItem(value: 'relevance', child: Text('Pertinence')),
                  DropdownMenuItem(value: 'title', child: Text('Titre')),
                  DropdownMenuItem(value: 'difficulty', child: Text('Difficulté')),
                  DropdownMenuItem(value: 'duration', child: Text('Durée')),
                  DropdownMenuItem(value: 'updated', child: Text('Mise à jour')),
                ],
              ),
              const SizedBox(width: 16),
              IconButton(
                icon: Icon(_isAscending ? Icons.arrow_upward : Icons.arrow_downward),
                onPressed: () {
                  setState(() {
                    _isAscending = !_isAscending;
                  });
                  _performSearch();
                },
                tooltip: _isAscending ? 'Croissant' : 'Décroissant',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection(String title, List<String> options, String selected, Function(String) onTap) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.bodyMedium.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: options.map((option) => FilterChip(
            label: Text(option),
            selected: selected == option,
            onSelected: (selected) => onTap(option),
          )).toList(),
        ),
      ],
    );
  }

  Widget _buildResults() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_searchResults.isEmpty && _searchController.text.isNotEmpty) {
      return _buildEmptyState();
    }

    if (_searchResults.isEmpty) {
      return _buildInitialState();
    }

    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(16),
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        final guide = _searchResults[index];
        return _buildGuideCard(guide);
      },
    );
  }

  Widget _buildInitialState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search,
            size: 64,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          Text(
            'Recherchez des guides',
            style: AppTextStyles.headline3,
          ),
          const SizedBox(height: 8),
          Text(
            'Utilisez la barre de recherche pour trouver des guides\nou explorez les filtres disponibles',
            style: AppTextStyles.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 64,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          Text(
            'Aucun résultat trouvé',
            style: AppTextStyles.headline3,
          ),
          const SizedBox(height: 8),
          Text(
            'Essayez avec d\'autres mots-clés ou modifiez vos filtres',
            style: AppTextStyles.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          AppButton(
            text: 'Effacer la recherche',
            type: AppButtonType.outline,
            onPressed: _clearSearch,
          ),
        ],
      ),
    );
  }

  Widget _buildGuideCard(Guide guide) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () {
          // TODO: Naviguer vers le guide
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      guide.category.displayName,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: _getDifficultyColor(guide.difficulty).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      guide.difficulty,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: _getDifficultyColor(guide.difficulty),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                guide.title,
                style: AppTextStyles.bodyLarge.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                guide.shortDescription,
                style: AppTextStyles.bodyMedium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(
                    Icons.schedule,
                    size: 16,
                    color: Colors.grey[600],
                  ),
                  const SizedBox(width: 4),
                  Text(
                    guide.estimatedDuration,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Icon(
                    Icons.list,
                    size: 16,
                    color: Colors.grey[600],
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${guide.steps.length} étapes',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty) {
      case 'Facile':
        return Colors.green;
      case 'Moyen':
        return Colors.orange;
      case 'Difficile':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
