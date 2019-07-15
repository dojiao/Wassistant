/// HTTP status code exception
class StatusCodeException implements Exception {
  /// HTTP status code
  int statusCode;

  /// Constructor
  StatusCodeException(this.statusCode);
}
