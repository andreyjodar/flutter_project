import 'package:flutter_project/domain/entities/user.dart';
import 'package:flutter_project/domain/entities/company.dart';
import 'package:flutter_project/domain/repositories/company_repository_interface.dart';
import 'package:flutter_project/domain/repositories/user_repository_interface.dart';
import 'package:flutter_project/infrastructure/adapters/company_adapter.dart';
import 'package:flutter_project/infrastructure/datasources/company_dao_interface.dart';

class CompanyRepositoryImpl extends CompanyRepositoryInterface {
  final CompanyDaoInterface companyDao;
  final UserRepositoryInterface userRepository;

  CompanyRepositoryImpl({
    required this.companyDao,
    required this.userRepository,
  });

  @override
  Future<void> createCompany(Company company) async {
    final companyDto = CompanyAdapter.toDto(company);
    await companyDao.create(companyDto);
  }

  @override
  Future<void> deleteCompany(String id) async {
    await companyDao.delete(id);
  }

  @override
  Future<List<Company>> getAllCompanies() async {
    final companiesDto = await companyDao.getAll();

    final companies = await Future.wait(companiesDto.map((dto) async {
      final producer = await _getProducer(dto.producerId);
      return CompanyAdapter.fromDto(dto, producer);
    }));

    return companies;
  }

  @override
  Future<List<Company>> getCompaniesByUser(String userId) async {
    final companiesDto = await companyDao.getByUser(userId);
    final producer = await _getProducer(userId);

    return companiesDto
        .map((dto) => CompanyAdapter.fromDto(dto, producer))
        .toList();
  }

  @override
  Future<Company?> getCompanyById(String id) async {
    final companyDto = await companyDao.getById(id);
    if (companyDto == null) return null;

    final producer = await _getProducer(companyDto.producerId);
    return CompanyAdapter.fromDto(companyDto, producer);
  }

  @override
  Future<Company?> getCompanyByCnpj(String cnpj) async {
    final companyDto = await companyDao.getByCnpj(cnpj);
    if (companyDto == null) return null;

    final producer = await _getProducer(companyDto.producerId);
    return CompanyAdapter.fromDto(companyDto, producer);
  }

  @override
  Future<void> updateCompany(Company company) async {
    final dto = CompanyAdapter.toDto(company);
    await companyDao.update(dto);
  }

  Future<User> _getProducer(String userId) async {
    final user = await userRepository.getUserById(userId);
    if (user == null) {
      throw Exception('Produtor com ID "$userId" não encontrado');
    }
    return user;
  }
}
