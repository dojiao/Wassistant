import 'package:flutter/widgets.dart';

/// Page state
class PageModel with ChangeNotifier {
  var _currentIndex = 0;
  var _title = 'Player';

  /// Current page index
  int get currentIndex => _currentIndex;

  /// Page title
  String get title => _title;

  /// Changes page index
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
