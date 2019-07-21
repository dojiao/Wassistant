import '../constants/keys.secret.dart';
import '../enums/api_type.dart';
import '../exceptions/http_exception.dart';
import '../models/player.dart';
import '../models/player_detail.dart';
import 'api_wrapper.dart';

/// Player service for networking requests
class PlayerService {
  /// Instance of api wrapper
  final _apiWrapper = ApiWrapper(ApiType.player);

  /// Returns a partial list of players by search query
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

    // convert response data to json object
    var json = Map<String, dynamic>.from(response.data);

    // validate the status of response
    _validateStatus(json);

    // loop and convert each item to player model
    List<dynamic> parsedList = json['data'];
    for (var player in parsedList) {
      players.add(Player.fromJSON(player));
    }
    return players;
  }

  /// Returns player details by user id
  Future<PlayerDetail> fetchPlayerDetail(int accountId) async {
    // fetch players
    var response = await _apiWrapper.get(
      '/list/',
      queryParameters: {
        'application_id': Keys.applicationId,
        'account_id': accountId,
        'fields': '-statistics.club,-statistics.oper_solo,-statistics.pve',
      },
    );

    // convert response data to json object
    var json = Map<String, dynamic>.from(response.data);

    // validate the status of response
    _validateStatus(json);

    // convert json object to player detail model
    return PlayerDetail.fromJSON(json['data']);
  }

  /// Throws a status code exception
  /// if the status field in response is not 'ok'
  _validateStatus(Map<String, dynamic> response) {
    if (response['status'] != 'ok') {
      throw StatusCodeException(
        response['error']['code'] as int,
        response['error']['message'],
      );
    }
  }
}
