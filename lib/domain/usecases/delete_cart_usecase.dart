import 'package:flutter_project/domain/repositories/cart_repository_interface.dart';

class DeleteCartUseCase {
  final CartRepositoryInterface _repository;

  DeleteCartUseCase(this._repository);

  Future<void> call(String id) async {
    return await _repository.deleteCart(id);
  }
}