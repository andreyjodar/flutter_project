import 'package:flutter_project/domain/entities/cart_item.dart';
import 'package:flutter_project/domain/entities/user.dart';

class Cart {
  final String id;
  final User? buyer;
  final List<CartItem> _cartItems;
  DateTime _lastUpdate;

  Cart({
    required this.id,
    List<CartItem>? items,
    this.buyer,
    DateTime? lastUpdate,
  })  : _cartItems = List.from(items ?? []),
        _lastUpdate = lastUpdate ?? DateTime.now();

  List<CartItem> get cartItems => List.unmodifiable(_cartItems);
  DateTime get lastUpdate => _lastUpdate;

  void addItem(CartItem item) {
    _cartItems.add(item);
    _updateDate();
  }

  void removeItem(String itemId) {
    _cartItems.removeWhere((item) => item.id == itemId);
    _updateDate();
  }

  double get totalPrice => _calculateTotalPrice();

  double _calculateTotalPrice() {
    return _cartItems.fold(0, (sum, item) => sum + item.calculatePrice());
  }

  void _updateDate() {
    _lastUpdate = DateTime.now();
  }
}