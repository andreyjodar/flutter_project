import 'package:flutter_project/domain/entities/user.dart';
import 'package:flutter_project/infrastructure/models/user_dto.dart';

abstract class UserDaoInterface {
  Future<void> create(UserDto userDto);
  Future<void> update(UserDto userDto);
  Future<void> delete(String userId);
  Future<UserDto?> getById(String id);
  Future<List<UserDto>> getByType(UserType type);
  Future<UserDto?> getByEmail(String email);
  Future<List<UserDto?>> getAll();
}