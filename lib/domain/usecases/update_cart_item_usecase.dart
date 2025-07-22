import 'package:flutter_project/domain/entities/cart.dart';
import 'package:flutter_project/domain/repositories/cart_repository_interface.dart';

class UpdateCartItemUseCase {
  final CartRepositoryInterface _repository;

  UpdateCartItemUseCase(this._repository);

  Future<void> execute(Cart cart, String itemId, int quantity) async {
    cart.updateItem(itemId, quantity);
    await _repository.updateCart(cart);
  }
}
