import 'package:flutter_project/domain/entities/cart.dart';
import 'package:flutter_project/domain/entities/cart_item.dart';
import 'package:flutter_project/domain/repositories/cart_repository_interface.dart';

class AddCartItemUseCase {
  final CartRepositoryInterface _repository;

  AddCartItemUseCase(this._repository);

  Future<void> execute(Cart cart, CartItem newItem) async {
    cart.addItem(newItem);
    await _repository.updateCart(cart);
  }
}
