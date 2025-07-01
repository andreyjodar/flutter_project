import 'package:flutter_project/domain/repositories/user_repository_interface.dart';
import 'package:flutter_project/domain/entities/user.dart';
import 'package:flutter_project/infrastructure/datasources/user_dao_interface.dart';
import 'package:flutter_project/infrastructure/models/user_dto.dart';
import 'package:flutter_project/infrastructure/adapters/user_adapter.dart';

class UserRepositoryImpl implements UserRepositoryInterface {
  final UserDaoInterface userDao;

  UserRepositoryImpl(this.userDao);

  @override
  Future<void> createUser(User user) async {
    final userDto = UserAdapter.toDto(user);
    await userDao.create(userDto);
  }

  @override
  Future<void> updateUser(User user) async {
    final userDto = UserAdapter.toDto(user);
    await userDao.update(userDto);
  }

  @override
  Future<void> deleteUser(String id) async {
    await userDao.delete(id);
  }

  @override
  Future<User?> getUserById(String id) async {
    final userDto = await userDao.getById(id);
    return userDto != null ? UserAdapter.fromDto(userDto) : null;
  }

  @override
  Future<List<User>> getUsersByType(UserType type) async {
    final usersDto = await userDao.getByType(type);
    return usersDto 
        .whereType<UserDto>()
        .map(UserAdapter.fromDto)
        .toList();  
  }

  @override
  Future<User?> getUserByEmail(String email) async {
    final userDto = await userDao.getByEmail(email);
    return userDto != null ? UserAdapter.fromDto(userDto) : null;
  }

  @override
  Future<List<User>> getAllUsers() async {
    final usersDto = await userDao.getAll();
    return usersDto
        .whereType<UserDto>()
        .map(UserAdapter.fromDto)
        .toList();
  }
}