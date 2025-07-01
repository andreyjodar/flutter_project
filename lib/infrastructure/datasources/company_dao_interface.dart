import 'package:flutter_project/infrastructure/models/company_dto.dart';

abstract class CompanyDaoInterface {
  Future<void> create(CompanyDto companyDto);
  Future<void> update(CompanyDto companyDto);
  Future<void> delete(String companyId);
  Future<CompanyDto?> getById(String id);
  Future<CompanyDto?> getByCnpj(String cnpj);
  Future<List<CompanyDto>> getByUser(String userId);
  Future<List<CompanyDto>> getAll();
}