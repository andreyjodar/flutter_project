import 'package:flutter_project/domain/entities/company.dart';

enum ProductType { vegetable, fruit, tuber, grain }
enum ProductStatus { available, unavailable }
enum ProductUnit { unit, kilogram, milliliters, pack }

class Product {
  final String _id;
  String? _urlImage;
  String _name;
  String? _description;
  final ProductType _type;
  ProductStatus _status;
  ProductUnit _unit;
  double _price;
  final Company _company;
  final DateTime _registerDate;

  Product({
    required String id,
    String? urlImage,
    required String name,
    String? description,
    required ProductType type,
    required ProductStatus status,
    required ProductUnit unit,
    required double price,
    required Company company,
    DateTime? registerDate,
  })  : _id = id,
        _urlImage = urlImage,
        _name = name,
        _description = description,
        _type = type,
        _status = status,
        _unit = unit,
        _price = price,
        _company = company,
        _registerDate = registerDate ?? DateTime.now()
  {
    if(_price <= 0) throw Exception('Preço inválido (menor ou igual a zero)');
  }

  String get id => _id;
  String? get urlImage => _urlImage;
  String get name => _name;
  String? get description => _description;
  ProductType get type => _type;
  ProductStatus get status => _status;
  ProductUnit get unit => _unit;
  double get price => _price;
  Company get company => _company;
  DateTime get registerDate => _registerDate;

  void changeName(String name) {
    if(name.trim().isEmpty) throw Exception('Nome do produto não pode ser vazio');
    _name = name.trim();
  }

  void changeDescription(String description) {
    _description = description.trim();
  }

  void updateStatus(ProductStatus status) {
    _status = status;
  }

  void changeUn(ProductUnit unit) {
    _unit = unit;
  }

  void changeUrlImage(String urlImage) {
    _urlImage = urlImage;
  }

  void updatePrice(double price) {
    if(price <= 0) throw Exception('Preço inválido (menor ou igual a zero)');
    _price = price;
  }

  bool isVegetable() => _type == ProductType.vegetable;
  bool isTuber() => _type == ProductType.tuber;
  bool isGrain() => _type == ProductType.grain;
  bool isFruit() => _type == ProductType.fruit;
  bool isAvailable() => _status == ProductStatus.available;
  bool isUnavailable() => _status == ProductStatus.unavailable;
}
