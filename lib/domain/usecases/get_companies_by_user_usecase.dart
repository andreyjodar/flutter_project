import 'package:flutter_project/domain/entities/company.dart';
import 'package:flutter_project/domain/repositories/company_repository_interface.dart';

class GetCompaniesByUserUseCase {
  final CompanyRepositoryInterface _repository;

  GetCompaniesByUserUseCase(this._repository);

  Future<List<Company>> call(String userId) async {
    return await _repository.getCompaniesByUser(userId);
  }
}