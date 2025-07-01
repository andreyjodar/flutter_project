import 'package:flutter_project/domain/entities/user.dart';
import 'package:flutter_project/domain/repositories/user_repository_interface.dart';

class UpdateUserUseCase {
  final UserRepositoryInterface _repository;

  UpdateUserUseCase(this._repository);

  Future<void> call(User user) async {
    final userDb = await _repository.getUserById(user.id);
    if(userDb == null) throw Exception('Usuário não cadastrado');
    await _repository.updateUser(user);
  }
}