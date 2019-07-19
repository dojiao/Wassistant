import '../constants/keys.secret.dart';
import '../enums/api_type.dart';
import '../exceptions/http_exception.dart';
import '../models/player.dart';
import 'api_wrapper.dart';

/// Player service for networking requests
class PlayerService {
  /// Instance of api wrapper
  final _apiWrapper = ApiWrapper(ApiType.player);

  /// Returns a partial list of players
  Future<List<Player>> fetchPlayers(String search) async {
    var players = <Player>[];
    // fetch players
    var response = await _apiWrapper.get(
      '/list/',
      queryParameters: {
        'application_id': Keys.applicationId,
        'search': search,
      },
    );

    // convert to json object
    var json = Map<String, dynamic>.from(response.data);

    // if status field in json object is 'ok'
    if (json['status'] == 'ok') {
      // loop and convert each item to player model
      List<dynamic> parsedList = json['data'];
      for (var player in parsedList) {
        players.add(Player.fromJSON(player));
      }

      return players;
    } else {
      throw StatusCodeException(
        json['error']['code'] as int,
        json['error']['message'],
      );
    }
  }
}
