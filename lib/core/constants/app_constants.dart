class AppConstants {
  // App Info
  static const String appName = 'Démarches App';
  static const String appVersion = '1.0.0';
  
  // API
  static const String baseUrl = 'https://api.example.com';
  static const Duration apiTimeout = Duration(seconds: 30);
  
  // Storage Keys
  static const String userTokenKey = 'user_token';
  static const String userDataKey = 'user_data';
  static const String themeKey = 'theme_mode';
  
  // Firebase Collections
  static const String usersCollection = 'users';
  static const String demarchesCollection = 'demarches';
  
  // Error Messages
  static const String networkErrorMessage = 'Vérifiez votre connexion internet';
  static const String serverErrorMessage = 'Erreur du serveur, veuillez réessayer';
  static const String unknownErrorMessage = 'Une erreur inattendue s\'est produite';
}
