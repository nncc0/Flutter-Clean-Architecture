// 🚨 Custom Exceptions
class ServerException implements Exception {
  final String message;
  final int? statusCode;
  final Map<String, dynamic>? data;
  
  const ServerException(this.message, {this.statusCode, this.data});
  
  @override
  String toString() => 'ServerException: $message (Status: $statusCode)';
}

class CacheException implements Exception {
  final String message;
  const CacheException(this.message);
  
  @override
  String toString() => 'CacheException: $message';
}

class NetworkException implements Exception {
  final String message;
  const NetworkException(this.message);
  
  @override
  String toString() => 'NetworkException: $message';
}

class AuthenticationException implements Exception {
  final String message;
  const AuthenticationException(this.message);
  
  @override
  String toString() => 'AuthenticationException: $message';
}

class AuthorizationException implements Exception {
  final String message;
  const AuthorizationException(this.message);
  
  @override
  String toString() => 'AuthorizationException: $message';
}

class ValidationException implements Exception {
  final String message;
  final Map<String, List<String>>? errors;
  
  const ValidationException(this.message, {this.errors});
  
  @override
  String toString() => 'ValidationException: $message';
}
