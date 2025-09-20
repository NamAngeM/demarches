import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/checklist_item.dart';
import 'location_service.dart';

class ChecklistService {
  static ChecklistService? _instance;
  static ChecklistService get instance => _instance ??= ChecklistService._();
  ChecklistService._();

  static const String _checklistKey = 'student_checklist';
  List<ChecklistItem> _checklistItems = [];

  List<ChecklistItem> get checklistItems => List.unmodifiable(_checklistItems);

  /// Initialise la checklist avec les éléments par défaut
  Future<void> initializeChecklist() async {
    if (_checklistItems.isNotEmpty) return;

    _checklistItems = _getDefaultChecklistItems();
    await _saveChecklist();
  }

  /// Obtient la checklist par défaut
  List<ChecklistItem> _getDefaultChecklistItems() {
    return [
      // DÉMARCHES AVANT L'ARRIVÉE
      ChecklistItem(
        id: 'visa_application',
        title: 'Demande de visa étudiant',
        description: 'Faire la demande de visa étudiant dans votre pays d\'origine',
        priority: ChecklistPriority.urgent,
        category: 'Avant l\'arrivée',
        requiredDocuments: [
          'Passeport valide (6 mois minimum)',
          'Photos d\'identité aux normes',
          'Justificatifs de ressources (7 380€/an minimum)',
          'Assurance santé internationale',
          'Certificat de scolarité/diplômes',
          'Lettre d\'acceptation de l\'établissement',
          'Justificatif de logement ou attestation d\'hébergement',
        ],
        steps: [
          'Inscription sur Campus France (si applicable)',
          'Acceptation dans un établissement français',
          'Prise de rendez-vous consulat/ambassade',
          'Constitution du dossier visa',
          'Paiement des frais de visa',
        ],
        estimatedDurationDays: 30,
        isLocationDependent: true,
      ),
      ChecklistItem(
        id: 'housing_search',
        title: 'Recherche de logement',
        description: 'Trouver un logement avant votre arrivée en France',
        priority: ChecklistPriority.high,
        category: 'Avant l\'arrivée',
        requiredDocuments: [
          'Garant français ou caution Visale',
          'Justificatifs de revenus (3x le loyer)',
          'Assurance habitation',
        ],
        steps: [
          'Recherche sur les plateformes (CROUS, Studapart, etc.)',
          'Visite virtuelle ou physique',
          'Signature du contrat de bail',
          'Paiement de la caution et du premier loyer',
        ],
        estimatedDurationDays: 45,
        isLocationDependent: true,
      ),
      ChecklistItem(
        id: 'insurance_international',
        title: 'Assurance santé internationale',
        description: 'Souscrire une assurance santé pour la période avant l\'arrivée',
        priority: ChecklistPriority.high,
        category: 'Avant l\'arrivée',
        requiredDocuments: [
          'Passeport',
          'Lettre d\'acceptation universitaire',
        ],
        steps: [
          'Comparer les offres d\'assurance',
          'Souscrire une assurance internationale',
          'Recevoir la carte d\'assurance',
        ],
        estimatedDurationDays: 7,
      ),

      // DÉMARCHES D'ARRIVÉE
      ChecklistItem(
        id: 'visa_validation',
        title: 'Validation du visa VLS-TS',
        description: 'Valider votre visa VLS-TS dans les 3 premiers mois',
        priority: ChecklistPriority.urgent,
        category: 'Arrivée en France',
        requiredDocuments: [
          'Passeport avec visa VLS-TS',
          'Justificatif de domicile',
          'Timbre fiscal (60€)',
        ],
        steps: [
          'Se connecter sur administration-etrangers-en-france.interieur.gouv.fr',
          'Remplir le formulaire de validation',
          'Payer la taxe OFII (60€)',
          'Attendre la vignette OFII par courrier',
        ],
        estimatedDurationDays: 15,
        isLocationDependent: true,
      ),
      ChecklistItem(
        id: 'bank_account',
        title: 'Ouverture de compte bancaire',
        description: 'Ouvrir un compte bancaire français',
        priority: ChecklistPriority.high,
        category: 'Arrivée en France',
        requiredDocuments: [
          'Passeport + visa/titre de séjour',
          'Justificatif de domicile récent',
          'Certificat de scolarité',
          'Justificatifs de revenus',
        ],
        steps: [
          'Choisir une banque étudiante',
          'Prendre rendez-vous',
          'Préparer les documents',
          'Signer le contrat',
          'Recevoir la carte bancaire',
        ],
        estimatedDurationDays: 10,
        isLocationDependent: true,
      ),
      ChecklistItem(
        id: 'social_security',
        title: 'Inscription sécurité sociale',
        description: 'S\'inscrire à la sécurité sociale étudiante',
        priority: ChecklistPriority.high,
        category: 'Arrivée en France',
        requiredDocuments: [
          'Carte d\'étudiant',
          'Justificatif de domicile',
          'RIB français',
        ],
        steps: [
          'Inscription automatique via l\'université',
          'Attendre la carte vitale (2-3 semaines)',
          'Déclarer un médecin traitant',
        ],
        estimatedDurationDays: 21,
      ),
      ChecklistItem(
        id: 'transport_subscription',
        title: 'Abonnement transport',
        description: 'Souscrire un abonnement transport étudiant',
        priority: ChecklistPriority.medium,
        category: 'Arrivée en France',
        requiredDocuments: [
          'Carte d\'étudiant',
          'Justificatif de domicile',
          'Photo d\'identité',
        ],
        steps: [
          'Se rendre au guichet transport',
          'Remplir le formulaire',
          'Payer l\'abonnement',
          'Recevoir la carte',
        ],
        estimatedDurationDays: 3,
        isLocationDependent: true,
      ),
      ChecklistItem(
        id: 'university_registration',
        title: 'Inscription universitaire',
        description: 'Finaliser l\'inscription administrative à l\'université',
        priority: ChecklistPriority.high,
        category: 'Arrivée en France',
        requiredDocuments: [
          'Diplômes traduits et certifiés',
          'Relevés de notes apostillés',
          'Photos d\'identité',
          'Certificat médical',
        ],
        steps: [
          'Récupérer le dossier d\'inscription',
          'Remplir et retourner les documents',
          'Payer les frais de scolarité',
          'Récupérer la carte d\'étudiant',
        ],
        estimatedDurationDays: 7,
        isLocationDependent: true,
      ),
      ChecklistItem(
        id: 'caf_application',
        title: 'Demande d\'aide au logement (CAF)',
        description: 'Faire une demande d\'APL ou d\'ALS',
        priority: ChecklistPriority.medium,
        category: 'Arrivée en France',
        requiredDocuments: [
          'Justificatif d\'identité et de séjour',
          'Contrat de bail',
          'Quittances de loyer',
          'Relevés bancaires',
        ],
        steps: [
          'Créer un compte sur caf.fr',
          'Remplir le formulaire en ligne',
          'Envoyer les justificatifs',
          'Attendre la décision',
        ],
        estimatedDurationDays: 30,
      ),
      ChecklistItem(
        id: 'phone_contract',
        title: 'Forfait téléphonique',
        description: 'Souscrire un forfait mobile français',
        priority: ChecklistPriority.low,
        category: 'Arrivée en France',
        requiredDocuments: [
          'Passeport',
          'Justificatif de domicile',
          'RIB français',
        ],
        steps: [
          'Choisir un opérateur',
          'Se rendre en boutique',
          'Signer le contrat',
          'Activer la ligne',
        ],
        estimatedDurationDays: 1,
      ),
    ];
  }

  /// Met à jour le statut d'un élément de la checklist
  Future<void> updateItemStatus(String itemId, ChecklistStatus newStatus) async {
    final index = _checklistItems.indexWhere((item) => item.id == itemId);
    if (index != -1) {
      _checklistItems[index] = _checklistItems[index].copyWith(
        status: newStatus,
        completedDate: newStatus == ChecklistStatus.completed ? DateTime.now() : null,
      );
      await _saveChecklist();
    }
  }

  /// Met à jour un élément de la checklist
  Future<void> updateItem(ChecklistItem updatedItem) async {
    final index = _checklistItems.indexWhere((item) => item.id == updatedItem.id);
    if (index != -1) {
      _checklistItems[index] = updatedItem;
      await _saveChecklist();
    }
  }

  /// Obtient les éléments par catégorie
  List<ChecklistItem> getItemsByCategory(String category) {
    return _checklistItems.where((item) => item.category == category).toList();
  }

  /// Obtient les éléments par statut
  List<ChecklistItem> getItemsByStatus(ChecklistStatus status) {
    return _checklistItems.where((item) => item.status == status).toList();
  }

  /// Obtient les éléments en retard
  List<ChecklistItem> getOverdueItems() {
    return _checklistItems.where((item) => item.isOverdue).toList();
  }

  /// Obtient les éléments à échéance proche
  List<ChecklistItem> getDueSoonItems() {
    return _checklistItems.where((item) => item.isDueSoon).toList();
  }

  /// Obtient les éléments urgents
  List<ChecklistItem> getUrgentItems() {
    return _checklistItems.where((item) => item.priority == ChecklistPriority.urgent).toList();
  }

  /// Calcule le pourcentage de progression
  double getProgressPercentage() {
    if (_checklistItems.isEmpty) return 0.0;
    final completedItems = _checklistItems.where((item) => item.status == ChecklistStatus.completed).length;
    return (completedItems / _checklistItems.length) * 100;
  }

  /// Obtient les statistiques de la checklist
  Map<String, int> getStatistics() {
    return {
      'total': _checklistItems.length,
      'completed': _checklistItems.where((item) => item.status == ChecklistStatus.completed).length,
      'inProgress': _checklistItems.where((item) => item.status == ChecklistStatus.inProgress).length,
      'notStarted': _checklistItems.where((item) => item.status == ChecklistStatus.notStarted).length,
      'overdue': _checklistItems.where((item) => item.isOverdue).length,
      'dueSoon': _checklistItems.where((item) => item.isDueSoon).length,
    };
  }

  /// Met à jour les informations locales pour les éléments dépendants de la localisation
  Future<void> updateLocalInfo() async {
    final locationService = LocationService.instance;
    final localServices = locationService.getLocalServices();

    for (int i = 0; i < _checklistItems.length; i++) {
      if (_checklistItems[i].isLocationDependent) {
        _checklistItems[i] = _checklistItems[i].copyWith(
          localInfo: _getLocalInfoForItem(_checklistItems[i].id, localServices),
        );
      }
    }

    await _saveChecklist();
  }

  /// Obtient les informations locales pour un élément spécifique
  Map<String, dynamic>? _getLocalInfoForItem(String itemId, Map<String, dynamic> localServices) {
    switch (itemId) {
      case 'visa_validation':
        return {
          'prefecture': localServices['prefecture'],
          'website': localServices['prefecture']['website'],
        };
      case 'bank_account':
        return {
          'suggestedBanks': [
            'Crédit Agricole',
            'BNP Paribas',
            'Société Générale',
            'Banques en ligne (Boursorama, Hello Bank)',
          ],
        };
      case 'transport_subscription':
        return {
          'company': localServices['transport']['company'],
          'website': localServices['transport']['website'],
          'studentCard': localServices['transport']['studentCard'],
          'price': localServices['transport']['price'],
        };
      case 'university_registration':
        return {
          'universities': localServices['universities'],
        };
      case 'housing_search':
        return {
          'crous': localServices['crous'],
          'suggestedPlatforms': [
            'CROUS',
            'Studapart',
            'Lokaviz',
            'PAP.fr',
            'Leboncoin',
          ],
        };
      default:
        return null;
    }
  }

  /// Sauvegarde la checklist dans le stockage local
  Future<void> _saveChecklist() async {
    final prefs = await SharedPreferences.getInstance();
    final checklistJson = _checklistItems.map((item) => _itemToJson(item)).toList();
    await prefs.setString(_checklistKey, jsonEncode(checklistJson));
  }

  /// Charge la checklist depuis le stockage local
  Future<void> loadChecklist() async {
    final prefs = await SharedPreferences.getInstance();
    final checklistString = prefs.getString(_checklistKey);
    
    if (checklistString != null) {
      final List<dynamic> checklistJson = jsonDecode(checklistString);
      _checklistItems = checklistJson.map((json) => _itemFromJson(json)).toList();
    } else {
      await initializeChecklist();
    }
  }

  /// Convertit un ChecklistItem en JSON
  Map<String, dynamic> _itemToJson(ChecklistItem item) {
    return {
      'id': item.id,
      'title': item.title,
      'description': item.description,
      'status': item.status.index,
      'priority': item.priority.index,
      'dueDate': item.dueDate?.millisecondsSinceEpoch,
      'completedDate': item.completedDate?.millisecondsSinceEpoch,
      'requiredDocuments': item.requiredDocuments,
      'steps': item.steps,
      'category': item.category,
      'location': item.location,
      'contactInfo': item.contactInfo,
      'website': item.website,
      'estimatedDurationDays': item.estimatedDurationDays,
      'isLocationDependent': item.isLocationDependent,
      'localInfo': item.localInfo,
    };
  }

  /// Convertit un JSON en ChecklistItem
  ChecklistItem _itemFromJson(Map<String, dynamic> json) {
    return ChecklistItem(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      status: ChecklistStatus.values[json['status']],
      priority: ChecklistPriority.values[json['priority']],
      dueDate: json['dueDate'] != null ? DateTime.fromMillisecondsSinceEpoch(json['dueDate']) : null,
      completedDate: json['completedDate'] != null ? DateTime.fromMillisecondsSinceEpoch(json['completedDate']) : null,
      requiredDocuments: List<String>.from(json['requiredDocuments'] ?? []),
      steps: List<String>.from(json['steps'] ?? []),
      category: json['category'],
      location: json['location'],
      contactInfo: json['contactInfo'],
      website: json['website'],
      estimatedDurationDays: json['estimatedDurationDays'] ?? 1,
      isLocationDependent: json['isLocationDependent'] ?? false,
      localInfo: json['localInfo'] != null ? Map<String, dynamic>.from(json['localInfo']) : null,
    );
  }
}
