import 'package:flutter_project/domain/entities/company.dart';
import 'package:flutter_project/domain/entities/product.dart';

class ProductFormArgs {
  final Company company;
  final Product? product;

  ProductFormArgs({required this.company, this.product});
}
