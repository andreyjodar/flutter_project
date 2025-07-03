import 'package:flutter_project/infrastructure/models/product_dto.dart';
import 'package:uuid/uuid.dart';

class CartItemDTO {
  String id;
  ProductDto product;
  int quantity;
  DateTime lastUpdate;

  CartItemDTO({
    String? id, 
    required this.product,
    required this.quantity,
    DateTime? lastUpdate
  }) : id = id ?? Uuid().v4(),
       lastUpdate = lastUpdate ?? DateTime.now();
}