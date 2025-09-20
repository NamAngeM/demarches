import 'dart:convert';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import '../../domain/entities/scanned_document.dart';

class DocumentScannerService {
  static DocumentScannerService? _instance;
  static DocumentScannerService get instance => _instance ??= DocumentScannerService._();
  DocumentScannerService._();

  final ImagePicker _imagePicker = ImagePicker();
  List<ScannedDocument> _scannedDocuments = [];

  List<ScannedDocument> get scannedDocuments => List.unmodifiable(_scannedDocuments);

  /// Obtient les caméras disponibles
  Future<List<CameraDescription>> getAvailableCameras() async {
    return await availableCameras();
  }

  /// Scanne un document depuis la galerie
  Future<ScannedDocument?> scanFromGallery() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (image == null) return null;

      return await _processImage(image.path);
    } catch (e) {
      print('Erreur lors de la sélection depuis la galerie: $e');
      return null;
    }
  }

  /// Scanne un document depuis l'appareil photo
  Future<ScannedDocument?> scanFromCamera() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
      );

      if (image == null) return null;

      return await _processImage(image.path);
    } catch (e) {
      print('Erreur lors de la prise de photo: $e');
      return null;
    }
  }

  /// Traite l'image scannée
  Future<ScannedDocument> _processImage(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final documentsDir = Directory(path.join(directory.path, 'scanned_documents'));
    
    if (!await documentsDir.exists()) {
      await documentsDir.create(recursive: true);
    }

    final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
    final newPath = path.join(documentsDir.path, fileName);
    
    // Copier l'image vers le dossier des documents scannés
    await File(imagePath).copy(newPath);

    final document = ScannedDocument(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: _generateDocumentName(),
      type: DocumentType.other,
      imagePath: newPath,
      scannedAt: DateTime.now(),
    );

    _scannedDocuments.add(document);
    await _saveDocuments();

    return document;
  }

  /// Génère un nom automatique pour le document
  String _generateDocumentName() {
    final now = DateTime.now();
    return 'Document_${now.day}_${now.month}_${now.year}';
  }

  /// Met à jour un document scanné
  Future<void> updateDocument(ScannedDocument updatedDocument) async {
    final index = _scannedDocuments.indexWhere((doc) => doc.id == updatedDocument.id);
    if (index != -1) {
      _scannedDocuments[index] = updatedDocument;
      await _saveDocuments();
    }
  }

  /// Supprime un document scanné
  Future<void> deleteDocument(String documentId) async {
    final document = _scannedDocuments.firstWhere((doc) => doc.id == documentId);
    
    // Supprimer le fichier image
    try {
      await File(document.imagePath).delete();
    } catch (e) {
      print('Erreur lors de la suppression du fichier: $e');
    }

    _scannedDocuments.removeWhere((doc) => doc.id == documentId);
    await _saveDocuments();
  }

  /// Obtient les documents par type
  List<ScannedDocument> getDocumentsByType(DocumentType type) {
    return _scannedDocuments.where((doc) => doc.type == type).toList();
  }

  /// Obtient les documents importants
  List<ScannedDocument> getImportantDocuments() {
    return _scannedDocuments.where((doc) => doc.isImportant).toList();
  }

  /// Recherche des documents
  List<ScannedDocument> searchDocuments(String query) {
    if (query.isEmpty) return _scannedDocuments;
    
    final lowercaseQuery = query.toLowerCase();
    return _scannedDocuments.where((doc) {
      return doc.name.toLowerCase().contains(lowercaseQuery) ||
             doc.typeDisplayName.toLowerCase().contains(lowercaseQuery) ||
             (doc.notes?.toLowerCase().contains(lowercaseQuery) ?? false);
    }).toList();
  }

  /// Sauvegarde les documents
  Future<void> _saveDocuments() async {
    // Dans une vraie application, on sauvegarderait dans une base de données
    // Pour l'instant, on garde juste en mémoire
    print('${_scannedDocuments.length} documents scannés sauvegardés');
  }

  /// Charge les documents
  Future<void> loadDocuments() async {
    // Dans une vraie application, on chargerait depuis une base de données
    // Pour l'instant, on initialise avec des documents d'exemple
    _scannedDocuments = _getSampleDocuments();
  }

  /// Obtient des documents d'exemple
  List<ScannedDocument> _getSampleDocuments() {
    return [
      ScannedDocument(
        id: '1',
        name: 'Passeport',
        type: DocumentType.passport,
        imagePath: '',
        scannedAt: DateTime.now().subtract(const Duration(days: 30)),
        isImportant: true,
        notes: 'Passeport valide jusqu\'en 2025',
      ),
      ScannedDocument(
        id: '2',
        name: 'Visa étudiant',
        type: DocumentType.visa,
        imagePath: '',
        scannedAt: DateTime.now().subtract(const Duration(days: 15)),
        isImportant: true,
        notes: 'Visa long séjour valide 1 an',
      ),
      ScannedDocument(
        id: '3',
        name: 'Diplôme Master',
        type: DocumentType.diploma,
        imagePath: '',
        scannedAt: DateTime.now().subtract(const Duration(days: 7)),
        isImportant: true,
        notes: 'Diplôme traduit et certifié',
      ),
    ];
  }

  /// Obtient les statistiques des documents
  Map<String, dynamic> getDocumentStatistics() {
    final total = _scannedDocuments.length;
    final important = _scannedDocuments.where((doc) => doc.isImportant).length;
    final byType = <DocumentType, int>{};
    
    for (final type in DocumentType.values) {
      byType[type] = _scannedDocuments.where((doc) => doc.type == type).length;
    }

    return {
      'total': total,
      'important': important,
      'byType': byType,
      'recentCount': _scannedDocuments.where((doc) => 
        doc.scannedAt.isAfter(DateTime.now().subtract(const Duration(days: 7)))
      ).length,
    };
  }
}
