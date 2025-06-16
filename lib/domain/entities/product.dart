import 'package:flutter_project/domain/entities/company.dart';
import 'package:uuid/uuid.dart';

enum ProductType { vegetable, fruit, tuber, grain }
enum ProductStatus { available, unavailable }
enum ProductUn { unit, kilogram, milliliters, pack }

class Product {
  final String id;
  String? urlImage;
  String name;
  String description;
  final ProductType type;
  ProductStatus status;
  ProductUn unit;
  double price;
  final Company company;
  final DateTime registerDate;

  Product({
    String? id,
    this.urlImage,
    required this.name,
    required this.description,
    required this.type,
    required this.status,
    required this.unit,
    required this.price,
    required this.company,
    DateTime? registerDate,
  })  : id = id ?? const Uuid().v4(),
        registerDate = registerDate ?? DateTime.now() 
  {
    if(name.trim().isEmpty) throw Exception('Nome do produto não pode ser vazio');
    if(description.trim().isEmpty) throw Exception('Descrição do produto não pode ser vazia');
    if(price <= 0) throw Exception('Preço inválido (menor ou igual a zero)');
  }

  void changeName(String name) {
    if(name.trim().isEmpty) throw Exception('Nome do produto não pode ser vazio');
    this.name = name.trim();
  }

  void changeDescription(String description) {
    if(description.trim().isEmpty) throw Exception('Descrição do produto não pode ser vazia');
    this.description = description.trim();
  }

  void updateStatus(ProductStatus status) {
    this.status = status;
  }

  void changeUn(ProductUn unit) {
    this.unit = unit;
  }

  void updatePrice(double price) {
    if(price <= 0) throw Exception('Preço inválido (menor ou igual a zero)');
    this.price = price;
  }

  bool isVegetable() => type == ProductType.vegetable;

  bool isTuber() => type == ProductType.tuber;

  bool isGrain() => type == ProductType.grain;

  bool isFruit() => type == ProductType.fruit;

  bool isAvailable() => status == ProductStatus.available;

  bool isUnavailable() => status == ProductStatus.unavailable;
}
