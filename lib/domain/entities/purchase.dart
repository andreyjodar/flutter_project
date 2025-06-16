import 'package:flutter_project/domain/entities/cart.dart';
import 'package:uuid/uuid.dart';

enum PurchaseStatus { order, delivering, delivered }

class Purchase {
  final String id;
  final Cart purchaseCart;
  PurchaseStatus status;
  final double price;
  final DateTime purchaseDate;

  Purchase({
    String? id,
    required this.purchaseCart,
    required this.status,
    DateTime? purchaseDate
  }) : id = id ?? Uuid().v4(),
       purchaseDate = purchaseDate ?? DateTime.now(),
       price = purchaseCart.calculatePrice();

  void updateStatus(PurchaseStatus status) {
    this.status = status;
  } 
}