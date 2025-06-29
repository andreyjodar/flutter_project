import 'package:flutter_project/data/datasources/interfaces/company_dao_interface.dart';
import 'package:flutter_project/domain/entities/company.dart';
import 'package:flutter_project/domain/repositories/company_repository.dart';
import 'package:flutter_project/infra/adapters/company_adapter.dart';

class CompanyRepositoryImpl extends CompanyRepositoryInterface{
  final CompanyDaoInterface companyDao;

  CompanyRepositoryImpl(this.companyDao);

  @override
  Future<void> createCompany(Company company) async {
    final dto = CompanyAdapter.toDto(company);
    await companyDao.create(dto);
  }

  @override
  Future<void> deleteCompany(String id) async {
    await companyDao.delete(id);
  }

  @override
  Future<List<Company>> getAllCompanies() async {
    // TODO: implement getAllCompanies
    throw UnimplementedError();
  }

  @override
  Future<List<Company>> getCompaniesByUser(String userId) {
    // TODO: implement getCompaniesByUser
    throw UnimplementedError();
  }

  @override
  Future<Company?> getCompanyById(String id) async {
    final dto = await companyDao.getById(id);
    return dto != null ? CompanyAdapter.fromDto(dto) : null;
  }

  @override
  Future<void> updateCompany(Company company) async {
    final dto = CompanyAdapter.toDto(company);
    await companyDao.update(dto);
  }
}