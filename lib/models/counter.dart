import 'package:flutter/foundation.dart';

/// Counter Model
class Counter with ChangeNotifier {
  int _count = 0;

  /// Count number
  int get count => _count;

  /// Increase count number
  void increment() {
    _count += 1;
    notifyListeners();
  }
}
