import 'package:flutter_project/domain/repositories/product_repository_interface.dart';

class DeleteProductUseCase {
  final ProductRepositoryInterface _repository;

  DeleteProductUseCase(this._repository);

  Future<void> call(String userId) async {
    await _repository.deleteProduct(userId);
  }
}