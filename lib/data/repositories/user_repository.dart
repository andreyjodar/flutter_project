import 'package:flutter_project/data/models/user_dto.dart';

class UserRepository {
  final List<UserDTO> _users = [
    UserDTO(
        name: 'João',
        email: 'joao@email.com',
        password: 'senha123',
        type: 'Comprador',
        address: 'Avenida Fagundes, 213'),
    UserDTO(
        name: 'Ana',
        email: 'ana@email.com',
        password: 'senha123',
        type: 'Produtor',
        address: 'Rua Benito, 241'),
  ];

  List<UserDTO> listUsers() => List.unmodifiable(_users);

  UserDTO? getUserById(String id) {
    try {
      return _users.firstWhere((user) => user.id == id);
    } catch (e) {
      return null;
    }
  }

  UserDTO? getUserByEmail(String email) {
    try {
      return _users.firstWhere((user) => user.email == email);
    } catch (e) {
      return null;
    }
  }

  void addUser(UserDTO user) {
    if (getUserByEmail(user.email) == null && getUserById(user.id) == null) {
      _users.add(user);
    }
  }

  void updateUser(UserDTO updatedUser) {
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
