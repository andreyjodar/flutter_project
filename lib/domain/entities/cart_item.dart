import 'package:flutter_project/domain/entities/product.dart';

class CartItem {
  final String id;
  final Product product;
  int _quantity;
  DateTime _lastUpdate;

  CartItem({
    required this.id,
    required this.product,
    required int quantity,
    DateTime? lastUpdate,
  })  : _quantity = quantity,
        _lastUpdate = lastUpdate ?? DateTime.now() {
    if (quantity <= 0) {
      throw Exception('Quantidade inválida');
    }
  }

  int get quantity => _quantity;
  DateTime get lastUpdate => _lastUpdate;

  void updateQuantity(int quantity) {
    if (quantity <= 0) throw Exception('Quantidade inválida');
    _quantity = quantity;
    _lastUpdate = DateTime.now();
  }

  double calculatePrice() => product.price * _quantity;
}