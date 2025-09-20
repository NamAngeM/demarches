import '../../domain/entities/tip.dart';

class TipsAndTricksService {
  static Map<String, List<Tip>> getTipsByCategory() {
    final now = DateTime.now();
    return {
      'general': [
        Tip(
          id: '1',
          title: 'Préparez vos documents à l\'avance',
          description: 'Rassemblez tous vos documents officiels (passeport, diplômes, etc.) avant de commencer vos démarches.',
          category: TipCategory.general,
          isImportant: true,
          createdAt: now,
          updatedAt: now,
        ),
        Tip(
          id: '2',
          title: 'Apprenez quelques mots de français',
          description: 'Même un niveau basique vous aidera dans vos interactions quotidiennes.',
          category: TipCategory.general,
          isImportant: false,
          createdAt: now,
          updatedAt: now,
        ),
      ],
      'visa': [
        Tip(
          id: '3',
          title: 'Vérifiez les délais de traitement',
          description: 'Les visas étudiants peuvent prendre 2-3 mois à être traités.',
          category: TipCategory.visa,
          isImportant: true,
          createdAt: now,
          updatedAt: now,
        ),
      ],
    };
  }
}