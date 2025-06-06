import 'package:uuid/uuid.dart';

class Product {
  String id;
  String name;
  String type;
  String un;
  double price;
  String companyId;
  DateTime registerDate;

  Product({
    String? id,
    required this.name,
    required this.type,
    required this.un,
    required this.price,
    required this.companyId,
    DateTime? registerDate,
  })  : id = id ?? const Uuid().v4(),
        registerDate = registerDate ?? DateTime.now();
}
