import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import '../../domain/entities/checklist_item.dart';

class NotificationService {
  static NotificationService? _instance;
  static NotificationService get instance => _instance ??= NotificationService._();
  NotificationService._();

  final FlutterLocalNotificationsPlugin _notifications = FlutterLocalNotificationsPlugin();

  /// Initialise le service de notifications
  Future<void> initialize() async {
    // Initialiser timezone
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Europe/Paris'));

    // Configuration Android
    const AndroidInitializationSettings androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    
    // Configuration iOS
    const DarwinInitializationSettings iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notifications.initialize(
      settings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );

    // Demander les permissions
    await _requestPermissions();
  }

  /// Demande les permissions de notification
  Future<void> _requestPermissions() async {
    await _notifications
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    await _notifications
        .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  /// Gère le tap sur une notification
  void _onNotificationTapped(NotificationResponse response) {
    // Navigation vers la page appropriée selon l'ID de la notification
    print('Notification tapped: ${response.payload}');
  }

  /// Programme une notification de rappel pour un élément de checklist
  Future<void> scheduleReminder(ChecklistItem item) async {
    if (item.dueDate == null) return;

    // Programmer une notification 7 jours avant l'échéance
    final reminderDate = item.dueDate!.subtract(const Duration(days: 7));
    
    if (reminderDate.isAfter(DateTime.now())) {
      await _scheduleNotification(
        id: item.id.hashCode,
        title: 'Rappel: ${item.title}',
        body: 'Cette démarche est due dans 7 jours. N\'oubliez pas de la terminer !',
        scheduledDate: reminderDate,
        payload: 'checklist_${item.id}',
      );
    }

    // Programmer une notification le jour de l'échéance
    await _scheduleNotification(
      id: item.id.hashCode + 1000,
      title: 'URGENT: ${item.title}',
      body: 'Cette démarche est due aujourd\'hui !',
      scheduledDate: item.dueDate!,
      payload: 'checklist_${item.id}',
    );
  }

  /// Programme une notification personnalisée
  Future<void> _scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
    String? payload,
  }) async {
    await _notifications.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledDate, tz.local),
      NotificationDetails(
        android: AndroidNotificationDetails(
          'checklist_reminders',
          'Rappels de démarches',
          channelDescription: 'Notifications pour les rappels de démarches étudiantes',
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
      payload: payload,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  /// Annule une notification
  Future<void> cancelNotification(int id) async {
    await _notifications.cancel(id);
  }

  /// Annule toutes les notifications
  Future<void> cancelAllNotifications() async {
    await _notifications.cancelAll();
  }

  /// Programme des notifications pour tous les éléments de checklist
  Future<void> scheduleAllReminders(List<ChecklistItem> items) async {
    for (final item in items) {
      if (item.dueDate != null && item.status != ChecklistStatus.completed) {
        await scheduleReminder(item);
      }
    }
  }

  /// Programme une notification de bienvenue
  Future<void> scheduleWelcomeNotification() async {
    await _scheduleNotification(
      id: 9999,
      title: 'Bienvenue dans Démarches App !',
      body: 'Commencez par consulter votre checklist personnalisée.',
      scheduledDate: DateTime.now().add(const Duration(seconds: 5)),
      payload: 'welcome',
    );
  }

  /// Programme une notification de progression
  Future<void> scheduleProgressNotification(int completedCount, int totalCount) async {
    if (completedCount == totalCount) {
      await _scheduleNotification(
        id: 9998,
        title: '🎉 Félicitations !',
        body: 'Vous avez terminé toutes vos démarches !',
        scheduledDate: DateTime.now().add(const Duration(seconds: 2)),
        payload: 'congratulations',
      );
    } else if (completedCount > 0 && completedCount % 3 == 0) {
      await _scheduleNotification(
        id: 9997,
        title: '👍 Bon travail !',
        body: 'Vous avez terminé $completedCount/$totalCount démarches. Continuez !',
        scheduledDate: DateTime.now().add(const Duration(seconds: 2)),
        payload: 'progress',
      );
    }
  }
}