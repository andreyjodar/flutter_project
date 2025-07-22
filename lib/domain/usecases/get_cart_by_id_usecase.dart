import 'package:flutter_project/domain/entities/cart.dart';
import 'package:flutter_project/domain/repositories/cart_repository_interface.dart';

class GetCartByIdUseCase {
  final CartRepositoryInterface _repository;

  GetCartByIdUseCase(this._repository);

  Future<Cart?> call(String id) async {
    return await _repository.getCartById(id);
  }
}