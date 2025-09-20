import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../domain/entities/guide.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications = FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;

  // Initialiser le service de notifications
  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      // Demander les permissions
      await _requestPermissions();

      // Initialiser les notifications locales
      await _initializeLocalNotifications();

      // Configurer Firebase Messaging
      await _configureFirebaseMessaging();

      _isInitialized = true;
    } catch (e) {
      print('Erreur lors de l\'initialisation des notifications: $e');
    }
  }

  // Demander les permissions
  Future<void> _requestPermissions() async {
    // Permission pour les notifications
    final notificationStatus = await Permission.notification.request();
    if (notificationStatus != PermissionStatus.granted) {
      print('Permission de notification refusée');
    }

    // Permission pour Firebase Messaging
    final messagingStatus = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );

    if (messagingStatus.authorizationStatus != AuthorizationStatus.authorized) {
      print('Permission Firebase Messaging refusée');
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
    // Gérer les messages en arrière-plan
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Gérer les messages en premier plan
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

    // Gérer les notifications tapées
    FirebaseMessaging.onMessageOpenedApp.listen(_handleNotificationOpened);

    // Obtenir le token FCM
    final token = await _firebaseMessaging.getToken();
    print('Token FCM: $token');
  }

  // Gérer les messages en premier plan
  Future<void> _handleForegroundMessage(RemoteMessage message) async {
    print('Message reçu en premier plan: ${message.notification?.title}');
    
    // Afficher une notification locale
    await _showLocalNotification(
      title: message.notification?.title ?? 'Nouvelle notification',
      body: message.notification?.body ?? 'Vous avez reçu une nouvelle notification',
      payload: message.data.toString(),
    );
  }

  // Gérer les notifications tapées
  void _handleNotificationOpened(RemoteMessage message) {
    print('Notification tapée: ${message.notification?.title}');
    // TODO: Naviguer vers la page appropriée
  }

  // Gérer les notifications locales tapées
  void _onNotificationTapped(NotificationResponse response) {
    print('Notification locale tapée: ${response.payload}');
    // TODO: Naviguer vers la page appropriée
  }

  // Afficher une notification locale
  Future<void> _showLocalNotification({
    required String title,
    required String body,
    String? payload,
  }) async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'demarches_app',
      'Démarches App',
      channelDescription: 'Notifications pour les guides et mises à jour',
      importance: Importance.high,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
    );

    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const NotificationDetails details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _localNotifications.show(
      DateTime.now().millisecondsSinceEpoch.remainder(100000),
      title,
      body,
      details,
      payload: payload,
    );
  }

  // Notifier un nouveau guide
  Future<void> notifyNewGuide(Guide guide) async {
    await _showLocalNotification(
      title: 'Nouveau guide disponible!',
      body: '${guide.title} - ${guide.categoryDisplayName}',
      payload: 'guide:${guide.id}',
    );
  }

  // Notifier des guides mis à jour
  Future<void> notifyUpdatedGuides(List<Guide> guides) async {
    if (guides.isEmpty) return;

    final title = guides.length == 1 
        ? 'Guide mis à jour'
        : '${guides.length} guides mis à jour';
    
    final body = guides.length == 1
        ? guides.first.title
        : 'Découvrez les dernières mises à jour';

    await _showLocalNotification(
      title: title,
      body: body,
      payload: 'guides_updated',
    );
  }

  // Notifier la progression d'un guide
  Future<void> notifyGuideProgress(String guideTitle, int percentage) async {
    if (percentage == 100) {
      await _showLocalNotification(
        title: 'Félicitations!',
        body: 'Vous avez terminé le guide "$guideTitle"',
        payload: 'guide_completed',
      );
    } else if (percentage % 25 == 0 && percentage > 0) {
      await _showLocalNotification(
        title: 'Progression du guide',
        body: 'Vous avez terminé $percentage% du guide "$guideTitle"',
        payload: 'guide_progress',
      );
    }
  }

  // Notifier un rappel de guide
  Future<void> notifyGuideReminder(String guideTitle) async {
    await _showLocalNotification(
      title: 'Rappel de guide',
      body: 'N\'oubliez pas de continuer le guide "$guideTitle"',
      payload: 'guide_reminder',
    );
  }

  // Programmer une notification de rappel
  Future<void> scheduleGuideReminder(String guideTitle, Duration delay) async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'demarches_app_reminders',
      'Rappels de guides',
      channelDescription: 'Rappels pour continuer vos guides',
      importance: Importance.defaultImportance,
      priority: Priority.defaultPriority,
    );

    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const NotificationDetails details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _localNotifications.zonedSchedule(
      DateTime.now().add(delay).millisecondsSinceEpoch.remainder(100000),
      'Rappel de guide',
      'N\'oubliez pas de continuer le guide "$guideTitle"',
      tz.TZDateTime.now(tz.local).add(delay),
      details,
      payload: 'guide_reminder',
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  // Annuler toutes les notifications programmées
  Future<void> cancelAllScheduledNotifications() async {
    await _localNotifications.cancelAll();
  }

  // Obtenir le token FCM
  Future<String?> getFCMToken() async {
    return await _firebaseMessaging.getToken();
  }

  // S'abonner à un topic
  Future<void> subscribeToTopic(String topic) async {
    await _firebaseMessaging.subscribeToTopic(topic);
  }

  // Se désabonner d'un topic
  Future<void> unsubscribeFromTopic(String topic) async {
    await _firebaseMessaging.unsubscribeFromTopic(topic);
  }

  // Configurer les topics par défaut
  Future<void> setupDefaultTopics() async {
    await subscribeToTopic('new_guides');
    await subscribeToTopic('guide_updates');
    await subscribeToTopic('general_announcements');
  }
}

// Gestionnaire de messages en arrière-plan
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Message en arrière-plan: ${message.notification?.title}');
  // TODO: Traiter le message en arrière-plan
}
