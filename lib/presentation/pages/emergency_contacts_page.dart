import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyContactsPage extends StatelessWidget {
  const EmergencyContactsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts d\'Urgence'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildEmergencyCard(context),
            const SizedBox(height: 16),
            _buildMedicalCard(context),
            const SizedBox(height: 16),
            _buildAdministrativeCard(context),
            const SizedBox(height: 16),
            _buildStudentServicesCard(context),
            const SizedBox(height: 16),
            _buildConsularServicesCard(context),
          ],
        ),
      ),
    );
  }

  Widget _buildEmergencyCard(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.emergency, color: Colors.red, size: 28),
                const SizedBox(width: 12),
                const Text(
                  'Urgences',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildContactItem(
              context,
              'SAMU (Urgences médicales)',
              '15',
              Icons.local_hospital,
              Colors.red,
              'tel:15',
            ),
            _buildContactItem(
              context,
              'Police',
              '17',
              Icons.local_police,
              Colors.blue,
              'tel:17',
            ),
            _buildContactItem(
              context,
              'Pompiers',
              '18',
              Icons.fire_truck,
              Colors.orange,
              'tel:18',
            ),
            _buildContactItem(
              context,
              'Urgences européen',
              '112',
              Icons.public,
              Colors.green,
              'tel:112',
            ),
            _buildContactItem(
              context,
              'SMS urgence (sourds/malentendants)',
              '114',
              Icons.sms,
              Colors.purple,
              'sms:114',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMedicalCard(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.health_and_safety, color: Colors.green, size: 28),
                const SizedBox(width: 12),
                const Text(
                  'Santé',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildContactItem(
              context,
              'Violences faites aux femmes',
              '3919',
              Icons.female,
              Colors.pink,
              'tel:3919',
            ),
            _buildContactItem(
              context,
              'Suicide Écoute',
              '0 800 235 236',
              Icons.psychology,
              Colors.blue,
              'tel:0800235236',
            ),
            _buildContactItem(
              context,
              'Fil Santé Jeunes',
              '0 800 235 236',
              Icons.phone_in_talk,
              Colors.green,
              'tel:0800235236',
            ),
            _buildContactItem(
              context,
              'Médecin de garde',
              '116 117',
              Icons.medical_services,
              Colors.orange,
              'tel:116117',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAdministrativeCard(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.admin_panel_settings, color: Colors.blue, size: 28),
                const SizedBox(width: 12),
                const Text(
                  'Administratif',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildContactItem(
              context,
              'Préfecture de Police (Paris)',
              '01 53 71 40 00',
              Icons.location_city,
              Colors.blue,
              'tel:0153714000',
            ),
            _buildContactItem(
              context,
              'OFII (Office Français Immigration)',
              '01 53 71 40 00',
              Icons.assignment,
              Colors.orange,
              'tel:0153714000',
            ),
            _buildContactItem(
              context,
              'CAF (Caisse d\'Allocations Familiales)',
              '32 30',
              Icons.home_work,
              Colors.green,
              'tel:3230',
            ),
            _buildContactItem(
              context,
              'Défenseur des droits',
              '09 69 39 00 00',
              Icons.gavel,
              Colors.purple,
              'tel:0969390000',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStudentServicesCard(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.school, color: Colors.purple, size: 28),
                const SizedBox(width: 12),
                const Text(
                  'Services Étudiants',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildContactItem(
              context,
              'CROUS',
              '01 40 51 37 00',
              Icons.home,
              Colors.blue,
              'tel:0140513700',
            ),
            _buildContactItem(
              context,
              'SUMPPS (Service médical universitaire)',
              'Voir votre université',
              Icons.local_hospital,
              Colors.green,
              null,
            ),
            _buildContactItem(
              context,
              'BAPU (Consultation psychologique)',
              'Voir votre université',
              Icons.psychology,
              Colors.orange,
              null,
            ),
            _buildContactItem(
              context,
              'Planning familial',
              'Voir votre ville',
              Icons.family_restroom,
              Colors.pink,
              null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConsularServicesCard(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.flag, color: Colors.red, size: 28),
                const SizedBox(width: 12),
                const Text(
                  'Services Consulaires',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Consultez le site de votre ambassade/consulat pour les contacts spécifiques à votre pays.',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 12),
            _buildContactItem(
              context,
              'Ministère des Affaires étrangères',
              '01 43 17 43 17',
              Icons.public,
              Colors.blue,
              'tel:0143174317',
            ),
            _buildContactItem(
              context,
              'Site France Diplomatie',
              'diplomatie.gouv.fr',
              Icons.language,
              Colors.green,
              'https://diplomatie.gouv.fr',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactItem(
    BuildContext context,
    String title,
    String number,
    IconData icon,
    Color color,
    String? action,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: action != null ? () => _launchAction(action) : null,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(color: color.withOpacity(0.3)),
            borderRadius: BorderRadius.circular(8),
            color: action != null ? color.withOpacity(0.05) : Colors.grey.withOpacity(0.05),
          ),
          child: Row(
            children: [
              Icon(icon, color: color, size: 24),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      number,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              if (action != null)
                Icon(
                  action.startsWith('tel') ? Icons.phone : Icons.open_in_new,
                  color: color,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchAction(String action) async {
    final Uri uri = Uri.parse(action);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      print('Impossible de lancer: $action');
    }
  }
}
