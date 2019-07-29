import '../constants/keys.secret.dart';
import '../enums/api_type.dart';
import '../mixins/http_helper.dart';
import '../models/player.dart';
import '../models/player_data.dart';
import 'api_wrapper.dart';

/// Player service for networking requests
class PlayerService with HttpHelper {
  /// Instance of api wrapper
  final _apiWrapper = ApiWrapper(ApiType.player);

  /// Returns a partial list of players by search query
  Future<List<Player>> fetchPlayers(String search) async {
    final players = <Player>[];
    // fetch players
    final response = await _apiWrapper.get(
      '/list/',
      queryParameters: {
        'application_id': Keys.applicationId,
        'search': search,
      },
    );

    // convert response to json object with validations
    final json = mappingWithValidation(response);

    // loop and convert each item to player model
    List<dynamic> parsedList = json['data'];
    for (final player in parsedList) {
      players.add(Player.fromJSON(player));
    }
    return players;
  }

  /// Returns player details by user id
  Future<PlayerData> fetchPlayerDetail(int accountId) async {
    // fetch players
    final response = await _apiWrapper.get(
      '/list/',
      queryParameters: {
        'application_id': Keys.applicationId,
        'account_id': accountId,
        'fields': '-statistics.club,-statistics.oper_solo,-statistics.pve',
      },
    );

    // convert response to json object with validations
    final json = mappingWithValidation(response);

    // convert json object to player detail model
    return PlayerData.fromJSON(json['data']);
  }
}
