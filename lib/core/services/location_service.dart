// Temporairement désactivé pour éviter les erreurs de compilation
// import 'dart:io';
// import 'package:geolocator/geolocator.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:permission_handler/permission_handler.dart';

class LocationService {
  static LocationService? _instance;
  static LocationService get instance => _instance ??= LocationService._();
  LocationService._();

  dynamic _currentPosition;
  String? _currentCity;
  String? _currentCountry;

  dynamic get currentPosition => _currentPosition;
  String? get currentCity => _currentCity;
  String? get currentCountry => _currentCountry;

  /// Demande les permissions de localisation (temporairement désactivé)
  Future<bool> requestLocationPermission() async {
    // Temporairement désactivé
    return false;
  }

  /// Vérifie si les permissions de localisation sont accordées (temporairement désactivé)
  Future<bool> isLocationPermissionGranted() async {
    // Temporairement désactivé
    return false;
  }

  /// Obtient la position actuelle de l'utilisateur (temporairement désactivé)
  Future<dynamic> getCurrentPosition() async {
    // Temporairement désactivé - retourne null
    return null;
  }

  /// Obtient l'adresse à partir des coordonnées GPS (temporairement désactivé)
  Future<void> _getAddressFromPosition(dynamic position) async {
    // Temporairement désactivé
  }

  /// Obtient les services locaux basés sur la ville actuelle
  Map<String, dynamic> getLocalServices() {
    if (_currentCity == null) {
      return _getDefaultServices();
    }

    // Services spécifiques par ville
    switch (_currentCity!.toLowerCase()) {
      case 'paris':
        return _getParisServices();
      case 'lyon':
        return _getLyonServices();
      case 'marseille':
        return _getMarseilleServices();
      case 'toulouse':
        return _getToulouseServices();
      case 'nice':
        return _getNiceServices();
      case 'nantes':
        return _getNantesServices();
      case 'strasbourg':
        return _getStrasbourgServices();
      case 'montpellier':
        return _getMontpellierServices();
      case 'bordeaux':
        return _getBordeauxServices();
      case 'lille':
        return _getLilleServices();
      default:
        return _getDefaultServices();
    }
  }

  Map<String, dynamic> _getParisServices() {
    return {
      'city': 'Paris',
      'prefecture': {
        'name': 'Préfecture de Paris',
        'address': '5 rue Lobau, 75004 Paris',
        'phone': '01 53 71 40 00',
        'hours': 'Lun-Ven: 8h30-16h30',
        'website': 'https://www.prefecturedepolice.interieur.gouv.fr/',
      },
      'transport': {
        'company': 'RATP',
        'website': 'https://www.ratp.fr/',
        'studentCard': 'Pass Navigo Étudiant',
        'price': '350€/an',
      },
      'universities': [
        'Sorbonne Université',
        'Université Paris 1 Panthéon-Sorbonne',
        'Université Paris 2 Panthéon-Assas',
        'Université Paris 3 Sorbonne Nouvelle',
        'Université Paris 4 Sorbonne',
        'Université Paris 5 Descartes',
        'Université Paris 6 Pierre et Marie Curie',
        'Université Paris 7 Diderot',
        'Université Paris 8 Vincennes-Saint-Denis',
        'Université Paris 9 Dauphine',
        'Université Paris 10 Nanterre',
        'Université Paris 11 Orsay',
        'Université Paris 12 Créteil',
        'Université Paris 13 Villetaneuse',
      ],
      'crous': {
        'name': 'CROUS de Paris',
        'address': '39 avenue Georges Bernanos, 75005 Paris',
        'phone': '01 40 51 37 00',
        'website': 'https://www.crous-paris.fr/',
      },
      'emergencyContacts': {
        'police': '17',
        'samu': '15',
        'pompiers': '18',
        'urgences': '112',
      },
    };
  }

  Map<String, dynamic> _getLyonServices() {
    return {
      'city': 'Lyon',
      'prefecture': {
        'name': 'Préfecture du Rhône',
        'address': '106 rue de la République, 69002 Lyon',
        'phone': '04 72 10 30 30',
        'hours': 'Lun-Ven: 8h30-16h30',
        'website': 'https://www.rhone.gouv.fr/',
      },
      'transport': {
        'company': 'TCL',
        'website': 'https://www.tcl.fr/',
        'studentCard': 'Carte TCL Étudiant',
        'price': '25€/mois',
      },
      'universities': [
        'Université Claude Bernard Lyon 1',
        'Université Lumière Lyon 2',
        'Université Jean Moulin Lyon 3',
        'École Normale Supérieure de Lyon',
        'INSA Lyon',
        'École Centrale de Lyon',
      ],
      'crous': {
        'name': 'CROUS de Lyon',
        'address': '59 rue de la Madeleine, 69007 Lyon',
        'phone': '04 72 80 20 20',
        'website': 'https://www.crous-lyon.fr/',
      },
      'emergencyContacts': {
        'police': '17',
        'samu': '15',
        'pompiers': '18',
        'urgences': '112',
      },
    };
  }

  Map<String, dynamic> _getMarseilleServices() {
    return {
      'city': 'Marseille',
      'prefecture': {
        'name': 'Préfecture des Bouches-du-Rhône',
        'address': '52 avenue de Saint-Just, 13004 Marseille',
        'phone': '04 91 39 80 00',
        'hours': 'Lun-Ven: 8h30-16h30',
        'website': 'https://www.bouches-du-rhone.gouv.fr/',
      },
      'transport': {
        'company': 'RTM',
        'website': 'https://www.rtm.fr/',
        'studentCard': 'Carte RTM Étudiant',
        'price': '20€/mois',
      },
      'universities': [
        'Aix-Marseille Université',
        'Université de la Méditerranée',
        'École Centrale de Marseille',
        'KEDGE Business School',
      ],
      'crous': {
        'name': 'CROUS d\'Aix-Marseille',
        'address': '3 avenue Robert Schuman, 13100 Aix-en-Provence',
        'phone': '04 42 93 90 00',
        'website': 'https://www.crous-aix-marseille.fr/',
      },
      'emergencyContacts': {
        'police': '17',
        'samu': '15',
        'pompiers': '18',
        'urgences': '112',
      },
    };
  }

  Map<String, dynamic> _getToulouseServices() {
    return {
      'city': 'Toulouse',
      'prefecture': {
        'name': 'Préfecture de la Haute-Garonne',
        'address': '1 place du Capitole, 31000 Toulouse',
        'phone': '05 34 45 34 45',
        'hours': 'Lun-Ven: 8h30-16h30',
        'website': 'https://www.haute-garonne.gouv.fr/',
      },
      'transport': {
        'company': 'Tisséo',
        'website': 'https://www.tisseo.fr/',
        'studentCard': 'Carte Tisséo Étudiant',
        'price': '22€/mois',
      },
      'universities': [
        'Université Toulouse 1 Capitole',
        'Université Toulouse 2 Jean Jaurès',
        'Université Toulouse 3 Paul Sabatier',
        'INSA Toulouse',
        'École Nationale Supérieure d\'Architecture de Toulouse',
      ],
      'crous': {
        'name': 'CROUS de Toulouse',
        'address': '2 rue du Taur, 31000 Toulouse',
        'phone': '05 61 12 70 00',
        'website': 'https://www.crous-toulouse.fr/',
      },
      'emergencyContacts': {
        'police': '17',
        'samu': '15',
        'pompiers': '18',
        'urgences': '112',
      },
    };
  }

  Map<String, dynamic> _getNiceServices() {
    return {
      'city': 'Nice',
      'prefecture': {
        'name': 'Préfecture des Alpes-Maritimes',
        'address': '1 rue de la Préfecture, 06000 Nice',
        'phone': '04 93 72 20 00',
        'hours': 'Lun-Ven: 8h30-16h30',
        'website': 'https://www.alpes-maritimes.gouv.fr/',
      },
      'transport': {
        'company': 'Lignes d\'Azur',
        'website': 'https://www.lignesdazur.com/',
        'studentCard': 'Carte Lignes d\'Azur Étudiant',
        'price': '18€/mois',
      },
      'universities': [
        'Université Côte d\'Azur',
        'Université Nice Sophia Antipolis',
        'SKEMA Business School',
        'EDHEC Business School',
      ],
      'crous': {
        'name': 'CROUS de Nice',
        'address': '2 avenue des Diables Bleus, 06300 Nice',
        'phone': '04 93 97 22 00',
        'website': 'https://www.crous-nice.fr/',
      },
      'emergencyContacts': {
        'police': '17',
        'samu': '15',
        'pompiers': '18',
        'urgences': '112',
      },
    };
  }

  Map<String, dynamic> _getNantesServices() {
    return {
      'city': 'Nantes',
      'prefecture': {
        'name': 'Préfecture de Loire-Atlantique',
        'address': '6 rue de la Houssinière, 44000 Nantes',
        'phone': '02 40 41 20 20',
        'hours': 'Lun-Ven: 8h30-16h30',
        'website': 'https://www.loire-atlantique.gouv.fr/',
      },
      'transport': {
        'company': 'TAN',
        'website': 'https://www.tan.fr/',
        'studentCard': 'Carte TAN Étudiant',
        'price': '20€/mois',
      },
      'universities': [
        'Université de Nantes',
        'École Centrale de Nantes',
        'Audencia Business School',
        'École des Mines de Nantes',
      ],
      'crous': {
        'name': 'CROUS de Nantes',
        'address': '2 rue de la Houssinière, 44000 Nantes',
        'phone': '02 40 37 10 00',
        'website': 'https://www.crous-nantes.fr/',
      },
      'emergencyContacts': {
        'police': '17',
        'samu': '15',
        'pompiers': '18',
        'urgences': '112',
      },
    };
  }

  Map<String, dynamic> _getStrasbourgServices() {
    return {
      'city': 'Strasbourg',
      'prefecture': {
        'name': 'Préfecture du Bas-Rhin',
        'address': '5 rue de la Nuée Bleue, 67000 Strasbourg',
        'phone': '03 88 21 60 00',
        'hours': 'Lun-Ven: 8h30-16h30',
        'website': 'https://www.bas-rhin.gouv.fr/',
      },
      'transport': {
        'company': 'CTS',
        'website': 'https://www.cts-strasbourg.eu/',
        'studentCard': 'Carte CTS Étudiant',
        'price': '23€/mois',
      },
      'universities': [
        'Université de Strasbourg',
        'INSA Strasbourg',
        'École Nationale d\'Administration',
        'EM Strasbourg Business School',
      ],
      'crous': {
        'name': 'CROUS de Strasbourg',
        'address': '1 quai du Maire Dietrich, 67000 Strasbourg',
        'phone': '03 88 15 40 00',
        'website': 'https://www.crous-strasbourg.fr/',
      },
      'emergencyContacts': {
        'police': '17',
        'samu': '15',
        'pompiers': '18',
        'urgences': '112',
      },
    };
  }

  Map<String, dynamic> _getMontpellierServices() {
    return {
      'city': 'Montpellier',
      'prefecture': {
        'name': 'Préfecture de l\'Hérault',
        'address': '34 cours Gambetta, 34000 Montpellier',
        'phone': '04 67 61 61 61',
        'hours': 'Lun-Ven: 8h30-16h30',
        'website': 'https://www.herault.gouv.fr/',
      },
      'transport': {
        'company': 'TAM',
        'website': 'https://www.tam-voyages.com/',
        'studentCard': 'Carte TAM Étudiant',
        'price': '19€/mois',
      },
      'universities': [
        'Université de Montpellier',
        'Université Paul-Valéry Montpellier 3',
        'École Nationale Supérieure de Chimie de Montpellier',
        'Montpellier Business School',
      ],
      'crous': {
        'name': 'CROUS de Montpellier',
        'address': '2 rue de l\'École de Pharmacie, 34000 Montpellier',
        'phone': '04 67 41 50 00',
        'website': 'https://www.crous-montpellier.fr/',
      },
      'emergencyContacts': {
        'police': '17',
        'samu': '15',
        'pompiers': '18',
        'urgences': '112',
      },
    };
  }

  Map<String, dynamic> _getBordeauxServices() {
    return {
      'city': 'Bordeaux',
      'prefecture': {
        'name': 'Préfecture de la Gironde',
        'address': '1 esplanade Charles de Gaulle, 33000 Bordeaux',
        'phone': '05 56 90 60 60',
        'hours': 'Lun-Ven: 8h30-16h30',
        'website': 'https://www.gironde.gouv.fr/',
      },
      'transport': {
        'company': 'TBM',
        'website': 'https://www.infotbm.com/',
        'studentCard': 'Carte TBM Étudiant',
        'price': '21€/mois',
      },
      'universities': [
        'Université de Bordeaux',
        'Université Bordeaux Montaigne',
        'Bordeaux Sciences Agro',
        'KEDGE Business School',
      ],
      'crous': {
        'name': 'CROUS de Bordeaux',
        'address': '60 rue de la Benauge, 33000 Bordeaux',
        'phone': '05 56 33 80 00',
        'website': 'https://www.crous-bordeaux.fr/',
      },
      'emergencyContacts': {
        'police': '17',
        'samu': '15',
        'pompiers': '18',
        'urgences': '112',
      },
    };
  }

  Map<String, dynamic> _getLilleServices() {
    return {
      'city': 'Lille',
      'prefecture': {
        'name': 'Préfecture du Nord',
        'address': '12 rue Jean Sans Peur, 59000 Lille',
        'phone': '03 20 30 60 00',
        'hours': 'Lun-Ven: 8h30-16h30',
        'website': 'https://www.nord.gouv.fr/',
      },
      'transport': {
        'company': 'Transpole',
        'website': 'https://www.transpole.fr/',
        'studentCard': 'Carte Transpole Étudiant',
        'price': '24€/mois',
      },
      'universities': [
        'Université de Lille',
        'École Centrale de Lille',
        'SKEMA Business School',
        'EDHEC Business School',
      ],
      'crous': {
        'name': 'CROUS de Lille',
        'address': '2 rue de la Barre, 59000 Lille',
        'phone': '03 20 12 34 56',
        'website': 'https://www.crous-lille.fr/',
      },
      'emergencyContacts': {
        'police': '17',
        'samu': '15',
        'pompiers': '18',
        'urgences': '112',
      },
    };
  }

  Map<String, dynamic> _getDefaultServices() {
    return {
      'city': 'France',
      'prefecture': {
        'name': 'Préfecture de votre département',
        'address': 'Consultez le site de votre préfecture',
        'phone': 'Voir site web',
        'hours': 'Lun-Ven: 8h30-16h30',
        'website': 'https://www.service-public.fr/',
      },
      'transport': {
        'company': 'Transports locaux',
        'website': 'Consultez le site de votre ville',
        'studentCard': 'Carte étudiante locale',
        'price': 'Variable selon la ville',
      },
      'universities': [
        'Consultez le site de votre université',
      ],
      'crous': {
        'name': 'CROUS local',
        'address': 'Consultez le site du CROUS',
        'phone': 'Voir site web',
        'website': 'https://www.crous.fr/',
      },
      'emergencyContacts': {
        'police': '17',
        'samu': '15',
        'pompiers': '18',
        'urgences': '112',
      },
    };
  }
}
