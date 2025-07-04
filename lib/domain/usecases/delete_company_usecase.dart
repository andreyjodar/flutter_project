import 'package:flutter_project/domain/repositories/company_repository_interface.dart';

class DeleteCompanyUseCase {
  final CompanyRepositoryInterface _repository;

  DeleteCompanyUseCase(this._repository);

  Future<void> call(String companyId) async {
    return await _repository.deleteCompany(companyId);
  }
}