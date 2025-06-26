// domain/usecases/login_user_usecase.dart
import 'package:flutter_project/domain/entities/user.dart';
import 'package:flutter_project/domain/repositories/user_repository_interface.dart';

class LoginUserUseCase {
  final UserRepositoryInterface repository;

  LoginUserUseCase(this.repository);

  Future<User> call(String email, String password) async {
    final user = await repository.getUserByEmail(email);

    if(user == null) throw Exception('Usuário não encontrado');

    if(!user.password.isValid(password)) throw Exception('Senha incorreta');

    return user;
  }
}