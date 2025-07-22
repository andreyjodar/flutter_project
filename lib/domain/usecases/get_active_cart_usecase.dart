import 'package:flutter_project/domain/entities/cart.dart';
import 'package:flutter_project/domain/repositories/cart_repository_interface.dart';

class GetActiveCartUseCase {
  final CartRepositoryInterface _repository;

  GetActiveCartUseCase(this._repository);

  Future<Cart?> call(String buyerId) async {
    return await _repository.getActiveCartByBuyer(buyerId);
  }
}