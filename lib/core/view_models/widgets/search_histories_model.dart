import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Search histories status
class SearchHistoriesModel with ChangeNotifier {
  var _histories = <String>[];

  /// Storage key
  final _key = 'plyer_search_histories';

  /// List of search histories
  List<String> get histories => _histories.reversed.toList();

  /// Adds a new search history item
  void add(String item) async {
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
  void remove(String item) async {
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
  _synchronizeHistories(List<String> histories) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_key, histories);
    _histories = histories;
  }
}
