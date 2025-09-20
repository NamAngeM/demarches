class EmergencyContact {
  final String name;
  final String number;
  final String description;
  final String category;
  final String priority;
  final bool isAvailable24h;

  const EmergencyContact({
    required this.name,
    required this.number,
    required this.description,
    required this.category,
    required this.priority,
    this.isAvailable24h = false,
  });
}

class EmergencyContactsService {
  static List<EmergencyContact> getAllContacts() {
    return [
      // Numéros d'urgence
      const EmergencyContact(
        name: 'Police',
        number: '17',
        description: 'Police nationale',
        category: 'security',
        priority: 'critical',
        isAvailable24h: true,
      ),
      const EmergencyContact(
        name: 'Pompiers',
        number: '18',
        description: 'Service d\'incendie et de secours',
        category: 'fire',
        priority: 'critical',
        isAvailable24h: true,
      ),
      const EmergencyContact(
        name: 'SAMU',
        number: '15',
        description: 'Service d\'aide médicale urgente',
        category: 'medical',
        priority: 'critical',
        isAvailable24h: true,
      ),
      const EmergencyContact(
        name: 'Urgences européen',
        number: '112',
        description: 'Numéro d\'urgence européen',
        category: 'european',
        priority: 'critical',
        isAvailable24h: true,
      ),
    ];
  }

  static List<EmergencyContact> getEmergencyNumbers() {
    return getAllContacts().where((contact) => contact.priority == 'critical').toList();
  }

  static List<EmergencyContact> getStudentHealthServices() {
    return [
      const EmergencyContact(
        name: 'Service de santé universitaire',
        number: '01 40 46 00 00',
        description: 'Soins médicaux pour étudiants',
        category: 'medical',
        priority: 'high',
      ),
    ];
  }

  static List<EmergencyContact> getSupportServices() {
    return [
      const EmergencyContact(
        name: 'SOS Amitié',
        number: '09 72 39 40 50',
        description: 'Écoute et soutien psychologique',
        category: 'mental_health',
        priority: 'high',
        isAvailable24h: true,
      ),
    ];
  }

  static List<EmergencyContact> getHousingEmergencyServices() {
    return [
      const EmergencyContact(
        name: '115',
        number: '115',
        description: 'Urgences logement',
        category: 'housing',
        priority: 'high',
        isAvailable24h: true,
      ),
    ];
  }

  static List<EmergencyContact> getAdministrativeServices() {
    return [
      const EmergencyContact(
        name: 'Préfecture',
        number: 'Voir site web',
        description: 'Services administratifs',
        category: 'administrative',
        priority: 'medium',
      ),
    ];
  }

  static List<EmergencyContact> getFinancialEmergencyServices() {
    return [
      const EmergencyContact(
        name: 'CROUS',
        number: '01 40 46 00 00',
        description: 'Aide financière étudiante',
        category: 'financial',
        priority: 'high',
      ),
    ];
  }
}