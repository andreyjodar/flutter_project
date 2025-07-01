// domain/usecases/login_user_usecase.dart
import 'package:flutter_project/domain/entities/user.dart';
import 'package:flutter_project/domain/repositories/user_repository_interface.dart';

class LoginUserUseCase {
  final UserRepositoryInterface _repository;

  LoginUserUseCase(this._repository);

  Future<User> call(String email, String password) async {
    final user = await _repository.getUserByEmail(email);
    if(user == null) throw Exception('Usuário não encontrado');
    if(!user.isValidPassword(password)) throw Exception('Senha incorreta');
    return user;
  }
}