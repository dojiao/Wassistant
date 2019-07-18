/// HTTP status code exception
class StatusCodeException implements Exception {
  /// HTTP status code
  int statusCode;

  /// Error message
  String message;

  /// Constructor
  StatusCodeException(this.statusCode, this.message);

  @override
  String toString() => 'Status code';
}
