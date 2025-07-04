import 'package:flutter_project/domain/entities/product.dart';
import 'package:flutter_project/infrastructure/repositories/product_repository_impl.dart';

class RegisterProductUseCase {
  final ProductRepositoryImpl _repository;

  RegisterProductUseCase(this._repository);

  Future<void> call(Product product) async {
    await _repository.createProduct(product);
  }
}