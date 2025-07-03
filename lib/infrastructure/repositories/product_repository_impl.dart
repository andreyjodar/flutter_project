import 'package:flutter_project/domain/entities/product.dart';
import 'package:flutter_project/domain/repositories/product_repository_interface.dart';
import 'package:flutter_project/domain/repositories/company_repository_interface.dart';
import 'package:flutter_project/infrastructure/adapters/product_adapter.dart';
import 'package:flutter_project/infrastructure/datasources/product_dao_interface.dart';

class ProductRepositoryImpl implements ProductRepositoryInterface {
  final ProductDaoInterface productDao;
  final CompanyRepositoryInterface companyRepository;

  ProductRepositoryImpl({
    required this.productDao,
    required this.companyRepository,
  });

  @override
  Future<void> createProduct(Product product) async {
    final productDto = ProductAdapter.toDto(product);
    await productDao.create(productDto);
  }

  @override
  Future<void> deleteProduct(String id) async {
    await productDao.delete(id);
  }

  @override
  Future<void> updateProduct(Product product) async {
    final productDto = ProductAdapter.toDto(product);
    await productDao.update(productDto);
  }

  @override
  Future<Product?> getProductById(String id) async {
    final productDto = await productDao.getById(id);
    if (productDto == null) return null;

    final company = await companyRepository.getCompanyById(productDto.companyId);
    if (company == null) throw Exception('Empresa não encontrada para o produto');

    return ProductAdapter.fromDto(productDto, company);
  }

  @override
  Future<List<Product>> getAllProducts() async {
    final dtoList = await productDao.getAll();

    final List<Product> products = [];
    for (final dto in dtoList) {
      final company = await companyRepository.getCompanyById(dto.companyId);
      if (company == null) {
        continue;
      }
      products.add(ProductAdapter.fromDto(dto, company));
    }

    return products;
  }

  @override
  Future<List<Product>> getProductsByCompany(String companyId) async {
    final productsDto = await productDao.getByCompany(companyId);

    final company = await companyRepository.getCompanyById(companyId);
    if (company == null) throw Exception('Empresa não encontrada');

    return productsDto
        .map((dto) => ProductAdapter.fromDto(dto, company))
        .toList();
  }

  @override
  Future<List<Product>> getProductsByType(ProductType type) async {
    final dtoList = await productDao.getByType(type);

    final List<Product> products = [];
    for (final dto in dtoList) {
      final company = await companyRepository.getCompanyById(dto.companyId);
      if (company == null) {
        continue;
      }
      products.add(ProductAdapter.fromDto(dto, company));
    }

    return products;
  }
}
