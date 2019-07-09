import 'package:flutter/material.dart';

import '../pages/index/encyclopedia.dart';
import '../pages/index/player.dart';
import '../pages/index/settings.dart';

/// Page status
class Page with ChangeNotifier {
  var _currentIndex = 0;
  var _title = 'Player';

  /// Page list
  List<Widget> get pages => [
        PlayerPage(),
        EncyclopediaPage(),
        SettingsPage(),
      ];

  /// Current page index
  int get currentIndex => _currentIndex;

  /// Page title
  String get title => _title;

  /// Change page index
  void change(int index) {
    // change index
    _currentIndex = index;

    // change title
    switch (index) {
      case 0:
        _title = 'Player';
        break;
      case 1:
        _title = 'Encyclopedia';
        break;
      case 2:
        _title = 'Settings';
        break;
    }

    // send notice
    notifyListeners();
  }
}
