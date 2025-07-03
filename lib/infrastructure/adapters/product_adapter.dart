import 'package:flutter_project/domain/entities/company.dart';
import 'package:flutter_project/domain/entities/product.dart';
import 'package:flutter_project/infrastructure/models/product_dto.dart';

class ProductAdapter {
  static Product fromDto(ProductDto dto, Company company) {
    return Product(
      id: dto.id,
      urlImage: dto.urlImage,
      name: dto.name,
      description: dto.description,
      type: _getProductTypeFromString(dto.type),
      status: _getProductStatusFromString(dto.status),
      unit: _getProductUnitFromString(dto.unit),
      price: dto.price,
      company: company,
      registerDate: DateTime.parse(dto.registerDate),
    );
  }

  static ProductDto toDto(Product product) {
    return ProductDto(
      id: product.id,
      urlImage: product.urlImage,
      name: product.name,
      description: product.description,
      type: product.type.name,
      status: product.status.name,
      unit: product.unit.name,
      price: product.price,
      companyId: product.company.id,
      registerDate: product.registerDate.toIso8601String(),
    );
  }

  static ProductType _getProductTypeFromString(String type) {
    switch (type) {
      case 'vegetable':
        return ProductType.vegetable;
      case 'fruit':
        return ProductType.fruit;
      case 'tuber':
        return ProductType.tuber;
      case 'grain':
        return ProductType.grain;
      default:
        throw Exception('Tipo de produto desconhecido: $type');
    }
  }

  static ProductStatus _getProductStatusFromString(String status) {
    switch (status) {
      case 'available':
        return ProductStatus.available;
      case 'unavailable':
        return ProductStatus.unavailable;
      default:
        throw Exception('Status de produto desconhecido: $status');
    }
  }

  static ProductUnit _getProductUnitFromString(String unit) {
    switch (unit) {
      case 'unit':
        return ProductUnit.unit;
      case 'kilogram':
        return ProductUnit.kilogram;
      case 'milliliters':
        return ProductUnit.milliliters;
      case 'pack':
        return ProductUnit.pack;
      default:
        throw Exception('Unidade de produto desconhecida: $unit');
    }
  }
}
