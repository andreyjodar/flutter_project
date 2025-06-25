// domain/usecases/register_user_usecase.dart
import 'package:flutter_project/domain/entities/user.dart';
import 'package:flutter_project/domain/repositories/user_repository.dart';

class RegisterUserUseCase {
  final UserRepositoryInterface repository;

  RegisterUserUseCase(this.repository);

  Future<void> call(User user) async {
    // Validação de regra de negócio pode ser feita aqui
    if (user.email.value.isEmpty) throw Exception('Email inválido');
    await repository.createUser(user);
  }
}
