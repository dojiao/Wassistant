import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';

import '../enums/api_type.dart';
import '../exceptions/http_exception.dart';

/// API wrapper class
class ApiWrapper {
  String _baseURL;

  /// Returns an customized Dio instance
  Dio get _dio => Dio(BaseOptions(
        baseUrl: _baseURL,
        connectTimeout: 60 * 1000,
        receiveTimeout: 60 * 1000,
      ));

  /// Create instance with specified type
  ApiWrapper(ApiType type) {
    switch (type) {
      // player
      case ApiType.players:
      case ApiType.player:
        _baseURL = 'https://api.worldofwarships.asia/wows/account';
        break;
      // clan
      case ApiType.clans:
      case ApiType.clan:
        _baseURL = 'https://api.worldofwarships.asia/wows/clans';
        break;
    }
  }

  /// Handy method to make http GET request with minimum error handling,
  /// which is a wrapper of  [Dio.get].
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic> queryParameters,
    Options options,
    CancelToken cancelToken,
    ProgressCallback onReceiveProgress,
  }) async {
    // if device not connected to any network
    var connectivity = await (Connectivity().checkConnectivity());
    if (connectivity == ConnectivityResult.none) {
      // throws the network unreachable exception
      throw NetworkException();
    }

    // otherwise, make HTTP get request
    var response = await _dio.get(
      path,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
    );

    // if status code in response is not 200
    if (response.statusCode != 200) {
      // throws the status code exception
      throw StatusCodeException(response.statusCode, response.statusMessage);
    }

    return response;
  }
}
