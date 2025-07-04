import 'package:flutter_project/domain/entities/product.dart';
import 'package:flutter_project/domain/repositories/product_repository_interface.dart';

class GetProductsByCompanyUseCase {
  final ProductRepositoryInterface _repository;

  GetProductsByCompanyUseCase(this._repository);

  Future<List<Product>> call(String companyId) async {
    return await _repository.getProductsByCompany(companyId);
  }
}