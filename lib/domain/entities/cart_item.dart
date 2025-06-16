import 'package:flutter_project/domain/entities/product.dart';
import 'package:uuid/uuid.dart';

class CartItem {
  final String id;
  final Product product;
  int quantity;
  DateTime lastUpdate;

  CartItem({
    String? id,
    required this.product,
    required this.quantity,
    DateTime? lastUpdate
  }) : id = id ?? Uuid().v4(),
       lastUpdate = lastUpdate ?? DateTime.now()
  {
    if(quantity <= 0) throw Exception('Quantidade inválida (menor ou igual a zero)');
  }

  void updateQuantity(int quantity) {
    if(quantity <= 0) throw Exception('Quantidade inválida (menor ou igual a zero)');
    this.quantity = quantity;
    _updateDate();
  }

  void _updateDate() {
    lastUpdate = DateTime.now();
  }

  double calculatePrice() {
    return product.price * quantity;
  }
}