import 'package:flutter_project/domain/entities/product.dart';
import 'package:flutter_project/domain/repositories/product_repository_interface.dart';

class GetAllProductsUseCase {
  final ProductRepositoryInterface _repository;

  GetAllProductsUseCase(this._repository);

  Future<List<Product>> call() async {
    return await _repository.getAllProducts();
  }
}