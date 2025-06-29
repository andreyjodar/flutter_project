import 'package:flutter_project/data/dto/company_dto.dart';

abstract class CompanyDaoInterface {
  Future<void> create(CompanyDto userDto);
  Future<void> update(CompanyDto userDto);
  Future<void> delete(String companyId);
  Future<CompanyDto?> getById(String id);
  Future<List<CompanyDto>> getByUser(String userId);
  Future<List<CompanyDto>> getAll();
}