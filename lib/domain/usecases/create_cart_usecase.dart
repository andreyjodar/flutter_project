import 'package:flutter_project/domain/entities/cart.dart';
import 'package:flutter_project/domain/repositories/cart_repository_interface.dart';

class CreateCartUseCase {
  final CartRepositoryInterface _repository;

  CreateCartUseCase(this._repository);

  Future<void> call(Cart cart) async {
    return await _repository.createCart(cart);
  }
}