import '../../domain/entities/guide.dart';

class ComprehensiveGuideService {
  // Créer tous les guides détaillés basés sur le contenu fourni
  static List<Guide> createComprehensiveGuides() {
    return [
      _createVisaGuide(),
      _createHousingGuide(),
      _createBankingGuide(),
      _createHealthGuide(),
      _createTransportGuide(),
      _createUniversityGuide(),
      _createFinancialAidGuide(),
      _createWorkGuide(),
      _createPostGraduationGuide(),
      _createEmergencyGuide(),
      _createBudgetGuide(),
      _createReductionsGuide(),
      _createTimelineGuide(),
    ];
  }

  static Guide _createVisaGuide() {
    return Guide(
      id: 'visa_etudiant_complet',
      title: 'Visa étudiant : Guide complet',
      description: 'Guide détaillé pour obtenir votre visa étudiant en France, avec toutes les étapes, documents requis et astuces pratiques.',
      shortDescription: 'Tout ce qu\'il faut savoir pour obtenir son visa étudiant',
      category: GuideCategory.visa,
      steps: [
        GuideStep(
          stepNumber: 1,
          title: 'Inscription Campus France',
          description: 'Inscription obligatoire pour les pays concernés par Campus France',
          requirements: ['Passeport valide', 'Justificatifs de ressources', 'Certificat de scolarité'],
          estimatedTime: '2-3 semaines',
          cost: 'Gratuit',
        ),
        GuideStep(
          stepNumber: 2,
          title: 'Acceptation établissement français',
          description: 'Obtenir une lettre d\'acceptation d\'un établissement français',
          requirements: ['Dossier de candidature', 'Diplômes traduits', 'Tests de français'],
          estimatedTime: '1-2 mois',
          cost: 'Variable selon établissement',
        ),
        GuideStep(
          stepNumber: 3,
          title: 'Rendez-vous consulat/ambassade',
          description: 'Prendre rendez-vous au consulat ou à l\'ambassade française',
          requirements: ['Passeport', 'Photos d\'identité', 'Dossier complet'],
          estimatedTime: '1-2 heures',
          cost: '99-269€ selon pays',
        ),
        GuideStep(
          stepNumber: 4,
          title: 'Constitution du dossier visa',
          description: 'Préparer tous les documents requis pour la demande de visa',
          requirements: [
            'Passeport valide (6 mois minimum)',
            'Photos d\'identité aux normes',
            'Justificatifs de ressources (7 380€/an minimum)',
            'Assurance santé internationale',
            'Certificat de scolarité/diplômes',
            'Lettre d\'acceptation',
            'Justificatif de logement'
          ],
          estimatedTime: '1-2 semaines',
          cost: 'Variable',
        ),
      ],
      difficulty: 'Moyen',
      estimatedDuration: '2-4 mois',
      tags: ['visa', 'étudiant', 'consulat', 'documents', 'essentiel'],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  static Guide _createHousingGuide() {
    return Guide(
      id: 'logement_etudiant_complet',
      title: 'Logement étudiant : Guide complet',
      description: 'Tout savoir sur la recherche de logement en France : plateformes, types, documents, pièges à éviter.',
      shortDescription: 'Guide complet pour trouver un logement étudiant',
      category: GuideCategory.housing,
      steps: [
        GuideStep(
          stepNumber: 1,
          title: 'Recherche à distance',
          description: 'Utiliser les plateformes fiables pour chercher un logement avant l\'arrivée',
          requirements: ['Connexion internet', 'Documents numérisés', 'Budget défini'],
          estimatedTime: '2-4 semaines',
          cost: 'Gratuit',
        ),
        GuideStep(
          stepNumber: 2,
          title: 'Choix du type de logement',
          description: 'Décider entre CROUS, résidence privée, colocation ou studio privé',
          requirements: ['Budget mensuel', 'Préférences personnelles', 'Localisation souhaitée'],
          estimatedTime: '1 semaine',
          cost: 'Variable',
        ),
        GuideStep(
          stepNumber: 3,
          title: 'Préparation des documents',
          description: 'Préparer tous les documents nécessaires pour la location',
          requirements: [
            'Garant français ou caution Visale',
            'Justificatifs de revenus (3x le loyer)',
            'Assurance habitation',
            'État des lieux d\'entrée'
          ],
          estimatedTime: '1-2 semaines',
          cost: 'Variable',
        ),
        GuideStep(
          stepNumber: 4,
          title: 'Visite et signature',
          description: 'Visiter le logement et signer le contrat de location',
          requirements: ['Contrat de bail', 'Caution', 'Premier loyer'],
          estimatedTime: '1-2 jours',
          cost: 'Caution + premier loyer',
        ),
      ],
      difficulty: 'Moyen',
      estimatedDuration: '1-2 mois',
      tags: ['logement', 'CROUS', 'colocation', 'documents', 'essentiel'],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  static Guide _createBankingGuide() {
    return Guide(
      id: 'banque_etudiant_complet',
      title: 'Ouverture compte bancaire : Guide complet',
      description: 'Comment ouvrir un compte bancaire en France : banques recommandées, documents, services essentiels.',
      shortDescription: 'Guide pour ouvrir un compte bancaire étudiant',
      category: GuideCategory.banking,
      steps: [
        GuideStep(
          stepNumber: 1,
          title: 'Choix de la banque',
          description: 'Sélectionner une banque adaptée aux étudiants étrangers',
          requirements: ['Comparaison des offres', 'Proximité géographique'],
          estimatedTime: '1 semaine',
          cost: 'Gratuit',
        ),
        GuideStep(
          stepNumber: 2,
          title: 'Préparation des documents',
          description: 'Rassembler tous les documents nécessaires',
          requirements: [
            'Passeport + visa/titre de séjour',
            'Justificatif de domicile récent',
            'Certificat de scolarité',
            'Justificatifs de revenus'
          ],
          estimatedTime: '1-2 semaines',
          cost: 'Gratuit',
        ),
        GuideStep(
          stepNumber: 3,
          title: 'Rendez-vous banque',
          description: 'Prendre rendez-vous et se présenter à la banque',
          requirements: ['Documents originaux', 'Rendez-vous pris'],
          estimatedTime: '1-2 heures',
          cost: 'Variable selon banque',
        ),
        GuideStep(
          stepNumber: 4,
          title: 'Configuration des services',
          description: 'Activer les services essentiels : carte, virements, app mobile',
          requirements: ['Compte ouvert', 'Carte reçue'],
          estimatedTime: '1 semaine',
          cost: 'Variable',
        ),
      ],
      difficulty: 'Facile',
      estimatedDuration: '2-3 semaines',
      tags: ['banque', 'compte', 'carte', 'virements', 'essentiel'],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  static Guide _createHealthGuide() {
    return Guide(
      id: 'sante_etudiant_complet',
      title: 'Santé et assurance : Guide complet',
      description: 'Système de santé français, sécurité sociale étudiante, mutuelles, numéros d\'urgence.',
      shortDescription: 'Guide complet du système de santé français',
      category: GuideCategory.health,
      steps: [
        GuideStep(
          stepNumber: 1,
          title: 'Inscription sécurité sociale',
          description: 'S\'inscrire à la sécurité sociale étudiante',
          requirements: ['Certificat de scolarité', 'Justificatif d\'identité'],
          estimatedTime: '2-3 semaines',
          cost: 'Gratuit',
        ),
        GuideStep(
          stepNumber: 2,
          title: 'Choix mutuelle étudiante',
          description: 'Souscrire à une mutuelle étudiante complémentaire',
          requirements: ['Carte vitale', 'Budget mensuel'],
          estimatedTime: '1 semaine',
          cost: '20-60€/mois',
        ),
        GuideStep(
          stepNumber: 3,
          title: 'Déclaration médecin traitant',
          description: 'Déclarer un médecin traitant dans les 6 mois',
          requirements: ['Carte vitale', 'Médecin choisi'],
          estimatedTime: '1 jour',
          cost: 'Gratuit',
        ),
        GuideStep(
          stepNumber: 4,
          title: 'Connaissance des numéros d\'urgence',
          description: 'Mémoriser les numéros d\'urgence essentiels',
          requirements: ['Aucun'],
          estimatedTime: '30 minutes',
          cost: 'Gratuit',
        ),
      ],
      difficulty: 'Facile',
      estimatedDuration: '1 mois',
      tags: ['santé', 'sécurité sociale', 'mutuelle', 'urgences', 'essentiel'],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  static Guide _createTransportGuide() {
    return Guide(
      id: 'transport_etudiant_complet',
      title: 'Transports : Guide complet',
      description: 'Transports en commun, abonnements étudiants, alternatives économiques.',
      shortDescription: 'Guide des transports étudiants en France',
      category: GuideCategory.transport,
      steps: [
        GuideStep(
          stepNumber: 1,
          title: 'Abonnement transport local',
          description: 'Souscrire à un abonnement transport en commun local',
          requirements: ['Carte étudiante', 'Justificatif domicile'],
          estimatedTime: '1 semaine',
          cost: 'Variable selon ville',
        ),
        GuideStep(
          stepNumber: 2,
          title: 'Carte SNCF Avantage Jeune',
          description: 'Souscrire à la carte Avantage Jeune pour les voyages',
          requirements: ['Justificatif âge', 'Carte d\'identité'],
          estimatedTime: '1 semaine',
          cost: '49€/an',
        ),
        GuideStep(
          stepNumber: 3,
          title: 'Abonnement vélo libre-service',
          description: 'Souscrire à un abonnement vélo en libre-service',
          requirements: ['Carte bancaire', 'Justificatif domicile'],
          estimatedTime: '1 jour',
          cost: 'Variable selon ville',
        ),
        GuideStep(
          stepNumber: 4,
          title: 'Applications transport',
          description: 'Télécharger les applications de transport utiles',
          requirements: ['Smartphone', 'Connexion internet'],
          estimatedTime: '30 minutes',
          cost: 'Gratuit',
        ),
      ],
      difficulty: 'Facile',
      estimatedDuration: '1-2 semaines',
      tags: ['transport', 'abonnement', 'SNCF', 'vélo', 'applications'],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  static Guide _createUniversityGuide() {
    return Guide(
      id: 'universite_etudiant_complet',
      title: 'Démarches universitaires : Guide complet',
      description: 'Inscription administrative, équivalences, apprentissage du français, réussite académique.',
      shortDescription: 'Guide des démarches universitaires en France',
      category: GuideCategory.work,
      steps: [
        GuideStep(
          stepNumber: 1,
          title: 'Inscription administrative',
          description: 'Effectuer l\'inscription administrative à l\'université',
          requirements: [
            'Formulaire inscription',
            'Photos d\'identité',
            'Diplômes traduits et certifiés',
            'Relevés de notes apostillés'
          ],
          estimatedTime: '1-2 semaines',
          cost: '170-3770€ selon statut',
        ),
        GuideStep(
          stepNumber: 2,
          title: 'Reconnaissance de diplômes',
          description: 'Faire reconnaître ses diplômes étrangers',
          requirements: ['Diplômes originaux', 'Traductions certifiées'],
          estimatedTime: '1-4 mois',
          cost: '70€',
        ),
        GuideStep(
          stepNumber: 3,
          title: 'Tests de français',
          description: 'Passer les tests de français requis',
          requirements: ['Inscription test', 'Préparation'],
          estimatedTime: '1-2 mois',
          cost: 'Variable selon test',
        ),
        GuideStep(
          stepNumber: 4,
          title: 'Méthodes de travail',
          description: 'Adapter ses méthodes de travail au système français',
          requirements: ['Aucun'],
          estimatedTime: 'Ongoing',
          cost: 'Gratuit',
        ),
      ],
      difficulty: 'Moyen',
      estimatedDuration: '2-3 mois',
      tags: ['université', 'inscription', 'diplômes', 'français', 'études'],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  static Guide _createFinancialAidGuide() {
    return Guide(
      id: 'aides_financieres_complet',
      title: 'Aides financières : Guide complet',
      description: 'Bourses CROUS, aides CAF, bourses d\'excellence, jobs étudiants.',
      shortDescription: 'Guide des aides financières pour étudiants',
      category: GuideCategory.work,
      steps: [
        GuideStep(
          stepNumber: 1,
          title: 'Bourses CROUS',
          description: 'Demander une bourse sur critères sociaux',
          requirements: [
            'Dossier social étudiant',
            'Justificatifs de ressources',
            'Certificat de scolarité'
          ],
          estimatedTime: '1-2 mois',
          cost: 'Gratuit',
        ),
        GuideStep(
          stepNumber: 2,
          title: 'Aides logement CAF',
          description: 'Demander les aides au logement (APL/ALS)',
          requirements: [
            'Justificatif identité et séjour',
            'Contrat de bail',
            'Quittances de loyer'
          ],
          estimatedTime: '2-3 mois',
          cost: 'Gratuit',
        ),
        GuideStep(
          stepNumber: 3,
          title: 'Bourses d\'excellence',
          description: 'Postuler aux bourses d\'excellence',
          requirements: ['Dossier de candidature', 'Lettres de recommandation'],
          estimatedTime: '2-3 mois',
          cost: 'Variable',
        ),
        GuideStep(
          stepNumber: 4,
          title: 'Jobs étudiants',
          description: 'Trouver un job étudiant autorisé',
          requirements: ['Autorisation préfectorale', 'CV français'],
          estimatedTime: '1-2 mois',
          cost: 'Gratuit',
        ),
      ],
      difficulty: 'Moyen',
      estimatedDuration: '2-3 mois',
      tags: ['bourses', 'aides', 'CAF', 'jobs', 'finances'],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  static Guide _createWorkGuide() {
    return Guide(
      id: 'stages_emploi_complet',
      title: 'Stages et emploi : Guide complet',
      description: 'Recherche de stages, entretiens, droits des stagiaires, insertion professionnelle.',
      shortDescription: 'Guide des stages et de l\'emploi étudiant',
      category: GuideCategory.work,
      steps: [
        GuideStep(
          stepNumber: 1,
          title: 'Recherche de stages',
          description: 'Utiliser les plateformes spécialisées pour trouver des stages',
          requirements: ['CV français', 'Lettre de motivation', 'Portfolio'],
          estimatedTime: '1-2 mois',
          cost: 'Gratuit',
        ),
        GuideStep(
          stepNumber: 2,
          title: 'Préparation entretiens',
          description: 'Se préparer aux entretiens de recrutement',
          requirements: ['Recherche entreprise', 'Simulation entretien'],
          estimatedTime: '1-2 semaines',
          cost: 'Gratuit',
        ),
        GuideStep(
          stepNumber: 3,
          title: 'Convention de stage',
          description: 'Signer une convention de stage conforme',
          requirements: ['Convention tripartite', 'Justificatifs'],
          estimatedTime: '1 semaine',
          cost: 'Gratuit',
        ),
        GuideStep(
          stepNumber: 4,
          title: 'Droits et protection',
          description: 'Connaître ses droits en tant que stagiaire',
          requirements: ['Aucun'],
          estimatedTime: '1 jour',
          cost: 'Gratuit',
        ),
      ],
      difficulty: 'Moyen',
      estimatedDuration: '1-2 mois',
      tags: ['stages', 'emploi', 'entretiens', 'droits', 'professionnel'],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  static Guide _createPostGraduationGuide() {
    return Guide(
      id: 'apres_etudes_complet',
      title: 'Après les études : Guide complet',
      description: 'Changement de statut, création d\'entreprise, poursuite d\'études.',
      shortDescription: 'Guide pour la vie après les études',
      category: GuideCategory.work,
      steps: [
        GuideStep(
          stepNumber: 1,
          title: 'Autorisation Provisoire de Séjour (APS)',
          description: 'Demander une APS pour rechercher un emploi',
          requirements: [
            'Diplôme obtenu',
            'Justificatifs de recherche emploi',
            'Salaire minimum 2 368€/mois'
          ],
          estimatedTime: '2-4 mois',
          cost: 'Variable',
        ),
        GuideStep(
          stepNumber: 2,
          title: 'Titre de séjour salarié',
          description: 'Obtenir un titre de séjour salarié',
          requirements: ['CDI ou CDD >12 mois', 'Salaire 1,5x SMIC'],
          estimatedTime: '2-4 mois',
          cost: 'Variable',
        ),
        GuideStep(
          stepNumber: 3,
          title: 'Création d\'entreprise',
          description: 'Créer son entreprise en France',
          requirements: ['Projet viable', 'Financement', 'Statut adapté'],
          estimatedTime: '1-3 mois',
          cost: 'Variable',
        ),
        GuideStep(
          stepNumber: 4,
          title: 'Poursuite d\'études',
          description: 'Continuer ses études en France',
          requirements: ['Dossier de candidature', 'Financement'],
          estimatedTime: '2-3 mois',
          cost: 'Variable',
        ),
      ],
      difficulty: 'Difficile',
      estimatedDuration: '2-4 mois',
      tags: ['après études', 'emploi', 'entreprise', 'poursuite', 'avenir'],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  static Guide _createEmergencyGuide() {
    return Guide(
      id: 'urgences_contacts_complet',
      title: 'Urgences et contacts utiles',
      description: 'Numéros d\'urgence, services de santé étudiants, ressources d\'aide.',
      shortDescription: 'Guide des urgences et contacts essentiels',
      category: GuideCategory.emergency,
      steps: [
        GuideStep(
          stepNumber: 1,
          title: 'Numéros d\'urgence essentiels',
          description: 'Mémoriser les numéros d\'urgence de base',
          requirements: ['Aucun'],
          estimatedTime: '30 minutes',
          cost: 'Gratuit',
        ),
        GuideStep(
          stepNumber: 2,
          title: 'Services santé étudiants',
          description: 'Connaître les services de santé spécialisés étudiants',
          requirements: ['Carte étudiante'],
          estimatedTime: '1 jour',
          cost: 'Gratuit',
        ),
        GuideStep(
          stepNumber: 3,
          title: 'Ressources d\'aide',
          description: 'Identifier les ressources d\'aide disponibles',
          requirements: ['Aucun'],
          estimatedTime: '1 jour',
          cost: 'Gratuit',
        ),
        GuideStep(
          stepNumber: 4,
          title: 'Assurance et protection',
          description: 'Vérifier sa couverture d\'assurance',
          requirements: ['Contrats d\'assurance'],
          estimatedTime: '1 semaine',
          cost: 'Variable',
        ),
      ],
      difficulty: 'Facile',
      estimatedDuration: '1 semaine',
      tags: ['urgences', 'contacts', 'santé', 'aide', 'sécurité'],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  static Guide _createBudgetGuide() {
    return Guide(
      id: 'budget_etudiant_complet',
      title: 'Budget étudiant : Guide complet',
      description: 'Gestion du budget, courses alimentaires, équipements, astuces économiques.',
      shortDescription: 'Guide de gestion du budget étudiant',
      category: GuideCategory.work,
      steps: [
        GuideStep(
          stepNumber: 1,
          title: 'Calcul du budget mensuel',
          description: 'Établir un budget mensuel réaliste',
          requirements: ['Revenus', 'Dépenses fixes', 'Objectifs'],
          estimatedTime: '1 jour',
          cost: 'Gratuit',
        ),
        GuideStep(
          stepNumber: 2,
          title: 'Courses alimentaires optimisées',
          description: 'Optimiser ses courses alimentaires',
          requirements: ['Liste de courses', 'Applications anti-gaspi'],
          estimatedTime: 'Ongoing',
          cost: 'Variable',
        ),
        GuideStep(
          stepNumber: 3,
          title: 'Équipements premier logement',
          description: 'Équiper son premier logement à moindre coût',
          requirements: ['Budget défini', 'Liste des besoins'],
          estimatedTime: '1-2 semaines',
          cost: 'Variable',
        ),
        GuideStep(
          stepNumber: 4,
          title: 'Astuces économiques',
          description: 'Appliquer des astuces pour économiser',
          requirements: ['Aucun'],
          estimatedTime: 'Ongoing',
          cost: 'Gratuit',
        ),
      ],
      difficulty: 'Facile',
      estimatedDuration: '1 mois',
      tags: ['budget', 'économies', 'courses', 'équipements', 'gestion'],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  static Guide _createReductionsGuide() {
    return Guide(
      id: 'reductions_etudiantes_complet',
      title: 'Réductions étudiantes : Guide complet',
      description: 'Toutes les réductions et bons plans étudiants : culture, shopping, services.',
      shortDescription: 'Guide des réductions étudiantes',
      category: GuideCategory.culture,
      steps: [
        GuideStep(
          stepNumber: 1,
          title: 'Culture et loisirs',
          description: 'Profiter des réductions culture et loisirs',
          requirements: ['Carte étudiante', 'Justificatifs'],
          estimatedTime: '1 jour',
          cost: 'Variable',
        ),
        GuideStep(
          stepNumber: 2,
          title: 'Shopping et services',
          description: 'Utiliser les réductions shopping et services',
          requirements: ['Carte étudiante', 'Inscriptions'],
          estimatedTime: '1 semaine',
          cost: 'Variable',
        ),
        GuideStep(
          stepNumber: 3,
          title: 'Applications indispensables',
          description: 'Télécharger les applications utiles',
          requirements: ['Smartphone', 'Connexion internet'],
          estimatedTime: '1 jour',
          cost: 'Gratuit',
        ),
        GuideStep(
          stepNumber: 4,
          title: 'Événements et networking',
          description: 'Participer aux événements étudiants',
          requirements: ['Inscriptions', 'Participation'],
          estimatedTime: 'Ongoing',
          cost: 'Variable',
        ),
      ],
      difficulty: 'Facile',
      estimatedDuration: '1 mois',
      tags: ['réductions', 'culture', 'shopping', 'applications', 'événements'],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  static Guide _createTimelineGuide() {
    return Guide(
      id: 'chronologie_demarches_complet',
      title: 'Chronologie des démarches',
      description: 'Planning détaillé des démarches à effectuer avant, pendant et après l\'arrivée en France.',
      shortDescription: 'Planning chronologique des démarches',
      category: GuideCategory.visa,
      steps: [
        GuideStep(
          stepNumber: 1,
          title: '6 mois avant départ',
          description: 'Démarches à effectuer 6 mois avant l\'arrivée',
          requirements: [
            'Demande visa étudiant',
            'Recherche logement',
            'Demande bourses',
            'Tests de français',
            'Assurance santé internationale'
          ],
          estimatedTime: '6 mois',
          cost: 'Variable',
        ),
        GuideStep(
          stepNumber: 2,
          title: '1 mois avant départ',
          description: 'Démarches à effectuer 1 mois avant l\'arrivée',
          requirements: [
            'Confirmation logement',
            'Réservation transport',
            'Documents traduits/apostillés',
            'Budget voyage et installation',
            'Contact établissement français'
          ],
          estimatedTime: '1 mois',
          cost: 'Variable',
        ),
        GuideStep(
          stepNumber: 3,
          title: 'Première semaine en France',
          description: 'Démarches urgentes à effectuer dès l\'arrivée',
          requirements: [
            'Validation visa/titre séjour',
            'Ouverture compte bancaire',
            'Inscription sécurité sociale',
            'Abonnement transport',
            'Forfait téléphone français'
          ],
          estimatedTime: '1 semaine',
          cost: 'Variable',
        ),
        GuideStep(
          stepNumber: 4,
          title: 'Premier mois',
          description: 'Démarches à effectuer dans le premier mois',
          requirements: [
            'Déclaration médecin traitant',
            'Demande aides logement (CAF)',
            'Inscription bibliothèques',
            'Associations étudiantes',
            'Groupes réseaux sociaux'
          ],
          estimatedTime: '1 mois',
          cost: 'Variable',
        ),
      ],
      difficulty: 'Moyen',
      estimatedDuration: '6 mois',
      tags: ['chronologie', 'planning', 'démarches', 'étapes', 'essentiel'],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }
}
