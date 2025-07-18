import 'package:flutter_project/domain/entities/cart.dart';

abstract class CartRepositoryInterface {
  Future<Cart> getActiveCartByBuyer(String buyerId);
  Future<void> createCart(Cart cart);
  Future<void> updateCart(Cart cart);
  Future<void> deleteCart(String id);
}