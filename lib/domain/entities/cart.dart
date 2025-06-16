import 'package:flutter_project/domain/entities/cart_item.dart';
import 'package:flutter_project/domain/entities/user.dart';
import 'package:uuid/uuid.dart';

class Cart {
  final String id;
  final User buyer;
  List<CartItem> cartItems;
  DateTime lastUpdate;

  Cart({
    String? id, 
    required this.buyer,
    required this.cartItems,
    DateTime? lastUpdate
  }) : id = id ?? Uuid().v4(),
       lastUpdate = lastUpdate ?? DateTime.now();

  void addItem(CartItem item) {
    cartItems.add(item);
    _updateDate();
  }

  void removeItem(String id) {
    cartItems.removeWhere((item) => item.id == id);
    _updateDate();
  }

  void _updateDate() {
    lastUpdate = DateTime.now();
  }

  double calculatePrice() {
    double result = 0;
    for (CartItem item in cartItems) {
      result += item.calculatePrice();
    }
    return result;
  }
}