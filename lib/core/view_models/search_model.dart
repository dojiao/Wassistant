import 'package:shared_preferences/shared_preferences.dart';

import '../../locator.dart';
import '../enums/view_state.dart';
import '../models/player.dart';
import '../services/player_service.dart';
import 'base_model.dart';

/// State of search players and clans
class SearchModel extends BaseModel {
  /// List of player
  var _players = <Player>[];

  /// List of search history
  var _histories = <String>[];

  /// Storage key
  final _key = 'search_histories';

  /// Instance of player service class
  final _service = locator<PlayerService>();

  /// List of search histories
  List<String> get histories => _histories.reversed.toList();

  /// List of player
  List<Player> get players => _players;

  /// Fetch players filtered by search string(user name)
  Future fetchPlayer(String search) async {
    // change view state to busy
    change(ViewState.busy);

    // fetch players
    var players = await _service.fetchPlayers(search);
    _players = players;

    // change view state to idle
    change(ViewState.idle);

    // send notice
    notifyListeners();
  }

  /// Adds a new search history item
  Future addHistory(String item) async {
    // get histories from persistent storage
    var histories = await _getHistories();

    // remove duplicate item and add it
    histories.remove(item);
    histories.add(item);

    // synchronize data
    await _synchronizeHistories(histories);

    // send notice
    notifyListeners();
  }

  /// Removes the item from the search history list
  Future removeHistory(String item) async {
    // get histories from persistent storage
    var histories = await _getHistories();

    // remove item
    histories.remove(item);

    // synchronize data
    await _synchronizeHistories(histories);

    // send notice
    notifyListeners();
  }

  /// Get histories from persistent storage
  Future<List<String>> _getHistories() async {
    var prefs = await SharedPreferences.getInstance();
    return (prefs.getStringList(_key) ?? []);
  }

  /// Synchronize data
  Future _synchronizeHistories(List<String> histories) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_key, histories);
    _histories = histories;
  }
}
