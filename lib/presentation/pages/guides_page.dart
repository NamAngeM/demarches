import 'package:flutter/material.dart';

class GuidesPage extends StatelessWidget {
  const GuidesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Guides Complets'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionCard(
              context,
              '🇫🇷 DÉMARCHES AVANT L\'ARRIVÉE',
              [
                _buildGuideItem(
                  '1.1 Demande de visa étudiant',
                  'Étapes obligatoires et documents requis',
                  Icons.assignment,
                  Colors.blue,
                  () => _showVisaGuide(context),
                ),
                _buildGuideItem(
                  '1.2 Recherche de logement',
                  'Plateformes fiables et types de logements',
                  Icons.home,
                  Colors.green,
                  () => _showHousingGuide(context),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildSectionCard(
              context,
              '🏛️ DÉMARCHES ADMINISTRATIVES D\'ARRIVÉE',
              [
                _buildGuideItem(
                  '2.1 Validation visa et titre de séjour',
                  'Procédures OFII et renouvellement',
                  Icons.verified_user,
                  Colors.orange,
                  () => _showVisaValidationGuide(context),
                ),
                _buildGuideItem(
                  '2.2 Ouverture compte bancaire',
                  'Banques recommandées et services essentiels',
                  Icons.account_balance,
                  Colors.purple,
                  () => _showBankingGuide(context),
                ),
                _buildGuideItem(
                  '2.3 Couverture santé',
                  'Sécurité sociale et mutuelles étudiantes',
                  Icons.health_and_safety,
                  Colors.red,
                  () => _showHealthGuide(context),
                ),
                _buildGuideItem(
                  '2.4 Transports et abonnements',
                  'Transports en commun et SNCF',
                  Icons.train,
                  Colors.teal,
                  () => _showTransportGuide(context),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildSectionCard(
              context,
              '🎓 DÉMARCHES UNIVERSITAIRES',
              [
                _buildGuideItem(
                  '3.1 Inscription administrative',
                  'Documents et frais de scolarité 2024-2025',
                  Icons.school,
                  Colors.indigo,
                  () => _showUniversityGuide(context),
                ),
                _buildGuideItem(
                  '3.2 Équivalences diplômes',
                  'ENIC-NARIC et reconnaissance des diplômes',
                  Icons.workspace_premium,
                  Colors.amber,
                  () => _showDiplomaGuide(context),
                ),
                _buildGuideItem(
                  '3.3 Apprentissage français',
                  'Tests de niveau et cours FLE',
                  Icons.language,
                  Colors.pink,
                  () => _showFrenchGuide(context),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildSectionCard(
              context,
              '💰 AIDES FINANCIÈRES ET BOURSES',
              [
                _buildGuideItem(
                  '4.1 Bourses CROUS',
                  'Conditions et montants 2024-2025',
                  Icons.monetization_on,
                  Colors.green,
                  () => _showScholarshipGuide(context),
                ),
                _buildGuideItem(
                  '4.2 Aide au logement CAF',
                  'APL et ALS pour étudiants',
                  Icons.home_work,
                  Colors.blue,
                  () => _showHousingAidGuide(context),
                ),
                _buildGuideItem(
                  '4.3 Jobs étudiants',
                  'Droits au travail et secteurs qui recrutent',
                  Icons.work,
                  Colors.orange,
                  () => _showJobGuide(context),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard(BuildContext context, String title, List<Widget> children) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildGuideItem(String title, String description, IconData icon, Color color, VoidCallback onTap) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(description),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }

  void _showVisaGuide(BuildContext context) {
    _showDetailedGuide(
      context,
      'Demande de visa étudiant',
      [
        'Étapes obligatoires :',
        '• Inscription sur Campus France (pays concernés)',
        '• Acceptation dans un établissement français',
        '• Rendez-vous consulat/ambassade',
        '• Constitution du dossier visa',
        '',
        'Documents requis :',
        '• Passeport valide (6 mois minimum)',
        '• Photos d\'identité aux normes',
        '• Justificatifs de ressources (7 380€/an minimum)',
        '• Assurance santé internationale',
        '• Certificat de scolarité/diplômes',
        '• Lettre d\'acceptation de l\'établissement',
        '• Justificatif de logement ou attestation d\'hébergement',
        '',
        'Astuces :',
        '• Prendre RDV consulat 2-3 mois à l\'avance',
        '• Scanner tous les documents en haute qualité',
        '• Prévoir budget de 99-269€ selon le pays',
        '• Demander visa long séjour valant titre de séjour (VLS-TS)',
      ],
    );
  }

  void _showHousingGuide(BuildContext context) {
    _showDetailedGuide(
      context,
      'Recherche de logement à distance',
      [
        'Plateformes fiables :',
        '• CROUS (logement étudiant public)',
        '• Studapart (garantie étudiants étrangers)',
        '• Lokaviz (plateforme officielle)',
        '• PAP.fr, Leboncoin (avec précautions)',
        '',
        'Types de logements :',
        '• Résidence CROUS : 150-600€/mois, très demandé',
        '• Résidence privée étudiante : 400-800€/mois',
        '• Colocation : 300-600€/mois selon ville',
        '• Studio privé : 400-1200€/mois selon localisation',
        '• Chambre chez l\'habitant : 200-500€/mois',
        '',
        'Pièges à éviter :',
        '• Virements avant visite virtuelle',
        '• Annonces sans photos réelles',
        '• Propriétaires qui demandent Western Union',
        '• Prix anormalement bas pour la zone',
      ],
    );
  }

  void _showVisaValidationGuide(BuildContext context) {
    _showDetailedGuide(
      context,
      'Validation du visa et titre de séjour',
      [
        'Dans les 3 premiers mois :',
        '• Validation VLS-TS sur administration-etrangers-en-france.interieur.gouv.fr',
        '• Paiement taxe OFII (60€)',
        '• Réception vignette OFII par courrier',
        '',
        'Renouvellement titre de séjour :',
        '• Demande 2 mois avant expiration',
        '• RDV en préfecture via internet',
        '• Justificatifs de poursuite d\'études',
        '• Justificatifs de ressources actualisés',
      ],
    );
  }

  void _showBankingGuide(BuildContext context) {
    _showDetailedGuide(
      context,
      'Ouverture de compte bancaire',
      [
        'Banques étudiantes recommandées :',
        '• Crédit Agricole : Offre étudiants étrangers',
        '• BNP Paribas : Package international',
        '• Société Générale : Compte Welcome',
        '• Banques en ligne : Boursorama, Hello Bank',
        '',
        'Documents nécessaires :',
        '• Passeport + visa/titre de séjour',
        '• Justificatif de domicile récent',
        '• Certificat de scolarité',
        '• Justificatifs de revenus',
        '',
        'Services essentiels à demander :',
        '• Carte bancaire internationale',
        '• Virement SEPA (Europe)',
        '• Application mobile',
        '• Découvert autorisé étudiant',
        '• Assurance moyens de paiement',
      ],
    );
  }

  void _showHealthGuide(BuildContext context) {
    _showDetailedGuide(
      context,
      'Couverture santé obligatoire',
      [
        'Sécurité sociale étudiante :',
        '• Inscription automatique via établissement',
        '• Carte vitale sous 2-3 semaines',
        '• Droits ouverts rétroactivement',
        '',
        'Mutuelle étudiante (fortement recommandée) :',
        '• LMDE : Mutuelle étudiante historique',
        '• Emevia : Réseau mutuelles régionales',
        '• SMENO : Mutuelle étudiante nationale',
        '• Prix : 20-60€/mois selon garanties',
        '',
        'Médecin traitant :',
        '• Déclaration obligatoire dans les 6 mois',
        '• Remboursement optimal des consultations',
        '• Parcours de soins coordonnés',
      ],
    );
  }

  void _showTransportGuide(BuildContext context) {
    _showDetailedGuide(
      context,
      'Transports et abonnements',
      [
        'Transports en commun :',
        '• Tarifs étudiants : 30-50% de réduction',
        '• Île-de-France : Pass Navigo étudiant',
        '• Lyon : Abonnement TCL étudiant',
        '• Marseille : Carte RTM jeunes',
        '',
        'SNCF Connect :',
        '• Carte Avantage Jeune (49€/an)',
        '• 30% réduction sur tous les trains',
        '• Voyages dernière minute moins chers',
        '',
        'Vélos en libre-service :',
        '• Abonnements étudiants disponibles',
        '• Transport écologique et économique',
        '• Parfait pour trajets courts urbains',
      ],
    );
  }

  void _showUniversityGuide(BuildContext context) {
    _showDetailedGuide(
      context,
      'Inscription administrative',
      [
        'Documents universitaires :',
        '• Formulaire inscription complété',
        '• Photos d\'identité récentes',
        '• Diplômes traduits et certifiés',
        '• Relevés de notes apostillés',
        '• Certificat médical (parfois requis)',
        '',
        'Frais de scolarité 2024-2025 :',
        '• Étudiants UE : 170€ (Licence), 243€ (Master), 380€ (Doctorat)',
        '• Étudiants hors-UE : 2 770€ (Licence), 3 770€ (Master), 380€ (Doctorat)',
        '• Écoles privées : 3 000-15 000€/an',
      ],
    );
  }

  void _showDiplomaGuide(BuildContext context) {
    _showDetailedGuide(
      context,
      'Équivalences et reconnaissance de diplômes',
      [
        'ENIC-NARIC France :',
        '• Organisme officiel reconnaissance diplômes',
        '• Attestation comparabilité (70€)',
        '• Délai : 1-4 mois selon pays',
        '',
        'Équivalences disciplinaires :',
        '• Contact directement avec l\'établissement',
        '• Commission pédagogique spécialisée',
        '• Possibilité validation acquis (VAE)',
      ],
    );
  }

  void _showFrenchGuide(BuildContext context) {
    _showDetailedGuide(
      context,
      'Apprentissage du français (FLE)',
      [
        'Tests de niveau obligatoires :',
        '• TCF (Test Connaissance du Français)',
        '• DELF/DALF (diplômes officiels)',
        '• TEF (Test Évaluation de Français)',
        '',
        'Cours de français :',
        '• Universités : cours FLE intégrés',
        '• Alliance française : centres dans toutes les villes',
        '• CNED : formation à distance',
        '• Applications : Duolingo, Babbel, TV5 Monde',
        '',
        'Niveau requis par formation :',
        '• Licence : B2 minimum',
        '• Master : C1 recommandé',
        '• Doctorat : C1/C2 selon discipline',
      ],
    );
  }

  void _showScholarshipGuide(BuildContext context) {
    _showDetailedGuide(
      context,
      'Bourses sur critères sociaux (CROUS)',
      [
        'Conditions d\'éligibilité :',
        '• Âge maximum : 28 ans (35 ans reprise d\'études)',
        '• Assiduité aux cours et examens',
        '• Progression dans les études',
        '• Ressources familiales limitées',
        '',
        'Montants 2024-2025 :',
        '• Échelon 0 bis : 1 454€/an',
        '• Échelon 1 : 1 827€/an',
        '• Échelon 2 : 2 762€/an',
        '• Échelon 3 : 3 544€/an',
        '• Échelon 4 : 4 326€/an',
        '• Échelon 5 : 5 108€/an',
        '• Échelon 6 : 5 890€/an',
        '• Échelon 7 : 6 661€/an',
      ],
    );
  }

  void _showHousingAidGuide(BuildContext context) {
    _showDetailedGuide(
      context,
      'Aide au logement (CAF)',
      [
        'APL (Aide Personnalisée au Logement) :',
        '• Ouverture dossier CAF obligatoire',
        '• Montant selon ressources et loyer',
        '• Versement directement au propriétaire possible',
        '',
        'ALS (Allocation Logement Social) :',
        '• Alternative à l\'APL',
        '• Calcul selon barème national',
        '• Réduction loyer de 50-250€/mois',
        '',
        'Documents CAF requis :',
        '• Justificatif identité et séjour',
        '• Contrat de bail',
        '• Quittances de loyer',
        '• Relevés bancaires 3 derniers mois',
      ],
    );
  }

  void _showJobGuide(BuildContext context) {
    _showDetailedGuide(
      context,
      'Jobs étudiants autorisés',
      [
        'Droit au travail :',
        '• 964h/an maximum (20h/semaine)',
        '• Autorisation préfectorale si hors-UE',
        '• Salaire minimum : 11,65€/h brut (2024)',
        '',
        'Secteurs qui recrutent :',
        '• Restauration : serveur, équipier fast-food',
        '• Retail : vendeur, caissier, inventaire',
        '• Services : baby-sitting, cours particuliers',
        '• Numérique : data entry, modération contenu',
        '• Événementiel : hôtesse, distribution flyers',
        '',
        'Plateformes emploi étudiant :',
        '• JobAviz (CROUS)',
        '• Wizbii Jobs',
        '• StudentJob.fr',
        '• Indeed (filtre "étudiant")',
      ],
    );
  }

  void _showDetailedGuide(BuildContext context, String title, List<String> content) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: content.map((line) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Text(line),
              )).toList(),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Fermer'),
          ),
        ],
      ),
    );
  }
}
