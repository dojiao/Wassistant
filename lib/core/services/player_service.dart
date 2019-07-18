import 'package:dio/dio.dart';

import '../constants/keys.secret.dart';
import '../exceptions/http_exception.dart';
import '../models/player.dart';

/// Player service for networking requests
class PlayerService {
  /// Instance of Dio
  final _dio = Dio(BaseOptions(
    baseUrl: 'https://api.worldofwarships.asia/wows/account',
    connectTimeout: 30 * 1000, // 30s
    receiveTimeout: 30 * 1000, // 30s
  ));

  /// Returns a partial list of players
  Future<List<Player>> fetchPlayers(String search) async {
    var players = <Player>[];
    // fetch players
    var response = await _dio.get(
      '/list/',
      queryParameters: {
        'application_id': Keys.applicationId,
        'search': search,
      },
    );

    // if status code is 200
    if (response.statusCode == 200) {
      // convert to json object
      var json = Map<String, dynamic>.from(response.data);

      // if status field in json object is 'ok'
      if (json['status'] == 'ok') {
        // loop and convert each item to player model
        List<dynamic> parsedList = json['data'];
        for (var player in parsedList) {
          players.add(Player.fromJSON(player));
        }

        // returns players
        return players;
      } else {
        throw StatusCodeException(json['error']['code'] as int);
      }
    } else {
      throw StatusCodeException(response.statusCode);
    }
  }
}
