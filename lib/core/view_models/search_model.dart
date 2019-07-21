import '../../locator.dart';
import '../enums/view_state.dart';
import '../models/player.dart';
import '../services/player_service.dart';
import 'base_model.dart';

/// A layer contains players/clans searching logic
class SearchModel extends BaseModel {
  /// List of players
  var _players = <Player>[];

  /// Instance of player service class
  final _service = locator<PlayerService>();

  /// List of players
  List<Player> get players => _players;

  /// Fetch players with query string
  Future fetchPlayers(String search) async {
    // change view state to busy
    changeState(ViewState.busy);

    // fetch players
    _players = await _service.fetchPlayers(search);

    // change view state to idle
    changeState(ViewState.idle);

    // send notice
    notifyListeners();
  }
}
