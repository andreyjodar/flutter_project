import 'package:flutter_project/data/dto/user_dto.dart';

abstract class UserDaoInterface {
  Future<void> create(UserDto userDto);
  Future<void> update(UserDto userDto);
  Future<void> delete(String userId);
  Future<UserDto?> getById(String id);
  Future<UserDto?> getByEmail(String email);
  Future<List<UserDto?>> getAll();
}