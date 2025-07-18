import 'package:flutter_project/domain/entities/cart_item.dart';
import 'package:flutter_project/domain/entities/user.dart';

class Cart {
  final String _id;
  final User _buyer;
  final List<CartItem> _cartItems;
  bool _isActive;
  DateTime _lastUpdate;

  Cart({
    required String id,
    List<CartItem>? items,
    required User buyer,
    bool? isActive,
    DateTime? lastUpdate,
  })  : _id = id,
        _cartItems = List.from(items ?? []),
        _buyer = buyer,
        _isActive = isActive ?? true,
        _lastUpdate = lastUpdate ?? DateTime.now() {
    if(_buyer.isBuyer() == false) {
      throw Exception('Usuário não é do tipo comprador');
    }
  }

  String get id => _id;
  User? get buyer => _buyer;
  List<CartItem> get cartItems => List.unmodifiable(_cartItems);
  bool get isActive => _isActive;
  DateTime get lastUpdate => _lastUpdate;
  double get totalPrice => _calculateTotalPrice();

  double _calculateTotalPrice() {
    return _cartItems.fold(0, (sum, item) => sum + item.calculatePrice());
  }

  void inactiveCart() {
    _isActive = false;
    _updateDate();
  }

  void activeCart() {
    _isActive = true;
    _updateDate();
  }

  void addItem(CartItem item) {
    for (var i = 0; i < _cartItems.length; i++) {
      if(item.product.id == _cartItems[i].product.id) {
        _cartItems[i].incrementQuantity();
        _updateDate();
        return;
      }
    }
    _cartItems.add(item);
    _updateDate();
  }

  void removeItem(String itemId) {
    _cartItems.removeWhere((item) => item.id == itemId);
    _updateDate();
  }

  void _updateDate() {
    _lastUpdate = DateTime.now();
  }
}