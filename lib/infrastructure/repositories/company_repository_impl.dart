import 'package:flutter_project/infrastructure/adapters/user_adapter.dart';
import 'package:flutter_project/infrastructure/datasources/company_dao_interface.dart';
import 'package:flutter_project/domain/entities/company.dart';
import 'package:flutter_project/domain/repositories/company_repository_interface.dart';
import 'package:flutter_project/infrastructure/adapters/company_adapter.dart';
import 'package:flutter_project/infrastructure/datasources/user_dao_interface.dart';

class CompanyRepositoryImpl extends CompanyRepositoryInterface{
  final CompanyDaoInterface companyDao;
  final UserDaoInterface userDao;

  CompanyRepositoryImpl({required this.companyDao, required this.userDao});

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
    final companiesDto = await companyDao.getAll();
    List<Company> companies = [];

    for (final companyDto in companiesDto) {
      final userDto = await userDao.getById(companyDto.producerId);
      if (userDto == null) {
        continue; 
      }
      final user = UserAdapter.fromDto(userDto);
      final company = CompanyAdapter.fromDto(companyDto, user);
      companies.add(company);
    }

    return companies;
  }

  @override
  Future<List<Company>> getCompaniesByUser(String userId) async {
    final companiesDto = await companyDao.getByUser(userId);

    final userDto = await userDao.getById(userId);
    if (userDto == null) throw Exception('Produtor não encontrado');

    final user = UserAdapter.fromDto(userDto);
    return companiesDto.map((dto) => CompanyAdapter.fromDto(dto, user)).toList();
  }

  @override
  Future<Company?> getCompanyById(String id) async {
    final companyDto = await companyDao.getById(id);
    if(companyDto == null) return null; 

    final userDto = await userDao.getById(companyDto.producerId);
    if(userDto == null) throw Exception('Produtor não encontrado');
    
    final producer = UserAdapter.fromDto(userDto);
    return CompanyAdapter.fromDto(companyDto, producer); 
  }

  @override
  Future<Company?> getCompanyByCnpj(String cnpj) async {
    final companyDto = await companyDao.getByCnpj(cnpj);
    if(companyDto == null) return null;

    final userDto = await userDao.getById(companyDto.producerId);
    if(userDto == null) throw Exception('Produtor não encontrado');

    final producer = UserAdapter.fromDto(userDto);
    return CompanyAdapter.fromDto(companyDto, producer);
  }

  @override
  Future<void> updateCompany(Company company) async {
    final dto = CompanyAdapter.toDto(company);
    await companyDao.update(dto);
  }
}