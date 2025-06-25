import 'package:flutter_project/domain/entities/user.dart';

abstract class UserRepositoryInterface {
  Future<User?> getUserById(String id);
  Future<User?> getUserByEmail(String email);
  Future<List<User>> getAllUsers();
  Future<void> createUser(User user);
  Future<void> updateUser(User user);
  Future<void> deleteUser(String id);
}