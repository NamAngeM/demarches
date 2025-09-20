import 'package:flutter/material.dart';
import '../../core/services/search_service.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final SearchService _searchService = SearchService.instance;
  final TextEditingController _searchController = TextEditingController();
  
  List<SearchResult> _searchResults = [];
  List<String> _suggestions = [];
  bool _isSearching = false;
  String _currentQuery = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text;
    if (query.length >= 2) {
      _getSuggestions(query);
    } else {
      setState(() {
        _suggestions = [];
      });
    }
  }

  Future<void> _getSuggestions(String query) async {
    final suggestions = await _searchService.getSuggestions(query);
    setState(() {
      _suggestions = suggestions;
    });
  }

  Future<void> _performSearch(String query) async {
    if (query.isEmpty) return;

    setState(() {
      _isSearching = true;
      _currentQuery = query;
    });

    try {
      final results = await _searchService.search(query);
      setState(() {
        _searchResults = results;
        _isSearching = false;
      });
    } catch (e) {
      setState(() {
        _isSearching = false;
      });
      _showErrorSnackBar('Erreur lors de la recherche: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recherche'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Recherche', icon: Icon(Icons.search)),
            Tab(text: 'Filtres', icon: Icon(Icons.filter_list)),
          ],
        ),
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildSearchResults(),
                _buildAdvancedSearch(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Rechercher dans l\'application...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _searchController.clear();
                        setState(() {
                          _searchResults = [];
                          _suggestions = [];
                        });
                      },
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onSubmitted: _performSearch,
          ),
          if (_suggestions.isNotEmpty) _buildSuggestions(),
        ],
      ),
    );
  }

  Widget _buildSuggestions() {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        children: _suggestions.map((suggestion) {
          return ListTile(
            leading: const Icon(Icons.search, size: 20),
            title: Text(suggestion),
            onTap: () {
              _searchController.text = suggestion;
              _performSearch(suggestion);
            },
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSearchResults() {
    if (_isSearching) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_searchResults.isEmpty && _currentQuery.isNotEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 80,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'Aucun résultat trouvé',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Essayez avec d\'autres mots-clés',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      );
    }

    if (_searchResults.isEmpty) {
      return _buildEmptyState();
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        final result = _searchResults[index];
        return _buildSearchResultCard(result);
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'Recherchez dans l\'application',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tapez un mot-clé pour commencer',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
          const SizedBox(height: 24),
          _buildPopularSearches(),
        ],
      ),
    );
  }

  Widget _buildPopularSearches() {
    final popularSearches = _searchService.getPopularSearches();
    
    return Column(
      children: [
        const Text(
          'Recherches populaires',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: popularSearches.map((search) {
            return ActionChip(
              label: Text(search),
              onPressed: () {
                _searchController.text = search;
                _performSearch(search);
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSearchResultCard(SearchResult result) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _getTypeColor(result.type).withOpacity(0.1),
          child: Icon(
            _getTypeIcon(result.type),
            color: _getTypeColor(result.type),
          ),
        ),
        title: Text(
          result.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              result.content,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Chip(
                  label: Text(
                    _getTypeDisplayName(result.type),
                    style: const TextStyle(fontSize: 12),
                  ),
                  backgroundColor: _getTypeColor(result.type).withOpacity(0.1),
                ),
                if (result.category != null) ...[
                  const SizedBox(width: 4),
                  Chip(
                    label: Text(
                      result.category!,
                      style: const TextStyle(fontSize: 12),
                    ),
                    backgroundColor: Colors.grey.withOpacity(0.1),
                  ),
                ],
                if (result.isImportant) ...[
                  const SizedBox(width: 4),
                  const Icon(Icons.star, color: Colors.orange, size: 16),
                ],
              ],
            ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.open_in_new),
          onPressed: () => _openResult(result),
        ),
      ),
    );
  }

  Widget _buildAdvancedSearch() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Recherche Avancée',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          _buildFilterSection('Type de contenu', _buildTypeFilters()),
          const SizedBox(height: 24),
          _buildFilterSection('Catégorie', _buildCategoryFilters()),
          const SizedBox(height: 24),
          _buildFilterSection('Importance', _buildImportanceFilter()),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _performAdvancedSearch,
              child: const Text('Rechercher'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection(String title, Widget content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        content,
      ],
    );
  }

  Widget _buildTypeFilters() {
    final types = ['guide', 'tip', 'checklist', 'document'];
    return Wrap(
      spacing: 8,
      children: types.map((type) {
        return FilterChip(
          label: Text(_getTypeDisplayName(type)),
          selected: false, // TODO: Gérer la sélection
          onSelected: (selected) {
            // TODO: Implémenter la logique de sélection
          },
        );
      }).toList(),
    );
  }

  Widget _buildCategoryFilters() {
    final categories = _searchService.getSearchCategories();
    return Wrap(
      spacing: 8,
      children: categories.map((category) {
        return FilterChip(
          label: Text(category),
          selected: false, // TODO: Gérer la sélection
          onSelected: (selected) {
            // TODO: Implémenter la logique de sélection
          },
        );
      }).toList(),
    );
  }

  Widget _buildImportanceFilter() {
    return Row(
      children: [
        Checkbox(
          value: false, // TODO: Gérer l'état
          onChanged: (value) {
            // TODO: Implémenter la logique
          },
        ),
        const Text('Documents importants uniquement'),
      ],
    );
  }

  void _openResult(SearchResult result) {
    // TODO: Implémenter la navigation vers le contenu spécifique
    _showInfoSnackBar('Ouverture de: ${result.title}');
  }

  Future<void> _performAdvancedSearch() async {
    // TODO: Implémenter la recherche avancée
    _showInfoSnackBar('Recherche avancée à implémenter');
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  void _showInfoSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case 'guide':
        return Colors.blue;
      case 'tip':
        return Colors.green;
      case 'checklist':
        return Colors.orange;
      case 'document':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  IconData _getTypeIcon(String type) {
    switch (type) {
      case 'guide':
        return Icons.menu_book;
      case 'tip':
        return Icons.lightbulb;
      case 'checklist':
        return Icons.checklist;
      case 'document':
        return Icons.description;
      default:
        return Icons.help;
    }
  }

  String _getTypeDisplayName(String type) {
    switch (type) {
      case 'guide':
        return 'Guide';
      case 'tip':
        return 'Conseil';
      case 'checklist':
        return 'Checklist';
      case 'document':
        return 'Document';
      default:
        return 'Autre';
    }
  }
}
