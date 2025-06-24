import 'package:flutter_project/data/models/company_dto.dart';
import 'package:uuid/uuid.dart';

class ProductDTO {
  String id;
  String? urlImage;
  String name;
  String description;
  String type;
  String status;
  String un;
  double price;
  CompanyDTO company;
  DateTime registerDate;

  ProductDTO({
    String? id,
    this.urlImage,
    required this.name,
    required this.description,
    required this.type,
    required this.status,
    required this.un,
    required this.price,
    required this.company,
    DateTime? registerDate,
  })  : id = id ?? const Uuid().v4(),
        registerDate = registerDate ?? DateTime.now();
}
