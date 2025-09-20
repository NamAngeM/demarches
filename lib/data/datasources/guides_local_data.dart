import '../../domain/entities/guide.dart';

class GuidesLocalData {
  static final List<Guide> guides = [
    Guide(
      id: '1',
      title: 'Obtenir un visa étudiant pour la France',
      description: 'Guide complet pour obtenir un visa étudiant en France, incluant les documents nécessaires, les démarches administratives et les délais.',
      shortDescription: 'Toutes les étapes pour obtenir votre visa étudiant',
      category: GuideCategory.visa,
      difficulty: 'Moyen',
      estimatedDuration: '2-3 mois',
      tags: ['visa', 'étudiant', 'france', 'documents'],
      imageUrl: 'assets/images/visa-guide.jpg',
      steps: [
        GuideStep(
          stepNumber: 1,
          title: 'Inscription dans un établissement français',
          description: 'Vous devez d\'abord être accepté dans un établissement d\'enseignement supérieur français.',
          requirements: [
            'Diplôme de fin d\'études secondaires',
            'Certificat de langue française (DELF/DALF)',
            'Lettre de motivation',
            'Relevés de notes'
          ],
          estimatedTime: '1-2 mois',
        ),
        GuideStep(
          stepNumber: 2,
          title: 'Préparer les documents',
          description: 'Rassemblez tous les documents nécessaires pour votre demande de visa.',
          requirements: [
            'Passeport valide',
            'Attestation d\'inscription',
            'Justificatifs de ressources financières',
            'Assurance maladie',
            'Photos d\'identité'
          ],
          estimatedTime: '2-3 semaines',
        ),
        GuideStep(
          stepNumber: 3,
          title: 'Prendre rendez-vous',
          description: 'Prenez rendez-vous auprès du consulat français de votre pays.',
          requirements: ['Passeport', 'Attestation d\'inscription'],
          estimatedTime: '1-2 semaines',
        ),
        GuideStep(
          stepNumber: 4,
          title: 'Dépôt de la demande',
          description: 'Déposez votre dossier complet au consulat.',
          requirements: ['Dossier complet', 'Frais de visa'],
          estimatedTime: '1 jour',
          cost: '50-99€',
        ),
        GuideStep(
          stepNumber: 5,
          title: 'Attendre la décision',
          description: 'Le traitement de votre demande prend généralement 2-3 semaines.',
          estimatedTime: '2-3 semaines',
        ),
      ],
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
      updatedAt: DateTime.now().subtract(const Duration(days: 5)),
    ),
    
    Guide(
      id: '2',
      title: 'S\'inscrire à l\'université en France',
      description: 'Processus complet d\'inscription dans une université française, de la candidature à l\'inscription définitive.',
      shortDescription: 'Comment s\'inscrire dans une université française',
      category: GuideCategory.university,
      difficulty: 'Moyen',
      estimatedDuration: '3-4 mois',
      tags: ['université', 'inscription', 'candidature', 'parcoursup'],
      imageUrl: 'assets/images/university-guide.jpg',
      steps: [
        GuideStep(
          stepNumber: 1,
          title: 'Choisir votre formation',
          description: 'Explorez les formations disponibles et choisissez celle qui correspond à vos objectifs.',
          requirements: ['Diplôme de fin d\'études', 'Niveau de français'],
          estimatedTime: '1 mois',
        ),
        GuideStep(
          stepNumber: 2,
          title: 'Candidater via Parcoursup',
          description: 'Créez votre dossier sur la plateforme Parcoursup et postulez aux formations.',
          requirements: ['Relevés de notes', 'Lettre de motivation', 'CV'],
          estimatedTime: '2-3 semaines',
        ),
        GuideStep(
          stepNumber: 3,
          title: 'Passer les tests de langue',
          description: 'Passez les tests de français requis (TCF, DELF, DALF).',
          requirements: ['Inscription aux tests', 'Préparation'],
          estimatedTime: '1-2 mois',
          cost: '100-200€',
        ),
        GuideStep(
          stepNumber: 4,
          title: 'Finaliser l\'inscription',
          description: 'Une fois accepté, finalisez votre inscription administrative.',
          requirements: ['Visa étudiant', 'Documents d\'identité', 'Frais d\'inscription'],
          estimatedTime: '1 semaine',
          cost: '170-600€',
        ),
      ],
      createdAt: DateTime.now().subtract(const Duration(days: 25)),
      updatedAt: DateTime.now().subtract(const Duration(days: 3)),
    ),

    Guide(
      id: '3',
      title: 'Ouvrir un compte bancaire en France',
      description: 'Guide étape par étape pour ouvrir un compte bancaire en tant qu\'étudiant étranger.',
      shortDescription: 'Ouvrir un compte bancaire étudiant',
      category: GuideCategory.banking,
      difficulty: 'Facile',
      estimatedDuration: '1-2 semaines',
      tags: ['banque', 'compte', 'étudiant', 'RIB'],
      imageUrl: 'assets/images/banking-guide.jpg',
      steps: [
        GuideStep(
          stepNumber: 1,
          title: 'Choisir une banque',
          description: 'Comparez les offres des différentes banques pour étudiants.',
          requirements: ['Recherche en ligne', 'Visite des agences'],
          estimatedTime: '2-3 jours',
        ),
        GuideStep(
          stepNumber: 2,
          title: 'Prendre rendez-vous',
          description: 'Contactez la banque choisie pour prendre rendez-vous.',
          requirements: ['Téléphone ou site web'],
          estimatedTime: '1 jour',
        ),
        GuideStep(
          stepNumber: 3,
          title: 'Préparer les documents',
          description: 'Rassemblez tous les documents nécessaires.',
          requirements: [
            'Passeport ou carte d\'identité',
            'Visa étudiant',
            'Attestation d\'inscription',
            'Justificatif de domicile',
            'RIB de votre banque d\'origine'
          ],
          estimatedTime: '1 semaine',
        ),
        GuideStep(
          stepNumber: 4,
          title: 'Signature du contrat',
          description: 'Signez le contrat d\'ouverture de compte.',
          estimatedTime: '1-2 heures',
        ),
      ],
      createdAt: DateTime.now().subtract(const Duration(days: 20)),
      updatedAt: DateTime.now().subtract(const Duration(days: 1)),
    ),

    Guide(
      id: '4',
      title: 'Trouver un logement étudiant',
      description: 'Conseils et astuces pour trouver un logement étudiant en France.',
      shortDescription: 'Trouver un logement étudiant',
      category: GuideCategory.housing,
      difficulty: 'Difficile',
      estimatedDuration: '1-2 mois',
      tags: ['logement', 'étudiant', 'colocation', 'CROUS'],
      imageUrl: 'assets/images/housing-guide.jpg',
      steps: [
        GuideStep(
          stepNumber: 1,
          title: 'Définir votre budget',
          description: 'Calculez votre budget mensuel pour le logement.',
          requirements: ['Calcul des revenus', 'Estimation des charges'],
          estimatedTime: '1 jour',
        ),
        GuideStep(
          stepNumber: 2,
          title: 'Rechercher des logements',
          description: 'Utilisez les plateformes spécialisées et les réseaux étudiants.',
          requirements: ['Inscription sur les sites', 'Profil complet'],
          estimatedTime: '2-3 semaines',
        ),
        GuideStep(
          stepNumber: 3,
          title: 'Visiter les logements',
          description: 'Organisez des visites des logements qui vous intéressent.',
          requirements: ['Rendez-vous', 'Questions préparées'],
          estimatedTime: '1-2 semaines',
        ),
        GuideStep(
          stepNumber: 4,
          title: 'Signer le bail',
          description: 'Finalisez la location en signant le contrat.',
          requirements: ['Garantie locative', 'Assurance habitation', 'Caution'],
          estimatedTime: '1 semaine',
          cost: '1-3 mois de loyer',
        ),
      ],
      createdAt: DateTime.now().subtract(const Duration(days: 15)),
      updatedAt: DateTime.now().subtract(const Duration(days: 2)),
    ),

    Guide(
      id: '5',
      title: 'S\'inscrire à la sécurité sociale étudiante',
      description: 'Processus d\'inscription à la sécurité sociale en tant qu\'étudiant étranger.',
      shortDescription: 'Inscription sécurité sociale étudiante',
      category: GuideCategory.health,
      difficulty: 'Facile',
      estimatedDuration: '2-3 semaines',
      tags: ['santé', 'sécurité sociale', 'étudiant', 'CPAM'],
      imageUrl: 'assets/images/health-guide.jpg',
      steps: [
        GuideStep(
          stepNumber: 1,
          title: 'Vérifier votre situation',
          description: 'Vérifiez si vous êtes déjà couvert par un régime de sécurité sociale.',
          requirements: ['Visa étudiant', 'Attestation d\'inscription'],
          estimatedTime: '1 jour',
        ),
        GuideStep(
          stepNumber: 2,
          title: 'Remplir le formulaire',
          description: 'Remplissez le formulaire d\'inscription en ligne.',
          requirements: ['Informations personnelles', 'Adresse en France'],
          estimatedTime: '30 minutes',
        ),
        GuideStep(
          stepNumber: 3,
          title: 'Envoyer les documents',
          description: 'Envoyez les documents justificatifs par courrier.',
          requirements: [
            'Formulaire signé',
            'Copie du passeport',
            'Attestation d\'inscription',
            'Justificatif de domicile'
          ],
          estimatedTime: '1 semaine',
        ),
        GuideStep(
          stepNumber: 4,
          title: 'Recevoir votre carte vitale',
          description: 'Attendez de recevoir votre carte vitale par courrier.',
          estimatedTime: '2-3 semaines',
        ),
      ],
      createdAt: DateTime.now().subtract(const Duration(days: 10)),
      updatedAt: DateTime.now().subtract(const Duration(days: 1)),
    ),

    Guide(
      id: '6',
      title: 'Utiliser les transports en commun',
      description: 'Guide complet pour utiliser les transports en commun en France.',
      shortDescription: 'Transports en commun en France',
      category: GuideCategory.transport,
      difficulty: 'Facile',
      estimatedDuration: '1 jour',
      tags: ['transport', 'métro', 'bus', 'abonnement'],
      imageUrl: 'assets/images/transport-guide.jpg',
      steps: [
        GuideStep(
          stepNumber: 1,
          title: 'Choisir votre abonnement',
          description: 'Sélectionnez l\'abonnement qui correspond à vos besoins.',
          requirements: ['Justificatif d\'âge', 'Photo d\'identité'],
          estimatedTime: '30 minutes',
        ),
        GuideStep(
          stepNumber: 2,
          title: 'Acheter votre carte',
          description: 'Achetez votre carte de transport dans un point de vente.',
          estimatedTime: '15 minutes',
          cost: '5-10€',
        ),
        GuideStep(
          stepNumber: 3,
          title: 'Charger votre abonnement',
          description: 'Chargez votre abonnement sur votre carte.',
          estimatedTime: '10 minutes',
          cost: '20-80€/mois',
        ),
        GuideStep(
          stepNumber: 4,
          title: 'Utiliser les transports',
          description: 'Apprenez à utiliser les transports en commun.',
          estimatedTime: '1 jour',
        ),
      ],
      createdAt: DateTime.now().subtract(const Duration(days: 8)),
      updatedAt: DateTime.now(),
    ),

    Guide(
      id: '7',
      title: 'Trouver un job étudiant',
      description: 'Conseils pour trouver un emploi étudiant en France.',
      shortDescription: 'Trouver un emploi étudiant',
      category: GuideCategory.work,
      difficulty: 'Moyen',
      estimatedDuration: '1-2 mois',
      tags: ['emploi', 'étudiant', 'job', 'CV'],
      imageUrl: 'assets/images/work-guide.jpg',
      steps: [
        GuideStep(
          stepNumber: 1,
          title: 'Préparer votre CV français',
          description: 'Adaptez votre CV au format français.',
          requirements: ['CV', 'Lettre de motivation', 'Photo professionnelle'],
          estimatedTime: '1 semaine',
        ),
        GuideStep(
          stepNumber: 2,
          title: 'Rechercher des offres',
          description: 'Utilisez les plateformes spécialisées pour étudiants.',
          requirements: ['Inscription sur les sites', 'Profil complet'],
          estimatedTime: '2-3 semaines',
        ),
        GuideStep(
          stepNumber: 3,
          title: 'Postuler aux offres',
          description: 'Envoyez vos candidatures aux offres qui vous intéressent.',
          estimatedTime: '1-2 semaines',
        ),
        GuideStep(
          stepNumber: 4,
          title: 'Passer les entretiens',
          description: 'Préparez-vous et passez les entretiens d\'embauche.',
          estimatedTime: '1-2 semaines',
        ),
      ],
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
      updatedAt: DateTime.now().subtract(const Duration(days: 1)),
    ),

    Guide(
      id: '8',
      title: 'Découvrir la culture française',
      description: 'Guide pour s\'intégrer et découvrir la culture française.',
      shortDescription: 'Découvrir la culture française',
      category: GuideCategory.culture,
      difficulty: 'Facile',
      estimatedDuration: 'Ongoing',
      tags: ['culture', 'intégration', 'français', 'traditions'],
      imageUrl: 'assets/images/culture-guide.jpg',
      steps: [
        GuideStep(
          stepNumber: 1,
          title: 'Apprendre les bases du français',
          description: 'Maîtrisez les expressions de base et la politesse française.',
          estimatedTime: '1-2 mois',
        ),
        GuideStep(
          stepNumber: 2,
          title: 'Découvrir les traditions',
          description: 'Apprenez les traditions et coutumes françaises.',
          estimatedTime: '1 mois',
        ),
        GuideStep(
          stepNumber: 3,
          title: 'Participer aux événements',
          description: 'Rejoignez des événements culturels et associatifs.',
          estimatedTime: 'Ongoing',
        ),
        GuideStep(
          stepNumber: 4,
          title: 'Se faire des amis français',
          description: 'Développez votre réseau social avec des Français.',
          estimatedTime: 'Ongoing',
        ),
      ],
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
      updatedAt: DateTime.now(),
    ),

    Guide(
      id: '9',
      title: 'Renouveler son titre de séjour',
      description: 'Processus de renouvellement du titre de séjour étudiant.',
      shortDescription: 'Renouveler son titre de séjour',
      category: GuideCategory.residence,
      difficulty: 'Moyen',
      estimatedDuration: '1-2 mois',
      tags: ['titre de séjour', 'renouvellement', 'préfecture', 'documents'],
      imageUrl: 'assets/images/residence-guide.jpg',
      steps: [
        GuideStep(
          stepNumber: 1,
          title: 'Vérifier les délais',
          description: 'Vérifiez que vous respectez les délais de renouvellement.',
          requirements: ['Titre de séjour actuel', 'Calendrier'],
          estimatedTime: '1 jour',
        ),
        GuideStep(
          stepNumber: 2,
          title: 'Prendre rendez-vous',
          description: 'Prenez rendez-vous en ligne à la préfecture.',
          requirements: ['Titre de séjour', 'Adresse email'],
          estimatedTime: '1 semaine',
        ),
        GuideStep(
          stepNumber: 3,
          title: 'Préparer le dossier',
          description: 'Rassemblez tous les documents nécessaires.',
          requirements: [
            'Titre de séjour actuel',
            'Passeport',
            'Attestation d\'inscription',
            'Justificatifs de ressources',
            'Justificatif de domicile',
            'Timbre fiscal'
          ],
          estimatedTime: '2-3 semaines',
          cost: '225€',
        ),
        GuideStep(
          stepNumber: 4,
          title: 'Dépôt du dossier',
          description: 'Déposez votre dossier à la préfecture.',
          estimatedTime: '1-2 heures',
        ),
      ],
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
      updatedAt: DateTime.now(),
    ),

    Guide(
      id: '10',
      title: 'Que faire en cas d\'urgence',
      description: 'Guide des numéros d\'urgence et procédures en cas de problème.',
      shortDescription: 'Numéros d\'urgence en France',
      category: GuideCategory.emergency,
      difficulty: 'Facile',
      estimatedDuration: '1 jour',
      tags: ['urgence', 'santé', 'police', 'pompiers'],
      imageUrl: 'assets/images/emergency-guide.jpg',
      steps: [
        GuideStep(
          stepNumber: 1,
          title: 'Mémoriser les numéros d\'urgence',
          description: 'Apprenez les numéros d\'urgence français.',
          requirements: ['15 (SAMU)', '17 (Police)', '18 (Pompiers)', '112 (Europe)'],
          estimatedTime: '30 minutes',
        ),
        GuideStep(
          stepNumber: 2,
          title: 'Connaître les procédures',
          description: 'Apprenez les procédures à suivre en cas d\'urgence.',
          estimatedTime: '1 heure',
        ),
        GuideStep(
          stepNumber: 3,
          title: 'Préparer vos documents',
          description: 'Gardez toujours vos documents importants à portée de main.',
          requirements: ['Carte vitale', 'Passeport', 'Assurance', 'Contacts d\'urgence'],
          estimatedTime: '30 minutes',
        ),
        GuideStep(
          stepNumber: 4,
          title: 'Connaître les lieux importants',
          description: 'Identifiez les hôpitaux, commissariats et pharmacies près de chez vous.',
          estimatedTime: '1 heure',
        ),
      ],
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      updatedAt: DateTime.now(),
    ),
  ];

  static List<Guide> getAllGuides() {
    return List.from(guides);
  }

  static List<Guide> getGuidesByCategory(GuideCategory category) {
    return guides.where((guide) => guide.category == category).toList();
  }

  static List<Guide> searchGuides(String query) {
    if (query.isEmpty) return getAllGuides();
    
    final lowercaseQuery = query.toLowerCase();
    return guides.where((guide) {
      return guide.title.toLowerCase().contains(lowercaseQuery) ||
             guide.description.toLowerCase().contains(lowercaseQuery) ||
             guide.tags.any((tag) => tag.toLowerCase().contains(lowercaseQuery)) ||
             guide.categoryDisplayName.toLowerCase().contains(lowercaseQuery);
    }).toList();
  }

  static List<GuideCategory> getAllCategories() {
    return GuideCategory.values;
  }
}
