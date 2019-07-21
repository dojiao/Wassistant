import 'package:flutter/widgets.dart';

import '../enums/view_state.dart';

/// Base model for managing view active state
class BaseModel extends ChangeNotifier {
  var _state = ViewState.idle;

  /// View active state
  ViewState get state => _state;

  /// Change active state
  void changeState(ViewState state) {
    _state = state;
    notifyListeners();
  }
}
