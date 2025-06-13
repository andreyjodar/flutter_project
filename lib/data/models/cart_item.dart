import 'package:flutter_project/data/models/product_dto.dart';
import 'package:uuid/uuid.dart';

class CartItemDTO {
  String id;
  ProductDTO product;
  int quantity;
  DateTime appendDate;

  CartItemDTO({
    String? id, 
    required this.product,
    required this.quantity,
    DateTime? appendDate
  }) : id = id ?? Uuid().v4(),
       appendDate = appendDate ?? DateTime.now();
}