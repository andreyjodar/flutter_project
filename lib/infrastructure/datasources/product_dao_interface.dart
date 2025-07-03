import 'package:flutter_project/domain/entities/product.dart';
import 'package:flutter_project/infrastructure/models/product_dto.dart';

abstract class ProductDaoInterface {
  Future<ProductDto?> getById(String id);
  Future<List<ProductDto>> getByCompany(String companyId);
  Future<List<ProductDto>> getByType(ProductType type);
  Future<List<ProductDto>> getAll();
  Future<void> create(ProductDto product);
  Future<void> update(ProductDto product);
  Future<void> delete(String id);
}