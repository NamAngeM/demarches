class ServerException implements Exception {
  final String message;
  
  const ServerException({this.message = 'Erreur du serveur'});
  
  @override
  String toString() => 'ServerException: $message';
}

class NetworkException implements Exception {
  final String message;
  
  const NetworkException({this.message = 'Erreur de connexion'});
  
  @override
  String toString() => 'NetworkException: $message';
}

class CacheException implements Exception {
  final String message;
  
  const CacheException({this.message = 'Erreur de cache'});
  
  @override
  String toString() => 'CacheException: $message';
}

class ValidationException implements Exception {
  final String message;
  
  const ValidationException({this.message = 'Erreur de validation'});
  
  @override
  String toString() => 'ValidationException: $message';
}

class AuthException implements Exception {
  final String message;
  
  const AuthException({this.message = 'Erreur d\'authentification'});
  
  @override
  String toString() => 'AuthException: $message';
}
