import 'package:flutter_project/data/dtos/user_dto.dart';

class UserRepository {
  final List<User> _users = [
    User(
        name: 'João',
        email: 'joao@email.com',
        password: 'senha123',
        type: 'Comprador'),
    User(
        name: 'Ana',
        email: 'ana@email.com',
        password: 'senha123',
        type: 'Produtor'),
  ];

  List<User> listUsers() => List.unmodifiable(_users);

  User? getUserById(String id) {
    try {
      return _users.firstWhere((user) => user.id == id);
    } catch (e) {
      return null;
    }
  }

  User? getUserByEmail(String email) {
    try {
      return _users.firstWhere((user) => user.email == email);
    } catch (e) {
      return null;
    }
  }

  void addUser(User user) {
    if (getUserByEmail(user.email) == null && getUserById(user.id) == null) {
      _users.add(user);
    }
  }

  void updateUser(User updatedUser) {
    final index = _users.indexWhere((user) => user.id == updatedUser.id);
    if (index != -1) {
      _users[index] = updatedUser;
    }
  }

  void removeUser(String id) {
    _users.removeWhere((user) => user.id == id);
  }

  bool isValidUser(String email, String password) {
    final user = getUserByEmail(email);
    return user != null && user.password == password;
  }
}
