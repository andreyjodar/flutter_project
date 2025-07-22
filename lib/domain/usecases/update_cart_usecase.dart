import 'package:flutter_project/domain/entities/cart.dart';
import 'package:flutter_project/domain/repositories/cart_repository_interface.dart';

class UpdateCartUseCase {
  final CartRepositoryInterface _repository;

  UpdateCartUseCase(this._repository);

  Future<void> call(Cart cart) async {
    return await _repository.updateCart(cart);
  }
}