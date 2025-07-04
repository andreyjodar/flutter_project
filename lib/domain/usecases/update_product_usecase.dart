import 'package:flutter_project/domain/entities/product.dart';
import 'package:flutter_project/domain/repositories/product_repository_interface.dart';

class UpdateProductUseCase {
  final ProductRepositoryInterface _repository;

  UpdateProductUseCase(this._repository);

  Future<void> call(Product product) async {
    final productDb = await _repository.getProductById(product.id);
    if(productDb == null) throw Exception('Produto não cadastrado');
    return await _repository.updateProduct(product);
  }
}