import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/guide.dart';
import '../../data/services/firestore_guide_service.dart';
import '../../core/services/sync_service.dart';
import '../../core/services/analytics_service.dart';
import '../../core/services/advanced_search_service.dart';
import '../../core/services/guide_generation_service.dart';
import '../widgets/buttons/buttons.dart';
import '../widgets/network_status_indicator.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/services/user_preferences_service.dart';
import '../../core/providers/auth_provider.dart';
import 'guide_detail_page.dart';
import 'widget_showcase_page.dart';
import 'profile_page.dart';
import 'advanced_search_page.dart';
import 'comprehensive_guides_page.dart';
import 'quality_dashboard_page.dart';

class GuidesHomePage extends ConsumerStatefulWidget {
  const GuidesHomePage({super.key});

  @override
  ConsumerState<GuidesHomePage> createState() => _GuidesHomePageState();
}

class _GuidesHomePageState extends ConsumerState<GuidesHomePage> {
  final TextEditingController _searchController = TextEditingController();
  final FirestoreGuideService _guideService = FirestoreGuideService();
  final SyncService _syncService = SyncService();
  final AnalyticsService _analytics = AnalyticsService();
  final AdvancedSearchService _searchService = AdvancedSearchService();
  final GuideGenerationService _generationService = GuideGenerationService();
  
  List<Guide> _filteredGuides = [];
  GuideCategory? _selectedCategory;
  bool _isSearching = false;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _initializeServices();
    _loadGuides();
    _loadUserPreferences();
  }

  Future<void> _initializeServices() async {
    await _searchService.initialize();
  }

  Future<void> _loadGuides() async {
    try {
      setState(() {
        _isLoading = true;
        _error = null;
      });

      final guides = await _guideService.getAllGuides();
      
      if (mounted) {
        setState(() {
          _filteredGuides = guides;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _loadUserPreferences() async {
    // Charger les préférences utilisateur et personnaliser l'interface
    final profile = await UserPreferencesService.loadUserProfile();
    if (profile != null && mounted) {
      setState(() {
        // Personnaliser l'interface selon le profil
      });
    }
  }

  void _performSearch(String query) async {
    setState(() {
      _isSearching = query.isNotEmpty;
    });

    if (query.isEmpty) {
      await _loadGuides();
    } else {
      try {
        final searchResults = await _searchService.searchLocally(query);
        if (mounted) {
          setState(() {
            _filteredGuides = searchResults;
          });
        }
        
        // Enregistrer l'événement de recherche
        _analytics.logSearch(query, searchResults.length);
      } catch (e) {
        if (mounted) {
          setState(() {
            _error = e.toString();
          });
        }
      }
    }
  }

  void _filterByCategory(GuideCategory? category) async {
    setState(() {
      _selectedCategory = category;
    });

    try {
      final guides = category != null
          ? await _guideService.getGuidesByCategory(category.name)
          : await _guideService.getAllGuides();
      
      if (mounted) {
        setState(() {
          _filteredGuides = guides;
        });
      }
      
      // Enregistrer l'événement de filtre
      if (category != null) {
        _analytics.logSearchFilter('category', category.name);
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Guides Étudiants'),
        actions: [
          AppIconButton(
            icon: Icons.analytics,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const QualityDashboardPage(),
                ),
              );
            },
            tooltip: 'Dashboard Qualité',
          ),
          const SizedBox(width: 8),
          AppIconButton(
            icon: Icons.book,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ComprehensiveGuidesPage(),
                ),
              );
            },
            tooltip: 'Guide complet',
          ),
          const SizedBox(width: 8),
          AppIconButton(
            icon: Icons.search,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AdvancedSearchPage(),
                ),
              );
            },
            tooltip: 'Recherche avancée',
          ),
          const SizedBox(width: 8),
          AppIconButton(
            icon: Icons.palette_outlined,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const WidgetShowcasePage(),
                ),
              );
            },
            tooltip: 'Galerie des widgets',
          ),
          const SizedBox(width: 8),
          AppIconButton(
            icon: Icons.favorite_outline,
            onPressed: () {
              // TODO: Implémenter les favoris
            },
            tooltip: 'Favoris',
          ),
          const SizedBox(width: 8),
          AppIconButton(
            icon: Icons.person_outline,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ProfilePage(),
                ),
              );
            },
            tooltip: 'Profil',
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Column(
        children: [
          // Indicateurs de statut
          const StatusIndicators(),
          
          // Barre de recherche
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              onChanged: _performSearch,
              decoration: InputDecoration(
                hintText: 'Rechercher un guide...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          _performSearch('');
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          
          // Filtres par catégorie
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: GuideCategory.values.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      label: const Text('Tous'),
                      selected: _selectedCategory == null,
                      onSelected: (selected) => _filterByCategory(null),
                    ),
                  );
                }
                
                final category = GuideCategory.values[index - 1];
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(category.displayName),
                    selected: _selectedCategory == category,
                    onSelected: (selected) => _filterByCategory(selected ? category : null),
                    avatar: Text(category.icon),
                  ),
                );
              },
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Résultats
          Expanded(
            child: _buildContent(),
          ),
        ],
      ),
      floatingActionButton: AppFab(
        onPressed: () {
          // TODO: Implémenter l'ajout d'un guide personnalisé
        },
        label: 'Nouveau guide',
        icon: Icons.add,
      ),
    );
  }

  Widget _buildContent() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red.withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            Text(
              'Erreur de chargement',
              style: AppTextStyles.headline3,
            ),
            const SizedBox(height: 8),
            Text(
              _error!,
              style: AppTextStyles.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            AppButton(
              text: 'Réessayer',
              icon: Icons.refresh,
              onPressed: _loadGuides,
            ),
          ],
        ),
      );
    }

    if (_filteredGuides.isEmpty) {
      return _buildEmptyState();
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: _filteredGuides.length,
      itemBuilder: (context, index) {
        final guide = _filteredGuides[index];
        return _buildGuideCard(guide);
      },
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
            _isSearching ? 'Aucun guide trouvé' : 'Aucun guide disponible',
            style: AppTextStyles.headline3,
          ),
          const SizedBox(height: 8),
          Text(
            _isSearching
                ? 'Essayez avec d\'autres mots-clés'
                : 'Les guides apparaîtront ici',
            style: AppTextStyles.bodyMedium,
            textAlign: TextAlign.center,
          ),
          if (_isSearching) ...[
            const SizedBox(height: 16),
            AppButton(
              text: 'Effacer la recherche',
              type: AppButtonType.outline,
              onPressed: () {
                _searchController.clear();
                _performSearch('');
              },
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildGuideCard(Guide guide) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () async {
          // Enregistrer l'événement de consultation
          _analytics.logGuideViewed(guide.id, guide.title, guide.category.name);
          
          // Sauvegarder le guide consulté
          await UserPreferencesService.addViewedGuide(guide.id);
          
          // Synchroniser avec Firestore
          _syncService.syncViewedGuide('current_user_id', guide.id);
          
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => GuideDetailPage(guide: guide),
            ),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    guide.categoryIcon,
                    style: const TextStyle(fontSize: 24),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          guide.title,
                          style: AppTextStyles.cardTitle,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          guide.categoryDisplayName,
                          style: AppTextStyles.bodySmall.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (guide.isFavorite)
                    const Icon(
                      Icons.favorite,
                      color: Colors.red,
                      size: 20,
                    ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                guide.shortDescription,
                style: AppTextStyles.bodyMedium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  _buildInfoChip(
                    icon: Icons.schedule,
                    label: guide.estimatedDuration,
                    color: Colors.blue,
                  ),
                  const SizedBox(width: 8),
                  _buildInfoChip(
                    icon: Icons.trending_up,
                    label: guide.difficulty,
                    color: _getDifficultyColor(guide.difficulty),
                  ),
                  const SizedBox(width: 8),
                  _buildInfoChip(
                    icon: Icons.list,
                    label: '${guide.steps.length} étapes',
                    color: Colors.green,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 4,
                runSpacing: 4,
                children: guide.tags.take(3).map((tag) {
                  return Chip(
                    label: Text(
                      tag,
                      style: AppTextStyles.bodySmall,
                    ),
                    backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    labelStyle: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 10,
                    ),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoChip({
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: AppTextStyles.bodySmall.copyWith(color: color),
          ),
        ],
      ),
    );
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'facile':
        return Colors.green;
      case 'moyen':
        return Colors.orange;
      case 'difficile':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
