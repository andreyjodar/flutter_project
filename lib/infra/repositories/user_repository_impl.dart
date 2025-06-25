import 'package:flutter_project/domain/repositories/user_repository_interface.dart';
import 'package:flutter_project/domain/entities/user.dart';
import 'package:flutter_project/data/datasources/user_dao.dart';
import 'package:flutter_project/data/dto/user_dto.dart';
import 'package:flutter_project/infra/adapters/user_adapter.dart';

class UserRepositoryImpl implements UserRepositoryInterface {
  final UserDaoInterface userDao;

  UserRepositoryImpl(this.userDao);

  @override
  Future<void> createUser(User user) async {
    final dto = UserAdapter.toDto(user);
    await userDao.create(dto);
  }

  @override
  Future<void> updateUser(User user) async {
    final dto = UserAdapter.toDto(user);
    await userDao.update(dto);
  }

  @override
  Future<void> deleteUser(String id) async {
    await userDao.delete(id);
  }

  @override
  Future<User?> getUserById(String id) async {
    final dto = await userDao.getById(id);
    return dto != null ? UserAdapter.fromDto(dto) : null;
  }

  @override
  Future<User?> getUserByEmail(String email) async {
    final dto = await userDao.getByEmail(email);
    return dto != null ? UserAdapter.fromDto(dto) : null;
  }

  @override
  Future<List<User>> getAllUsers() async {
    final dtos = await userDao.getAll();
    return dtos
        .whereType<UserDto>()
        .map(UserAdapter.fromDto)
        .toList();
  }
}