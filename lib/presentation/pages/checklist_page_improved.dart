import 'package:flutter/material.dart';
import '../../domain/entities/checklist_item.dart';
import '../../core/services/checklist_service.dart';

class ChecklistPage extends StatefulWidget {
  const ChecklistPage({super.key});

  @override
  State<ChecklistPage> createState() => _ChecklistPageState();
}

class _ChecklistPageState extends State<ChecklistPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ChecklistService _checklistService = ChecklistService.instance;
  
  List<ChecklistItem> _checklistItems = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _initializeData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _initializeData() async {
    await _checklistService.loadChecklist();
    
    setState(() {
      _checklistItems = _checklistService.checklistItems;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ma Checklist'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Toutes', icon: Icon(Icons.list)),
            Tab(text: 'En cours', icon: Icon(Icons.schedule)),
            Tab(text: 'Terminées', icon: Icon(Icons.check_circle)),
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
                _buildChecklistItems(_getItemsByStatus(ChecklistStatus.inProgress)),
                _buildChecklistItems(_getItemsByStatus(ChecklistStatus.completed)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressCard() {
    final total = _checklistItems.length;
    final completed = _checklistItems.where((item) => item.status == ChecklistStatus.completed).length;
    final progress = total > 0 ? completed / total : 0.0;

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.1),
            Theme.of(context).colorScheme.primary.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Progression',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              Text(
                '${(progress * 100).toInt()}%',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(
              Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem('Total', '$total', Icons.list, Colors.blue),
              _buildStatItem('Terminées', '$completed', Icons.check_circle, Colors.green),
              _buildStatItem('Restantes', '${total - completed}', Icons.schedule, Colors.orange),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon, Color color) {
    return Column(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildChecklistItems(List<ChecklistItem> items) {
    if (items.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.checklist,
              size: 80,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'Aucun élément trouvé',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return _buildChecklistItemCard(item);
      },
    );
  }

  Widget _buildChecklistItemCard(ChecklistItem item) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () => _showItemDetails(item),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              _buildStatusIndicator(item.status),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            item.title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        if (item.priority == ChecklistPriority.urgent)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.red.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text(
                              'URGENT',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item.description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.schedule,
                          size: 16,
                          color: Colors.grey[500],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${item.estimatedDurationDays} jours',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[500],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Icon(
                          Icons.category,
                          size: 16,
                          color: Colors.grey[500],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          item.category ?? 'Général',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => _toggleItemStatus(item),
                icon: Icon(
                  item.status == ChecklistStatus.completed
                      ? Icons.check_circle
                      : Icons.radio_button_unchecked,
                  color: item.status == ChecklistStatus.completed
                      ? Colors.green
                      : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusIndicator(ChecklistStatus status) {
    Color color;
    IconData icon;
    
    switch (status) {
      case ChecklistStatus.completed:
        color = Colors.green;
        icon = Icons.check_circle;
        break;
      case ChecklistStatus.inProgress:
        color = Colors.orange;
        icon = Icons.schedule;
        break;
      case ChecklistStatus.pending:
        color = Colors.grey;
        icon = Icons.radio_button_unchecked;
        break;
      case ChecklistStatus.notStarted:
        color = Colors.grey;
        icon = Icons.radio_button_unchecked;
        break;
      case ChecklistStatus.cancelled:
        color = Colors.red;
        icon = Icons.cancel;
        break;
    }

    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        shape: BoxShape.circle,
        border: Border.all(color: color, width: 2),
      ),
      child: Icon(icon, color: color, size: 16),
    );
  }

  List<ChecklistItem> _getItemsByStatus(ChecklistStatus status) {
    return _checklistItems.where((item) => item.status == status).toList();
  }

  void _toggleItemStatus(ChecklistItem item) {
    setState(() {
      final index = _checklistItems.indexWhere((i) => i.id == item.id);
      if (index != -1) {
        final newStatus = item.status == ChecklistStatus.completed
            ? ChecklistStatus.pending
            : ChecklistStatus.completed;
        
        _checklistItems[index] = item.copyWith(status: newStatus);
        _checklistService.updateItem(_checklistItems[index]);
      }
    });
  }

  void _showItemDetails(ChecklistItem item) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(item.title),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                item.description,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              if (item.requiredDocuments.isNotEmpty) ...[
                const Text(
                  'Documents requis:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                ...item.requiredDocuments.map((doc) => Padding(
                  padding: const EdgeInsets.only(left: 16, bottom: 4),
                  child: Row(
                    children: [
                      const Icon(Icons.check, size: 16, color: Colors.green),
                      const SizedBox(width: 8),
                      Expanded(child: Text(doc)),
                    ],
                  ),
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
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            '${entry.key + 1}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(child: Text(entry.value)),
                    ],
                  ),
                )),
              ],
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Fermer'),
          ),
          ElevatedButton(
            onPressed: () {
              _toggleItemStatus(item);
              Navigator.pop(context);
            },
            child: Text(
              item.status == ChecklistStatus.completed ? 'Marquer en attente' : 'Marquer terminé',
            ),
          ),
        ],
      ),
    );
  }
}
