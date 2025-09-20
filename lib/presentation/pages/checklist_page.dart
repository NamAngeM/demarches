import 'package:flutter/material.dart';
import '../../domain/entities/checklist_item.dart';
import '../../core/services/checklist_service.dart';
import '../../core/services/location_service.dart';

class ChecklistPage extends StatefulWidget {
  const ChecklistPage({super.key});

  @override
  State<ChecklistPage> createState() => _ChecklistPageState();
}

class _ChecklistPageState extends State<ChecklistPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ChecklistService _checklistService = ChecklistService.instance;
  final LocationService _locationService = LocationService.instance;
  
  List<ChecklistItem> _checklistItems = [];
  bool _isLoading = true;
  String? _currentCity;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _initializeData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _initializeData() async {
    await _checklistService.loadChecklist();
    // Temporairement désactivé pour éviter les erreurs de compilation
    // await _locationService.getCurrentPosition();
    // await _checklistService.updateLocalInfo();
    
    setState(() {
      _checklistItems = _checklistService.checklistItems;
      _currentCity = 'France'; // Valeur par défaut
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ma Checklist'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Tous', icon: Icon(Icons.list)),
            Tab(text: 'En cours', icon: Icon(Icons.play_arrow)),
            Tab(text: 'Urgents', icon: Icon(Icons.priority_high)),
            Tab(text: 'Terminés', icon: Icon(Icons.check_circle)),
          ],
        ),
      ),
      body: Column(
        children: [
          _buildProgressCard(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildChecklistItems(_checklistItems),
                _buildChecklistItems(_checklistService.getItemsByStatus(ChecklistStatus.inProgress)),
                _buildChecklistItems(_checklistService.getUrgentItems()),
                _buildChecklistItems(_checklistService.getItemsByStatus(ChecklistStatus.completed)),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddItemDialog,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildProgressCard() {
    final stats = _checklistService.getStatistics();
    final progress = _checklistService.getProgressPercentage();
    
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Progression',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                if (_currentCity != null)
                  Chip(
                    label: Text('📍 $_currentCity'),
                    backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                  ),
              ],
            ),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: progress / 100,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(
                progress == 100 ? Colors.green : Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${progress.toStringAsFixed(0)}% complété (${stats['completed']}/${stats['total']})',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatChip('En cours', stats['inProgress']!, Colors.orange),
                _buildStatChip('Urgents', stats['overdue']!, Colors.red),
                _buildStatChip('Bientôt', stats['dueSoon']!, Colors.amber),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatChip(String label, int count, Color color) {
    return Chip(
      label: Text('$label: $count'),
      backgroundColor: color.withOpacity(0.1),
      labelStyle: TextStyle(color: color),
    );
  }

  Widget _buildChecklistItems(List<ChecklistItem> items) {
    if (items.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle_outline, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'Aucun élément dans cette catégorie',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return _buildChecklistItemCard(items[index]);
      },
    );
  }

  Widget _buildChecklistItemCard(ChecklistItem item) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ExpansionTile(
        leading: _buildStatusIcon(item),
        title: Text(
          item.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            decoration: item.status == ChecklistStatus.completed 
                ? TextDecoration.lineThrough 
                : null,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(item.description),
            const SizedBox(height: 4),
            Row(
              children: [
                _buildPriorityChip(item.priority),
                const SizedBox(width: 8),
                if (item.category != null)
                  Chip(
                    label: Text(item.category!),
                    backgroundColor: Colors.blue.withOpacity(0.1),
                    labelStyle: const TextStyle(fontSize: 12),
                  ),
                if (item.isOverdue)
                  const Chip(
                    label: Text('EN RETARD'),
                    backgroundColor: Colors.red,
                    labelStyle: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                if (item.isDueSoon)
                  const Chip(
                    label: Text('BIENTÔT'),
                    backgroundColor: Colors.amber,
                    labelStyle: TextStyle(fontSize: 12),
                  ),
              ],
            ),
          ],
        ),
        trailing: PopupMenuButton<ChecklistStatus>(
          onSelected: (status) => _updateItemStatus(item.id, status),
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: ChecklistStatus.notStarted,
              child: Text('Non commencé'),
            ),
            const PopupMenuItem(
              value: ChecklistStatus.inProgress,
              child: Text('En cours'),
            ),
            const PopupMenuItem(
              value: ChecklistStatus.completed,
              child: Text('Terminé'),
            ),
            const PopupMenuItem(
              value: ChecklistStatus.pending,
              child: Text('En attente'),
            ),
            const PopupMenuItem(
              value: ChecklistStatus.cancelled,
              child: Text('Annulé'),
            ),
          ],
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (item.requiredDocuments.isNotEmpty) ...[
                  const Text(
                    'Documents requis:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  ...item.requiredDocuments.map((doc) => Padding(
                    padding: const EdgeInsets.only(left: 16, bottom: 4),
                    child: Text('• $doc'),
                  )),
                  const SizedBox(height: 16),
                ],
                if (item.steps.isNotEmpty) ...[
                  const Text(
                    'Étapes:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  ...item.steps.asMap().entries.map((entry) => Padding(
                    padding: const EdgeInsets.only(left: 16, bottom: 4),
                    child: Text('${entry.key + 1}. ${entry.value}'),
                  )),
                  const SizedBox(height: 16),
                ],
                if (item.localInfo != null) ...[
                  const Text(
                    'Informations locales:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  _buildLocalInfo(item.localInfo!),
                ],
                if (item.contactInfo != null || item.website != null) ...[
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      if (item.contactInfo != null)
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () => _launchUrl('tel:${item.contactInfo}'),
                            icon: const Icon(Icons.phone),
                            label: const Text('Appeler'),
                          ),
                        ),
                      if (item.contactInfo != null && item.website != null)
                        const SizedBox(width: 8),
                      if (item.website != null)
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () => _launchUrl(item.website!),
                            icon: const Icon(Icons.open_in_browser),
                            label: const Text('Site web'),
                          ),
                        ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusIcon(ChecklistItem item) {
    switch (item.status) {
      case ChecklistStatus.notStarted:
        return const Icon(Icons.radio_button_unchecked, color: Colors.grey);
      case ChecklistStatus.inProgress:
        return const Icon(Icons.play_circle, color: Colors.orange);
      case ChecklistStatus.completed:
        return const Icon(Icons.check_circle, color: Colors.green);
      case ChecklistStatus.pending:
        return const Icon(Icons.schedule, color: Colors.blue);
      case ChecklistStatus.cancelled:
        return const Icon(Icons.cancel, color: Colors.red);
    }
  }

  Widget _buildPriorityChip(ChecklistPriority priority) {
    Color color;
    switch (priority) {
      case ChecklistPriority.low:
        color = Colors.green;
        break;
      case ChecklistPriority.medium:
        color = Colors.blue;
        break;
      case ChecklistPriority.high:
        color = Colors.orange;
        break;
      case ChecklistPriority.urgent:
        color = Colors.red;
        break;
    }

    return Chip(
      label: Text(
        _getPriorityDisplayName(priority),
        style: const TextStyle(fontSize: 12),
      ),
      backgroundColor: color.withOpacity(0.1),
      labelStyle: TextStyle(color: color),
    );
  }

  Widget _buildLocalInfo(Map<String, dynamic> localInfo) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: localInfo.entries.map((entry) {
        if (entry.value is Map) {
          return Padding(
            padding: const EdgeInsets.only(left: 16, bottom: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.key,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                ...(entry.value as Map).entries.map((subEntry) => Padding(
                  padding: const EdgeInsets.only(left: 16, bottom: 2),
                  child: Text('${subEntry.key}: ${subEntry.value}'),
                )),
              ],
            ),
          );
        } else if (entry.value is List) {
          return Padding(
            padding: const EdgeInsets.only(left: 16, bottom: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.key,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                ...(entry.value as List).map((item) => Padding(
                  padding: const EdgeInsets.only(left: 16, bottom: 2),
                  child: Text('• $item'),
                )),
              ],
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.only(left: 16, bottom: 4),
            child: Text('${entry.key}: ${entry.value}'),
          );
        }
      }).toList(),
    );
  }

  Future<void> _updateItemStatus(String itemId, ChecklistStatus newStatus) async {
    await _checklistService.updateItemStatus(itemId, newStatus);
    setState(() {
      _checklistItems = _checklistService.checklistItems;
    });
  }

  String _getPriorityDisplayName(ChecklistPriority priority) {
    switch (priority) {
      case ChecklistPriority.low:
        return 'Faible';
      case ChecklistPriority.medium:
        return 'Moyen';
      case ChecklistPriority.high:
        return 'Élevé';
      case ChecklistPriority.urgent:
        return 'Urgent';
    }
  }

  Future<void> _launchUrl(String url) async {
    // Implémentation de l'ouverture d'URL
    // Utiliser url_launcher package
  }

  void _showAddItemDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Ajouter un élément'),
        content: const Text('Cette fonctionnalité sera disponible prochainement.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
