import 'package:flutter_project/domain/entities/product.dart';

abstract class ProductRepositoryInterface {
  Future<Product?> getProductById(String id);
  Future<List<Product>> getProductsByCompany(String companyId);
  Future<List<Product>> getProductsByType(ProductType type);
  Future<List<Product>> getAllProducts();
  Future<void> createProduct(Product product);
  Future<void> updateProduct(Product product);
  Future<void> deleteProduct(String id);
}