import 'package:flutter_project/domain/entities/cart.dart';
import 'package:flutter_project/domain/repositories/cart_repository_interface.dart';

class RemoveCartItemUseCase {
  final CartRepositoryInterface _repository;

  RemoveCartItemUseCase(this._repository);

  Future<void> execute(Cart cart, String itemId) async {
    cart.removeItem(itemId);
    await _repository.updateCart(cart);
  }
}
