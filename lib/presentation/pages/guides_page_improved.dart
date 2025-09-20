import 'package:flutter/material.dart';

class GuidesPage extends StatelessWidget {
  const GuidesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.primary.withOpacity(0.1),
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: _buildGuidesList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Guides Complets',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tout ce que vous devez savoir pour réussir en France',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGuidesList() {
    final guides = _getGuides();
    
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: guides.length,
      itemBuilder: (context, index) {
        final guide = guides[index];
        return _buildGuideCard(guide);
      },
    );
  }

  Widget _buildGuideCard(Map<String, dynamic> guide) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: InkWell(
          onTap: () => _showGuideDetails(guide),
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: guide['color'].withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        guide['icon'],
                        color: guide['color'],
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            guide['title'],
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            guide['category'],
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (guide['isImportant'])
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'IMPORTANT',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  guide['description'],
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                    height: 1.4,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 16,
                      color: Colors.grey[500],
                    ),
                    const SizedBox(width: 4),
                    Text(
                      guide['duration'],
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[500],
                      ),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.grey[400],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _getGuides() {
    return [
      {
        'title': 'Inscription à l\'Université',
        'category': 'Éducation',
        'description': 'Guide complet pour s\'inscrire dans une université française, les documents requis, les délais et les procédures.',
        'icon': Icons.school,
        'color': Colors.blue,
        'duration': '15 min de lecture',
        'isImportant': true,
        'content': _getUniversityGuideContent(),
      },
      {
        'title': 'Trouver un Logement',
        'category': 'Logement',
        'description': 'Toutes les options de logement étudiant : CROUS, colocation, studio, et conseils pour éviter les arnaques.',
        'icon': Icons.home,
        'color': Colors.green,
        'duration': '12 min de lecture',
        'isImportant': true,
        'content': _getHousingGuideContent(),
      },
      {
        'title': 'Ouvrir un Compte Bancaire',
        'category': 'Administratif',
        'description': 'Comment ouvrir un compte bancaire en France, les documents nécessaires et les meilleures banques pour étudiants.',
        'icon': Icons.account_balance,
        'color': Colors.orange,
        'duration': '10 min de lecture',
        'isImportant': true,
        'content': _getBankingGuideContent(),
      },
      {
        'title': 'Système de Santé',
        'category': 'Santé',
        'description': 'Comprendre la sécurité sociale française, la mutuelle étudiante et comment se soigner en France.',
        'icon': Icons.health_and_safety,
        'color': Colors.red,
        'duration': '8 min de lecture',
        'isImportant': false,
        'content': _getHealthGuideContent(),
      },
      {
        'title': 'Transport Public',
        'category': 'Transport',
        'description': 'Navigo, TCL, RTM... Découvrez les transports en commun et les tarifs étudiants dans votre ville.',
        'icon': Icons.train,
        'color': Colors.purple,
        'duration': '6 min de lecture',
        'isImportant': false,
        'content': _getTransportGuideContent(),
      },
      {
        'title': 'Trouver un Job Étudiant',
        'category': 'Emploi',
        'description': 'Conseils pour trouver un emploi étudiant, les droits et obligations, et les meilleurs secteurs.',
        'icon': Icons.work,
        'color': Colors.teal,
        'duration': '9 min de lecture',
        'isImportant': false,
        'content': _getJobGuideContent(),
      },
    ];
  }

  void _showGuideDetails(Map<String, dynamic> guide) {
    // Dans une vraie app, on naviguerait vers une page détaillée
    print('Ouverture du guide: ${guide['title']}');
  }

  String _getUniversityGuideContent() {
    return '''
# Inscription à l'Université

## 1. Choisir votre université
- Consultez le site Campus France
- Vérifiez les spécialisations disponibles
- Regardez les classements et réputations

## 2. Documents requis
- Diplôme de fin d'études secondaires
- Relevés de notes
- Lettre de motivation
- CV
- Passeport/pièce d'identité

## 3. Procédure d'inscription
- Inscription en ligne sur Parcoursup
- Dépôt du dossier physique
- Entretien si nécessaire
- Paiement des frais d'inscription

## 4. Délais importants
- Janvier : Ouverture des candidatures
- Mars : Fin des candidatures
- Juin : Résultats d'admission
- Septembre : Inscription définitive
''';
  }

  String _getHousingGuideContent() {
    return '''
# Trouver un Logement Étudiant

## 1. Options disponibles
- Résidences CROUS (priorité aux boursiers)
- Colocation (partager avec d'autres étudiants)
- Studio meublé
- Chambre chez l'habitant

## 2. Où chercher
- Site du CROUS de votre région
- Leboncoin, PAP, SeLoger
- Groupes Facebook étudiants
- Agences immobilières

## 3. Documents nécessaires
- Garantie parentale ou bancaire
- Justificatifs de ressources
- Passeport/pièce d'identité
- Attestation d'inscription

## 4. Conseils sécurité
- Visitez toujours avant de signer
- Vérifiez l'identité du propriétaire
- Ne payez jamais sans contrat
- Méfiez-vous des offres trop alléchantes
''';
  }

  String _getBankingGuideContent() {
    return '''
# Ouvrir un Compte Bancaire

## 1. Banques recommandées
- BNP Paribas (offres étudiants)
- Société Générale
- Crédit Agricole
- LCL

## 2. Documents requis
- Passeport/pièce d'identité
- Attestation d'inscription
- Justificatif de domicile
- Garantie parentale

## 3. Avantages étudiants
- Frais réduits ou gratuits
- Carte bancaire gratuite
- Découvert autorisé
- Applications mobiles

## 4. Procédure
- Prendre rendez-vous
- Remplir le dossier
- Signature du contrat
- Réception de la carte (1-2 semaines)
''';
  }

  String _getHealthGuideContent() {
    return '''
# Système de Santé Français

## 1. Sécurité Sociale
- Inscription obligatoire
- Carte Vitale
- Remboursements automatiques

## 2. Mutuelle Étudiante
- Complémentaire santé
- Remboursement du ticket modérateur
- Tarifs préférentiels

## 3. Médecin traitant
- Choix libre
- Déclaration obligatoire
- Parcours de soins coordonnés

## 4. Urgences
- 15 : SAMU
- 18 : Pompiers
- 112 : Urgences européen
''';
  }

  String _getTransportGuideContent() {
    return '''
# Transport Public

## 1. Paris - Île-de-France
- Navigo (abonnement mensuel)
- Tarifs étudiants
- Zones 1-5

## 2. Autres villes
- TCL (Lyon)
- RTM (Marseille)
- TBM (Bordeaux)
- Tisseo (Toulouse)

## 3. Tarifs étudiants
- Réductions importantes
- Carte étudiante requise
- Abonnements mensuels

## 4. Applications utiles
- RATP (Paris)
- Citymapper
- Google Maps
''';
  }

  String _getJobGuideContent() {
    return '''
# Job Étudiant

## 1. Droits et obligations
- Maximum 964h/an
- Déclaration obligatoire
- Salaire minimum garanti

## 2. Secteurs populaires
- Restauration
- Vente
- Garde d'enfants
- Cours particuliers

## 3. Où chercher
- Pôle Emploi
- Sites spécialisés étudiants
- Bouche à oreille
- Jobboards

## 4. Conseils
- CV en français
- Lettre de motivation
- Préparer l'entretien
- Être flexible sur les horaires
''';
  }
}
