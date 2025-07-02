import 'package:flutter_project/domain/entities/company.dart';
import 'package:flutter_project/domain/repositories/company_repository_interface.dart';

class GetAllCompaniesUseCase {
  final CompanyRepositoryInterface _repository;

  GetAllCompaniesUseCase(this._repository);

  Future<List<Company>> call() async {
    return await _repository.getAllCompanies();
  }
}