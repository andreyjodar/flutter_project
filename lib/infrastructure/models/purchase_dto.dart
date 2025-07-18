import 'package:flutter_project/infrastructure/models/cart_dto.dart';
import 'package:uuid/uuid.dart';

class PurchaseDTO {
  String id;
  CartDto cart;
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