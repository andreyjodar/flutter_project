import 'package:flutter_project/domain/entities/user.dart';
import 'package:flutter_project/domain/repositories/user_repository_interface.dart';

class GetProducersUseCase {
  final UserRepositoryInterface _repository;

  GetProducersUseCase(this._repository);

  Future<List<User>> call() async {
    return await _repository.getUsersByType(UserType.producer);
  }  
}