import 'package:flutter_project/domain/entities/company.dart';
import 'package:uuid/uuid.dart';

enum ProductType {
  vegetable, 
  fruit, 
  tuber, 
  grain
}

enum ProductStatus {
  available,
  lack,
  unavailable,
}

enum ProductUn {
  unit,
  kilogram,
  milliliters,
  pack
}

class Product {
  String id;
  String? urlImage;
  String name;
  ProductType type;
  ProductStatus status;
  ProductUn un;
  double price;
  Company company;
  DateTime registerDate;

  Product({
    String? id,
    this.urlImage,
    required this.name,
    required this.type,
    required this.status,
    required this.un,
    required this.price,
    required this.company,
    DateTime? registerDate,
  })  : id = id ?? const Uuid().v4(),
        registerDate = registerDate ?? DateTime.now() 
  {
    if(name.trim().isEmpty) throw Exception('Nome do produto não pode ser vazio');
    if(price <= 0) throw Exception('Preço inválido (menor ou igual a zero)');
  }
}
