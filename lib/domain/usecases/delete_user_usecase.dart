import 'package:flutter_project/domain/repositories/user_repository_interface.dart';

class DeleteUserUseCase {
  final UserRepositoryInterface _repository;

  DeleteUserUseCase(this._repository);

  Future<void> call(String userId) async {
    await _repository.deleteUser(userId);
  }
}