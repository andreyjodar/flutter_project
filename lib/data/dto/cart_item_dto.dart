import 'package:flutter_project/data/dto/product_dto.dart';
import 'package:uuid/uuid.dart';

class CartItemDTO {
  String id;
  ProductDTO product;
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