import 'package:flutter_project/domain/entities/user.dart';
import 'package:flutter_project/domain/repositories/user_repository_interface.dart';

class UserUseCase {
  final UserRepositoryInterface repository;

  UserUseCase({required this.repository});

  Future<void> registerUser(User user) async {
    // pensar nas regras de negócio
    await repository.createUser(user);
  }

  Future<User?> getUserByEmail(String email) async {
    return await repository.getUserByEmail(email);
  }

  Future<void> updateUser(User user) async {
    await repository.updateUser(user);
  }

  Future<void> deleteUser(String id) async {
    await repository.deleteUser(id);
  }

  Future<List<User>> getAllUsers() async {
    return await repository.getAllUsers();
  }
}