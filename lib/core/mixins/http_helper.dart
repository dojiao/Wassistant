import 'package:dio/dio.dart';

import '../exceptions/http_exception.dart';

/// A mixin defined some helper methods are used to make HTTP requests
mixin HttpHelper {
  /// Returns an hashMap convert from [Response],
  /// and validate the value of status field in response.
  /// It will throw a [StatusCodeException] if status is invalid
  Map<String, dynamic> mappingWithValidation(Response response) {
    // convert response data to json object
    final json = Map<String, dynamic>.from(response.data);

    // validate the status field in response
    if (json['status'] != 'ok') {
      throw StatusCodeException(
        json['error']['code'] as int,
        json['error']['message'],
      );
    }
    return json;
  }
}
