import 'package:uuid/uuid.dart';

class PurchaseDTO {
  String id;
  String cartId;
  String status;
  DateTime purchaseDate;

  PurchaseDTO({
    String? id,
    required this.cartId,
    required this.status,
    DateTime? purchaseDate
  }) : id = id ?? Uuid().v4(),
       purchaseDate = purchaseDate ?? DateTime.now();
}