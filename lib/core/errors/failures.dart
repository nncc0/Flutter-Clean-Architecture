// ❌ Failures
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  final int? statusCode;
  
  const Failure(this.message, {this.statusCode});
  
  @override
  List<Object?> get props => [message, statusCode];
}

class ServerFailure extends Failure {
  const ServerFailure(String message, {int? statusCode}) : super(message, statusCode: statusCode);
}

class CacheFailure extends Failure {
  const CacheFailure(String message) : super(message);
}

class NetworkFailure extends Failure {
  const NetworkFailure(String message) : super(message);
}

class AuthenticationFailure extends Failure {
  const AuthenticationFailure(String message) : super(message);
}

class AuthorizationFailure extends Failure {
  const AuthorizationFailure(String message) : super(message);
}

class ValidationFailure extends Failure {
  final Map<String, List<String>>? errors;
  
  const ValidationFailure(String message, {this.errors}) : super(message);
  
  @override
  List<Object?> get props => [message, statusCode, errors];
}
