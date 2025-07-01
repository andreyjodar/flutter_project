import 'package:flutter_project/domain/entities/company.dart';

abstract class CompanyRepositoryInterface {
  Future<Company?> getCompanyById(String id);
  Future<Company?> getCompanyByCnpj(String cnpj);
  Future<List<Company>> getCompaniesByUser(String userId);
  Future<List<Company>> getAllCompanies();
  Future<void> createCompany(Company company);
  Future<void> updateCompany(Company company);
  Future<void> deleteCompany(String id);
}