// domain/usecases/register_user_usecase.dart
import 'package:flutter_project/domain/entities/user.dart';
import 'package:flutter_project/domain/repositories/user_repository_interface.dart';

class RegisterUserUseCase {
  final UserRepositoryInterface repository;

  RegisterUserUseCase(this.repository);

  Future<void> call(User user) async {
    final userDb = await repository.getUserByEmail(user.email.toString());

    if(userDb != null) throw Exception('Esse email já está sendo usado');

    await repository.createUser(user);
  }
}
