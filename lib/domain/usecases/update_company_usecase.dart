import 'package:flutter_project/domain/entities/company.dart';
import 'package:flutter_project/domain/repositories/company_repository_interface.dart';

class UpdateCompanyUseCase {
  final CompanyRepositoryInterface _repository;

  UpdateCompanyUseCase(this._repository);

  Future<void> call(Company company) async {
    final companyDb = await _repository.getCompanyById(company.id);
    if(companyDb == null) throw Exception('Empresa não cadastrada');
    await _repository.updateCompany(company);
  }
}