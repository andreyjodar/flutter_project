import 'package:flutter_project/domain/entities/cart.dart';
import 'package:flutter_project/infrastructure/models/cart_dto.dart';

class CartAdapter {
  static Cart fromDto(CartDto cartDto) {
    return Cart(
      id: cartDto.id, 
      buyer: ,
      items: ,
      isActive: ,
      lastUpdate: ,
    );
  }

  static CartDto toDto(Cart cart) {
    return CartDto(
      id: cart.id, 
      buyerId: cart.buyer!.id, 
      cartItems: , 
      isActive: cart.isActive.toString(),
      lastUpdate: cart.lastUpdate.toIso8601String()
    );
  }
}

class _CartItemAdapter {
  
}