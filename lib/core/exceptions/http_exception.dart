/// HTTP status code exception
class StatusCodeException implements Exception {
  /// HTTP status code
  int statusCode;

  /// Error message
  String message;

  /// Constructor
  StatusCodeException(this.statusCode, this.message);

  @override
  String toString() => '$statusCode: $message';
}

/// Network unreachable exception
class NetworkException implements Exception {
  @override
  String toString() => 'Network is unreachable.';
}

/// Unexpected exception
class UnexpectedException implements Exception {
  @override
  String toString() => 'An error has occurred. ';
}
