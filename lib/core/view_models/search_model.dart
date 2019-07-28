import 'package:flutter/widgets.dart';

import '../../locator.dart';
import '../models/clan.dart';
import '../models/player.dart';
import '../services/clan_service.dart';
import '../services/player_service.dart';

/// A layer contains players/clans searching logic
class SearchModel extends ChangeNotifier {
  /// List of clans
  var _clans = <Clan>[];

  /// List of players
  var _players = <Player>[];

  /// Instance of clan service
  final _clanService = locator<ClanService>();

  /// Instance of player service
  final _playerService = locator<PlayerService>();

  /// List of clans
  List<Clan> get clans => _clans;

  /// List of players
  List<Player> get players => _players;

  /// Fetch players with query string
  Future searchWith(String search) async {
    // fetch clans and players
    final results = await Future.wait([
      _clanService.fetchClans(search),
      _playerService.fetchPlayers(search),
    ]);

    // set property values
    for (final obj in results) {
      if (obj is List<Player>) {
        _players = obj;
      }
      if (obj is List<Clan>) {
        _clans = obj;
      }
    }

    // send notice
    notifyListeners();
  }
}
