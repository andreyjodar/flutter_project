import 'package:flutter_project/infrastructure/models/cart_item_dto.dart';

class CartDto {
  String id;
  String buyerId;
  bool isActive;
  List<CartItemDto> cartItems;
  String lastUpdate;

  CartDto({
    required this.id,
    required this.buyerId,
    required this.isActive,
    required this.cartItems,
    required this.lastUpdate
  });

  factory CartDto.fromMap(Map<String, dynamic> map) {
    return CartDto(
      id: map['id'], 
      buyerId: map['buyerId'], 
      isActive: map['isActive'],
      cartItems: (map['cartItems'] as List<dynamic>)
        .map((item) => CartItemDto.fromMap(item as Map<String, dynamic>)).toList(),
      lastUpdate: map['lastUpdate']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'buyerId': buyerId,
      'isActive': isActive,
      'cartItems': cartItems.map((item) => item.toMap()).toList(),
      'lastUpdate': lastUpdate
    };
  }
}