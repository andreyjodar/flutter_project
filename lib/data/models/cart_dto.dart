import 'package:uuid/uuid.dart';

class CartDTO {
  String id;
  String buyerId;
  List<String> cartItemsId;
  DateTime lastUpdate;

  CartDTO({
    String? id,
    required this.buyerId,
    required this.cartItemsId,
    DateTime? lastUpdate
  }) : id = id ?? Uuid().v4(), 
       lastUpdate = lastUpdate ?? DateTime.now();
}