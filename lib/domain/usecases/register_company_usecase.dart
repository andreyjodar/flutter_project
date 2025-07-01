import 'package:flutter_project/domain/entities/company.dart';
import 'package:flutter_project/infrastructure/repositories/company_repository_impl.dart';

class RegisterCompanyUseCase {
  final CompanyRepositoryImpl _repository;

  RegisterCompanyUseCase(this._repository);

  Future<void> call(Company company) async {
    final companyDb = await _repository.getCompanyByCnpj(company.cnpj);
    if(companyDb != null) throw Exception('Esse CNPJ já está sendo usado');
    await _repository.createCompany(company);
  }
}