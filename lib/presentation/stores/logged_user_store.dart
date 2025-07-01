// presentation/stores/logged_user_store.dart
import 'package:flutter/material.dart';
import 'package:flutter_project/domain/entities/user.dart';

class LoggedUserStore extends ChangeNotifier {
  User? _user;

  User? get user => _user;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

  void clear() {
    _user = null;
    notifyListeners();
  }
}
