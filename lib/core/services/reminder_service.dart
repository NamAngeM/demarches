import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import '../../domain/entities/guide.dart';
import '../../domain/entities/user_profile.dart';

class ReminderService {
  static final ReminderService _instance = ReminderService._internal();
  factory ReminderService() => _instance;
  ReminderService._internal();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications = FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;

  // Initialiser le service de rappels
  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      // Initialiser les timezones
      tz.initializeTimeZones();
      
      // Configurer les notifications locales
      await _initializeLocalNotifications();
      
      // Configurer Firebase Messaging
      await _configureFirebaseMessaging();
      
      _isInitialized = true;
    } catch (e) {
      print('Erreur lors de l\'initialisation du service de rappels: $e');
    }
  }

  // Initialiser les notifications locales
  Future<void> _initializeLocalNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await _localNotifications.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );
  }

  // Configurer Firebase Messaging
  Future<void> _configureFirebaseMessaging() async {
    // Demander les permissions
    await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );

    // Configurer les topics
    await _setupTopics();
  }

  // Configurer les topics
  Future<void> _setupTopics() async {
    await _firebaseMessaging.subscribeToTopic('all_users');
    await _firebaseMessaging.subscribeToTopic('reminders');
    await _firebaseMessaging.subscribeToTopic('guide_updates');
  }

  // Programmer un rappel pour un guide
  Future<void> scheduleGuideReminder({
    required String guideId,
    required String guideTitle,
    required DateTime reminderTime,
    required String userId,
    String? customMessage,
  }) async {
    try {
      final message = customMessage ?? 
          'N\'oubliez pas de continuer le guide "$guideTitle"';
      
      await _localNotifications.zonedSchedule(
        guideId.hashCode,
        'Rappel de guide',
        message,
        tz.TZDateTime.from(reminderTime, tz.local),
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'guide_reminders',
            'Rappels de guides',
            channelDescription: 'Rappels pour continuer vos guides',
            importance: Importance.high,
            priority: Priority.high,
            icon: '@mipmap/ic_launcher',
          ),
          iOS: DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        payload: json.encode({
          'type': 'guide_reminder',
          'guideId': guideId,
          'userId': userId,
        }),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      );
    } catch (e) {
      print('Erreur lors de la programmation du rappel: $e');
    }
  }

  // Programmer un rappel de progression
  Future<void> scheduleProgressReminder({
    required String guideId,
    required String guideTitle,
    required int currentStep,
    required int totalSteps,
    required String userId,
  }) async {
    try {
      final progressPercentage = (currentStep / totalSteps * 100).round();
      final message = 'Vous avez terminé $progressPercentage% du guide "$guideTitle". Continuez !';
      
      // Programmer le rappel pour dans 2 jours
      final reminderTime = DateTime.now().add(const Duration(days: 2));
      
      await _localNotifications.zonedSchedule(
        '${guideId}_progress_${DateTime.now().millisecondsSinceEpoch}'.hashCode,
        'Progression du guide',
        message,
        tz.TZDateTime.from(reminderTime, tz.local),
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'progress_reminders',
            'Rappels de progression',
            channelDescription: 'Rappels de progression des guides',
            importance: Importance.medium,
            priority: Priority.defaultPriority,
            icon: '@mipmap/ic_launcher',
          ),
          iOS: DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        payload: json.encode({
          'type': 'progress_reminder',
          'guideId': guideId,
          'userId': userId,
          'currentStep': currentStep,
          'totalSteps': totalSteps,
        }),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      );
    } catch (e) {
      print('Erreur lors de la programmation du rappel de progression: $e');
    }
  }

  // Programmer un rappel de démarche urgente
  Future<void> scheduleUrgentReminder({
    required String guideId,
    required String guideTitle,
    required DateTime deadline,
    required String userId,
  }) async {
    try {
      final daysUntilDeadline = deadline.difference(DateTime.now()).inDays;
      String message;
      
      if (daysUntilDeadline <= 0) {
        message = 'URGENT: Le délai pour "$guideTitle" est dépassé !';
      } else if (daysUntilDeadline == 1) {
        message = 'URGENT: Le délai pour "$guideTitle" expire demain !';
      } else if (daysUntilDeadline <= 3) {
        message = 'URGENT: Le délai pour "$guideTitle" expire dans $daysUntilDeadline jours !';
      } else {
        message = 'Rappel: Le délai pour "$guideTitle" expire dans $daysUntilDeadline jours';
      }
      
      await _localNotifications.zonedSchedule(
        '${guideId}_urgent_${DateTime.now().millisecondsSinceEpoch}'.hashCode,
        'Démarche urgente',
        message,
        tz.TZDateTime.from(deadline.subtract(const Duration(days: 1)), tz.local),
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'urgent_reminders',
            'Rappels urgents',
            channelDescription: 'Rappels pour les démarches urgentes',
            importance: Importance.max,
            priority: Priority.high,
            icon: '@mipmap/ic_launcher',
            color: Colors.red,
          ),
          iOS: DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        payload: json.encode({
          'type': 'urgent_reminder',
          'guideId': guideId,
          'userId': userId,
          'deadline': deadline.toIso8601String(),
        }),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      );
    } catch (e) {
      print('Erreur lors de la programmation du rappel urgent: $e');
    }
  }

  // Programmer un rappel hebdomadaire
  Future<void> scheduleWeeklyReminder({
    required String userId,
    required UserProfile profile,
  }) async {
    try {
      final message = _generateWeeklyReminderMessage(profile);
      
      // Programmer pour chaque dimanche à 10h
      final now = DateTime.now();
      final nextSunday = now.add(Duration(days: (7 - now.weekday) % 7));
      final reminderTime = DateTime(nextSunday.year, nextSunday.month, nextSunday.day, 10, 0);
      
      await _localNotifications.zonedSchedule(
        'weekly_reminder_$userId'.hashCode,
        'Rappel hebdomadaire',
        message,
        tz.TZDateTime.from(reminderTime, tz.local),
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'weekly_reminders',
            'Rappels hebdomadaires',
            channelDescription: 'Rappels hebdomadaires personnalisés',
            importance: Importance.medium,
            priority: Priority.defaultPriority,
            icon: '@mipmap/ic_launcher',
          ),
          iOS: DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        payload: json.encode({
          'type': 'weekly_reminder',
          'userId': userId,
        }),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      );
    } catch (e) {
      print('Erreur lors de la programmation du rappel hebdomadaire: $e');
    }
  }

  // Générer un message de rappel hebdomadaire personnalisé
  String _generateWeeklyReminderMessage(UserProfile profile) {
    final messages = [
      'Bonjour ${profile.displayName} ! Comment se passent vos démarches cette semaine ?',
      'N\'oubliez pas de consulter vos guides cette semaine, ${profile.displayName} !',
      '${profile.displayName}, avez-vous avancé sur vos démarches cette semaine ?',
      'Rappel hebdomadaire : continuez vos démarches, ${profile.displayName} !',
    ];
    
    return messages[DateTime.now().day % messages.length];
  }

  // Programmer un rappel de nouveau guide
  Future<void> scheduleNewGuideNotification({
    required String guideId,
    required String guideTitle,
    required String category,
    required List<String> userIds,
  }) async {
    try {
      final message = 'Nouveau guide disponible : "$guideTitle" ($category)';
      
      // Envoyer une notification push à tous les utilisateurs
      await _firebaseMessaging.sendToTopic(
        'new_guides',
        data: {
          'type': 'new_guide',
          'guideId': guideId,
          'title': guideTitle,
          'category': category,
        },
        notification: RemoteNotification(
          title: 'Nouveau guide disponible !',
          body: message,
        ),
      );
    } catch (e) {
      print('Erreur lors de l\'envoi de la notification de nouveau guide: $e');
    }
  }

  // Annuler un rappel
  Future<void> cancelReminder(int notificationId) async {
    try {
      await _localNotifications.cancel(notificationId);
    } catch (e) {
      print('Erreur lors de l\'annulation du rappel: $e');
    }
  }

  // Annuler tous les rappels d'un guide
  Future<void> cancelGuideReminders(String guideId) async {
    try {
      await _localNotifications.cancel(guideId.hashCode);
    } catch (e) {
      print('Erreur lors de l\'annulation des rappels du guide: $e');
    }
  }

  // Annuler tous les rappels
  Future<void> cancelAllReminders() async {
    try {
      await _localNotifications.cancelAll();
    } catch (e) {
      print('Erreur lors de l\'annulation de tous les rappels: $e');
    }
  }

  // Obtenir les rappels programmés
  Future<List<PendingNotificationRequest>> getPendingReminders() async {
    try {
      return await _localNotifications.pendingNotificationRequests();
    } catch (e) {
      print('Erreur lors de la récupération des rappels: $e');
      return [];
    }
  }

  // Gérer le tap sur une notification
  void _onNotificationTapped(NotificationResponse response) {
    try {
      final payload = json.decode(response.payload ?? '{}');
      final type = payload['type'] as String?;
      
      switch (type) {
        case 'guide_reminder':
          _handleGuideReminderTapped(payload);
          break;
        case 'progress_reminder':
          _handleProgressReminderTapped(payload);
          break;
        case 'urgent_reminder':
          _handleUrgentReminderTapped(payload);
          break;
        case 'weekly_reminder':
          _handleWeeklyReminderTapped(payload);
          break;
        case 'new_guide':
          _handleNewGuideTapped(payload);
          break;
      }
    } catch (e) {
      print('Erreur lors du traitement du tap sur notification: $e');
    }
  }

  // Gérer le tap sur un rappel de guide
  void _handleGuideReminderTapped(Map<String, dynamic> payload) {
    final guideId = payload['guideId'] as String?;
    if (guideId != null) {
      // TODO: Naviguer vers le guide
      print('Navigation vers le guide: $guideId');
    }
  }

  // Gérer le tap sur un rappel de progression
  void _handleProgressReminderTapped(Map<String, dynamic> payload) {
    final guideId = payload['guideId'] as String?;
    if (guideId != null) {
      // TODO: Naviguer vers le guide
      print('Navigation vers le guide: $guideId');
    }
  }

  // Gérer le tap sur un rappel urgent
  void _handleUrgentReminderTapped(Map<String, dynamic> payload) {
    final guideId = payload['guideId'] as String?;
    if (guideId != null) {
      // TODO: Naviguer vers le guide avec priorité
      print('Navigation urgente vers le guide: $guideId');
    }
  }

  // Gérer le tap sur un rappel hebdomadaire
  void _handleWeeklyReminderTapped(Map<String, dynamic> payload) {
    final userId = payload['userId'] as String?;
    if (userId != null) {
      // TODO: Naviguer vers le tableau de bord
      print('Navigation vers le tableau de bord pour: $userId');
    }
  }

  // Gérer le tap sur une notification de nouveau guide
  void _handleNewGuideTapped(Map<String, dynamic> payload) {
    final guideId = payload['guideId'] as String?;
    if (guideId != null) {
      // TODO: Naviguer vers le nouveau guide
      print('Navigation vers le nouveau guide: $guideId');
    }
  }

  // Programmer des rappels intelligents basés sur le profil
  Future<void> scheduleSmartReminders(UserProfile profile) async {
    try {
      // Rappel hebdomadaire
      await scheduleWeeklyReminder(userId: profile.id, profile: profile);
      
      // Rappels basés sur le niveau d'expérience
      if (profile.level == UserLevel.beginner) {
        // Rappels plus fréquents pour les débutants
        await _scheduleBeginnerReminders(profile);
      } else if (profile.level == UserLevel.advanced) {
        // Rappels moins fréquents pour les avancés
        await _scheduleAdvancedReminders(profile);
      }
      
    } catch (e) {
      print('Erreur lors de la programmation des rappels intelligents: $e');
    }
  }

  // Programmer des rappels pour les débutants
  Future<void> _scheduleBeginnerReminders(UserProfile profile) async {
    // Rappel quotidien pour les premiers jours
    for (int i = 1; i <= 7; i++) {
      final reminderTime = DateTime.now().add(Duration(days: i, hours: 9));
      await _localNotifications.zonedSchedule(
        'beginner_reminder_${profile.id}_$i'.hashCode,
        'Rappel quotidien',
        'N\'oubliez pas de consulter vos guides aujourd\'hui !',
        tz.TZDateTime.from(reminderTime, tz.local),
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'beginner_reminders',
            'Rappels débutants',
            channelDescription: 'Rappels pour les utilisateurs débutants',
            importance: Importance.medium,
            priority: Priority.defaultPriority,
            icon: '@mipmap/ic_launcher',
          ),
        ),
        payload: json.encode({
          'type': 'beginner_reminder',
          'userId': profile.id,
        }),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      );
    }
  }

  // Programmer des rappels pour les utilisateurs avancés
  Future<void> _scheduleAdvancedReminders(UserProfile profile) async {
    // Rappel hebdomadaire uniquement
    await scheduleWeeklyReminder(userId: profile.id, profile: profile);
  }
}
