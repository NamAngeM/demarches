import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure([List properties = const <dynamic>[]]);
  
  @override
  List<Object> get props => [];
}

// General failures
class ServerFailure extends Failure {
  final String message;
  
  const ServerFailure({this.message = 'Erreur du serveur'});
  
  @override
  List<Object> get props => [message];
}

class NetworkFailure extends Failure {
  final String message;
  
  const NetworkFailure({this.message = 'Erreur de connexion'});
  
  @override
  List<Object> get props => [message];
}

class CacheFailure extends Failure {
  final String message;
  
  const CacheFailure({this.message = 'Erreur de cache'});
  
  @override
  List<Object> get props => [message];
}

class ValidationFailure extends Failure {
  final String message;
  
  const ValidationFailure({this.message = 'Erreur de validation'});
  
  @override
  List<Object> get props => [message];
}

class AuthFailure extends Failure {
  final String message;
  
  const AuthFailure({this.message = 'Erreur d\'authentification'});
  
  @override
  List<Object> get props => [message];
}
