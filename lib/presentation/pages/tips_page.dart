import 'package:flutter/material.dart';

class TipsPage extends StatefulWidget {
  const TipsPage({super.key});

  @override
  State<TipsPage> createState() => _TipsPageState();
}

class _TipsPageState extends State<TipsPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conseils & Astuces'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: const [
            Tab(text: 'Visa'),
            Tab(text: 'Logement'),
            Tab(text: 'Banque'),
            Tab(text: 'Santé'),
            Tab(text: 'Transport'),
            Tab(text: 'Université'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildVisaTips(),
          _buildHousingTips(),
          _buildBankingTips(),
          _buildHealthTips(),
          _buildTransportTips(),
          _buildUniversityTips(),
        ],
      ),
    );
  }

  Widget _buildVisaTips() {
    return _buildTipsList([
      _buildTipCard(
        'Prendre RDV consulat 2-3 mois à l\'avance',
        'Les créneaux sont très demandés, réservez tôt',
        Icons.schedule,
        Colors.red,
        true,
      ),
      _buildTipCard(
        'Scanner tous les documents en haute qualité',
        'Évitez les refus pour documents illisibles',
        Icons.scanner,
        Colors.orange,
        true,
      ),
      _buildTipCard(
        'Prévoir budget de 99-269€ selon le pays',
        'Les frais de visa varient selon votre pays d\'origine',
        Icons.euro,
        Colors.green,
        false,
      ),
      _buildTipCard(
        'Demander visa long séjour valant titre de séjour (VLS-TS)',
        'Plus pratique que le visa court séjour',
        Icons.verified_user,
        Colors.blue,
        true,
      ),
    ]);
  }

  Widget _buildHousingTips() {
    return _buildTipsList([
      _buildTipCard(
        'Utiliser CROUS en priorité',
        'Logements étudiants publics, prix attractifs',
        Icons.home,
        Colors.blue,
        true,
      ),
      _buildTipCard(
        'Éviter les virements avant visite virtuelle',
        'Signe d\'arnaque fréquent',
        Icons.warning,
        Colors.red,
        true,
      ),
      _buildTipCard(
        'Méfiez-vous des prix anormalement bas',
        'Si c\'est trop beau pour être vrai, c\'est suspect',
        Icons.attach_money,
        Colors.orange,
        false,
      ),
      _buildTipCard(
        'Préparer garant français ou caution Visale',
        'Nécessaire pour la plupart des locations',
        Icons.security,
        Colors.green,
        true,
      ),
    ]);
  }

  Widget _buildBankingTips() {
    return _buildTipsList([
      _buildTipCard(
        'Négocier gratuité des services étudiants',
        'Les banques offrent souvent des avantages étudiants',
        Icons.handshake,
        Colors.blue,
        false,
      ),
      _buildTipCard(
        'Activer paiements internationaux avant voyages',
        'Évitez les blocages de carte à l\'étranger',
        Icons.flight,
        Colors.orange,
        true,
      ),
      _buildTipCard(
        'Configurer alertes SMS pour sécurité',
        'Recevez des notifications de chaque transaction',
        Icons.notifications,
        Colors.green,
        false,
      ),
      _buildTipCard(
        'Garder toujours liquidités d\'urgence',
        'Avoir du cash en cas de problème de carte',
        Icons.money,
        Colors.red,
        true,
      ),
    ]);
  }

  Widget _buildHealthTips() {
    return _buildTipsList([
      _buildTipCard(
        'Déclarer médecin traitant dans les 6 mois',
        'Obligatoire pour un remboursement optimal',
        Icons.medical_services,
        Colors.red,
        true,
      ),
      _buildTipCard(
        'Souscrire mutuelle étudiante complémentaire',
        'Complète les remboursements de la sécurité sociale',
        Icons.health_and_safety,
        Colors.blue,
        true,
      ),
      _buildTipCard(
        'Mémoriser les numéros d\'urgence',
        '15 (SAMU), 17 (Police), 18 (Pompiers), 112 (Europe)',
        Icons.emergency,
        Colors.red,
        true,
      ),
      _buildTipCard(
        'Utiliser les services santé étudiants',
        'SUMPPS, BAPU, consultations gratuites',
        Icons.local_hospital,
        Colors.green,
        false,
      ),
    ]);
  }

  Widget _buildTransportTips() {
    return _buildTipsList([
      _buildTipCard(
        'Souscrire abonnement annuel transport',
        'Plus économique que les tickets unitaires',
        Icons.card_membership,
        Colors.blue,
        true,
      ),
      _buildTipCard(
        'Carte SNCF Avantage Jeune (49€/an)',
        '30% de réduction sur tous les trains',
        Icons.train,
        Colors.green,
        true,
      ),
      _buildTipCard(
        'Utiliser vélos en libre-service',
        'Écologique et économique pour trajets courts',
        Icons.pedal_bike,
        Colors.teal,
        false,
      ),
      _buildTipCard(
        'Télécharger Citymapper',
        'Application optimisée pour transports urbains',
        Icons.phone_android,
        Colors.purple,
        false,
      ),
    ]);
  }

  Widget _buildUniversityTips() {
    return _buildTipsList([
      _buildTipCard(
        'Utiliser méthode Cornell pour prise de notes',
        'Divisez la page en 3 zones pour une meilleure organisation',
        Icons.note,
        Colors.blue,
        false,
      ),
      _buildTipCard(
        'Technique Pomodoro pour concentration',
        '25 min travail / 5 min pause pour optimiser la productivité',
        Icons.timer,
        Colors.orange,
        false,
      ),
      _buildTipCard(
        'Rejoindre groupes d\'étude',
        'Apprentissage collaboratif et motivation mutuelle',
        Icons.group,
        Colors.green,
        true,
      ),
      _buildTipCard(
        'Utiliser heures de permanence enseignants',
        'Profitez des créneaux dédiés aux questions',
        Icons.person,
        Colors.purple,
        false,
      ),
    ]);
  }

  Widget _buildTipsList(List<Widget> tips) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: tips,
      ),
    );
  }

  Widget _buildTipCard(String title, String description, IconData icon, Color color, bool isImportant) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      if (isImportant)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            'IMPORTANT',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
