import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import '../../domain/entities/scanned_document.dart';
import '../../core/services/document_scanner_service.dart';

class DocumentScannerPage extends StatefulWidget {
  const DocumentScannerPage({super.key});

  @override
  State<DocumentScannerPage> createState() => _DocumentScannerPageState();
}

class _DocumentScannerPageState extends State<DocumentScannerPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final DocumentScannerService _scannerService = DocumentScannerService.instance;
  
  List<ScannedDocument> _documents = [];
  bool _isLoading = true;
  String _searchQuery = '';

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
    await _scannerService.loadDocuments();
    setState(() {
      _documents = _scannerService.scannedDocuments;
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
        title: const Text('Scanner de Documents'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Mes Documents', icon: Icon(Icons.folder)),
            Tab(text: 'Scanner', icon: Icon(Icons.camera_alt)),
            Tab(text: 'Recherche', icon: Icon(Icons.search)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildDocumentsTab(),
          _buildScannerTab(),
          _buildSearchTab(),
        ],
      ),
    );
  }

  Widget _buildDocumentsTab() {
    return Column(
      children: [
        _buildStatisticsCard(),
        Expanded(
          child: _documents.isEmpty
              ? _buildEmptyState()
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _documents.length,
                  itemBuilder: (context, index) {
                    final document = _documents[index];
                    return _buildDocumentCard(document);
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildStatisticsCard() {
    final stats = _scannerService.getDocumentStatistics();
    
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Statistiques',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildStatItem(
                    'Total',
                    '${stats['total']}',
                    Icons.folder,
                    Colors.blue,
                  ),
                ),
                Expanded(
                  child: _buildStatItem(
                    'Importants',
                    '${stats['important']}',
                    Icons.star,
                    Colors.orange,
                  ),
                ),
                Expanded(
                  child: _buildStatItem(
                    'Récents',
                    '${stats['recentCount']}',
                    Icons.schedule,
                    Colors.green,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: color,
            ),
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
            Icons.document_scanner,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'Aucun document scanné',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Utilisez l\'onglet Scanner pour numériser vos documents',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentCard(ScannedDocument document) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _getDocumentTypeColor(document.type).withOpacity(0.1),
          child: Text(
            document.typeIcon,
            style: const TextStyle(fontSize: 24),
          ),
        ),
        title: Text(
          document.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(document.typeDisplayName),
            if (document.notes != null)
              Text(
                document.notes!,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            Text(
              'Scanné le ${_formatDate(document.scannedAt)}',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (document.isImportant)
              const Icon(Icons.star, color: Colors.orange),
            PopupMenuButton<String>(
              onSelected: (value) => _handleDocumentAction(value, document),
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'edit',
                  child: Row(
                    children: [
                      Icon(Icons.edit),
                      SizedBox(width: 8),
                      Text('Modifier'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'delete',
                  child: Row(
                    children: [
                      Icon(Icons.delete, color: Colors.red),
                      SizedBox(width: 8),
                      Text('Supprimer'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScannerTab() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text(
            'Scanner un Document',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 32),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildScanOption(
                  'Appareil Photo',
                  'Prendre une photo du document',
                  Icons.camera_alt,
                  Colors.blue,
                  () => _scanFromCamera(),
                ),
                const SizedBox(height: 24),
                _buildScanOption(
                  'Galerie',
                  'Sélectionner depuis la galerie',
                  Icons.photo_library,
                  Colors.green,
                  () => _scanFromGallery(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          _buildQuickActions(),
        ],
      ),
    );
  }

  Widget _buildScanOption(
    String title,
    String subtitle,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: color.withOpacity(0.1),
                child: Icon(icon, color: color, size: 32),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, color: Colors.grey[400]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Actions Rapides',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _buildQuickActionChip('Passeport', DocumentType.passport),
            _buildQuickActionChip('Visa', DocumentType.visa),
            _buildQuickActionChip('Diplôme', DocumentType.diploma),
            _buildQuickActionChip('Assurance', DocumentType.insurance),
          ],
        ),
      ],
    );
  }

  Widget _buildQuickActionChip(String label, DocumentType type) {
    return ActionChip(
      label: Text(label),
      onPressed: () => _scanDocumentType(type),
      avatar: Text(_getDocumentTypeIcon(type)),
    );
  }

  Widget _buildSearchTab() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: TextField(
            decoration: const InputDecoration(
              hintText: 'Rechercher un document...',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
              });
            },
          ),
        ),
        Expanded(
          child: _buildSearchResults(),
        ),
      ],
    );
  }

  Widget _buildSearchResults() {
    final results = _scannerService.searchDocuments(_searchQuery);
    
    if (results.isEmpty && _searchQuery.isNotEmpty) {
      return const Center(
        child: Text('Aucun document trouvé'),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: results.length,
      itemBuilder: (context, index) {
        final document = results[index];
        return _buildDocumentCard(document);
      },
    );
  }

  Future<void> _scanFromCamera() async {
    try {
      final document = await _scannerService.scanFromCamera();
      if (document != null) {
        _showDocumentEditDialog(document);
      }
    } catch (e) {
      _showErrorSnackBar('Erreur lors de la prise de photo: $e');
    }
  }

  Future<void> _scanFromGallery() async {
    try {
      final document = await _scannerService.scanFromGallery();
      if (document != null) {
        _showDocumentEditDialog(document);
      }
    } catch (e) {
      _showErrorSnackBar('Erreur lors de la sélection: $e');
    }
  }

  Future<void> _scanDocumentType(DocumentType type) async {
    // Implémentation simplifiée - dans une vraie app, on ouvrirait directement la caméra
    _showInfoSnackBar('Fonctionnalité à implémenter pour $type');
  }

  void _showDocumentEditDialog(ScannedDocument document) {
    showDialog(
      context: context,
      builder: (context) => _DocumentEditDialog(
        document: document,
        onSave: (updatedDocument) async {
          await _scannerService.updateDocument(updatedDocument);
          setState(() {
            _documents = _scannerService.scannedDocuments;
          });
        },
      ),
    );
  }

  void _handleDocumentAction(String action, ScannedDocument document) {
    switch (action) {
      case 'edit':
        _showDocumentEditDialog(document);
        break;
      case 'delete':
        _showDeleteConfirmation(document);
        break;
    }
  }

  void _showDeleteConfirmation(ScannedDocument document) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Supprimer le document'),
        content: Text('Êtes-vous sûr de vouloir supprimer "${document.name}" ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () async {
              await _scannerService.deleteDocument(document.id);
              setState(() {
                _documents = _scannerService.scannedDocuments;
              });
              Navigator.pop(context);
            },
            child: const Text('Supprimer', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
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

  Color _getDocumentTypeColor(DocumentType type) {
    switch (type) {
      case DocumentType.passport:
        return Colors.blue;
      case DocumentType.visa:
        return Colors.green;
      case DocumentType.diploma:
        return Colors.purple;
      case DocumentType.insurance:
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  String _getDocumentTypeIcon(DocumentType type) {
    switch (type) {
      case DocumentType.passport:
        return '🛂';
      case DocumentType.visa:
        return '📋';
      case DocumentType.diploma:
        return '🎓';
      case DocumentType.insurance:
        return '🛡️';
      default:
        return '📄';
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}

class _DocumentEditDialog extends StatefulWidget {
  final ScannedDocument document;
  final Function(ScannedDocument) onSave;

  const _DocumentEditDialog({
    required this.document,
    required this.onSave,
  });

  @override
  State<_DocumentEditDialog> createState() => _DocumentEditDialogState();
}

class _DocumentEditDialogState extends State<_DocumentEditDialog> {
  late TextEditingController _nameController;
  late TextEditingController _notesController;
  late DocumentType _selectedType;
  late bool _isImportant;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.document.name);
    _notesController = TextEditingController(text: widget.document.notes ?? '');
    _selectedType = widget.document.type;
    _isImportant = widget.document.isImportant;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Modifier le document'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nom du document',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<DocumentType>(
              value: _selectedType,
              decoration: const InputDecoration(
                labelText: 'Type de document',
                border: OutlineInputBorder(),
              ),
              items: DocumentType.values.map((type) {
                return DropdownMenuItem(
                  value: type,
                  child: Text(ScannedDocument.getTypeDisplayName(type)),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedType = value!;
                });
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _notesController,
              decoration: const InputDecoration(
                labelText: 'Notes (optionnel)',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            CheckboxListTile(
              title: const Text('Document important'),
              value: _isImportant,
              onChanged: (value) {
                setState(() {
                  _isImportant = value!;
                });
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Annuler'),
        ),
        ElevatedButton(
          onPressed: () {
            final updatedDocument = widget.document.copyWith(
              name: _nameController.text,
              type: _selectedType,
              notes: _notesController.text.isEmpty ? null : _notesController.text,
              isImportant: _isImportant,
            );
            widget.onSave(updatedDocument);
            Navigator.pop(context);
          },
          child: const Text('Sauvegarder'),
        ),
      ],
    );
  }
}
