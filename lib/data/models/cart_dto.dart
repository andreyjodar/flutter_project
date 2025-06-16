import 'package:flutter_project/data/models/cart_item_dto.dart';
import 'package:flutter_project/data/models/user_dto.dart';
import 'package:uuid/uuid.dart';

class CartDTO {
  String id;
  UserDTO buyer;
  List<CartItemDTO> cartItems;
  DateTime lastUpdate;

  CartDTO({
    String? id,
    required this.buyer,
    required this.cartItems,
    DateTime? lastUpdate
  }) : id = id ?? Uuid().v4(), 
       lastUpdate = lastUpdate ?? DateTime.now();
}