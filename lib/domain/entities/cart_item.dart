import 'package:flutter_project/domain/entities/product.dart';

class CartItem {
  final String _id;
  final Product _product;
  int _quantity;
  DateTime _lastUpdate;

  CartItem({
    required String id,
    required Product product,
    required int quantity,
    DateTime? lastUpdate,
  })  : _id = id,
        _product = product,
        _quantity = quantity,
        _lastUpdate = lastUpdate ?? DateTime.now() {
    if (quantity <= 0) {
      throw Exception('Quantidade não pode ser menor que 1');
    }
  }

  String get id => _id;
  Product get product => _product;
  int get quantity => _quantity;
  DateTime get lastUpdate => _lastUpdate;

  void incrementQuantity(int quantity) {
    _quantity += quantity;
  }

  void updateQuantity(int quantity) {
    if (quantity <= 0) throw Exception('Quantidade não pode ser menor que 1');
    _quantity = quantity;
    _lastUpdate = DateTime.now();
  }

  double calculatePrice() => _product.price * _quantity;
}