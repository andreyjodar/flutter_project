import 'package:flutter_project/data/entity/user.dart';

class UserRepository {
  final List<User> _users = [
    User(
      name: 'João',
      email: 'joao@email.com',
      password: 'senha123',
      type: 'Comprador'
    ),
    User(
      name: 'Ana',
      email: 'ana@email.com',
      password: 'senha123',
      type: 'Produtor'
    ),
  ];

  List<User> listUsers() => List.unmodifiable(_users);

  User? getUserByEmail(String email) {
    try {
      return _users.firstWhere((user) => user.email == email);
    } catch (e) {
      return null;
    }
  }

  void addUser(User user) {
    if(getUserByEmail(user.email) == null) {
      _users.add(user);
    }
  }

  void updateUser(String email, User updatedUser) {
    final index = _users.indexWhere((user) => user.email == email);
    _users[index] = updatedUser;
  }

  bool isValidUser(String email, String password) {
    final user = getUserByEmail(email);
    return user != null && user.password == password;
  }
}