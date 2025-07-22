import 'package:flutter_project/domain/entities/cart.dart';
import 'package:flutter_project/domain/entities/cart_item.dart';
import 'package:flutter_project/domain/entities/user.dart';
import 'package:flutter_project/domain/entities/product.dart';
import 'package:flutter_project/infrastructure/models/cart_dto.dart';
import 'package:flutter_project/infrastructure/models/cart_item_dto.dart';

class CartAdapter {
  static Cart fromDto(
    CartDto cartDto, {
    required User buyer,
    required Map<String, Product> productsMap,
  }) {
    final cartItems = cartDto.cartItems.map((itemDto) {
      final product = productsMap[itemDto.productId];
      if (product == null) {
        throw Exception('Product ${itemDto.productId} not found');
      }

      return _CartItemAdapter.fromDto(itemDto, product);
    }).toList();

    return Cart(
      id: cartDto.id,
      buyer: buyer,
      items: cartItems,
      isActive: cartDto.isActive,
      lastUpdate: DateTime.parse(cartDto.lastUpdate),
    );
  }

  static CartDto toDto(Cart cart) {
    final cartItems = cart.cartItems.map((item) {
      return _CartItemAdapter.toDto(item);
    }).toList();

    return CartDto(
      id: cart.id,
      buyerId: cart.buyer.id,
      isActive: cart.isActive,
      cartItems: cartItems,
      lastUpdate: cart.lastUpdate.toIso8601String(),
    );
  }
}

class _CartItemAdapter {
  static CartItem fromDto(CartItemDto dto, Product product) {
    return CartItem(
      id: dto.id,
      product: product,
      quantity: dto.quantity,
      lastUpdate: DateTime.parse(dto.lastUpdate),
    );
  }

  static CartItemDto toDto(CartItem item) {
    return CartItemDto(
      id: item.id,
      productId: item.product.id,
      quantity: item.quantity,
      lastUpdate: item.lastUpdate.toIso8601String(),
    );
  }
}

