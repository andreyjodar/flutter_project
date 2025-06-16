import 'package:flutter_project/data/models/cart_dto.dart';
import 'package:uuid/uuid.dart';

class PurchaseDTO {
  String id;
  CartDTO cart;
  String status;
  double price;
  DateTime purchaseDate;

  PurchaseDTO({
    String? id,
    required this.cart,
    required this.status,
    required this.price,
    DateTime? purchaseDate
  }) : id = id ?? Uuid().v4(),
       purchaseDate = purchaseDate ?? DateTime.now();
}