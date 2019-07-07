import 'package:flutter/foundation.dart';

/// Page status
class Page with ChangeNotifier {
  int _index = 0;

  /// Current page index
  int get index => _index;

  /// Change page index
  void change(int index) {
    _index = index;
    notifyListeners();
  }
}
