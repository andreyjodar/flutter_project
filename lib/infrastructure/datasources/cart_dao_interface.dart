import 'package:flutter_project/infrastructure/models/cart_dto.dart';

abstract class CartDaoInterface {
  Future<CartDto?> getById(String id);
  Future<CartDto?> getActiveByBuyer(String buyerId);
  Future<void> create(CartDto cartDto);
  Future<void> update(CartDto cartDto);
  Future<void> delete(String id);
}