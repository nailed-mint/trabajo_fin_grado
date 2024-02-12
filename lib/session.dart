import 'package:flutter/foundation.dart';

class Session<T> extends ChangeNotifier {
  T? _activeUser;

  T? get activeUser => _activeUser;

  void setActiveUser(T user) {
    _activeUser = user;
    notifyListeners();
  }
}
