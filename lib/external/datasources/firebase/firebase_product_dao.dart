import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_project/domain/entities/product.dart';
import 'package:flutter_project/infrastructure/datasources/product_dao_interface.dart';
import 'package:flutter_project/infrastructure/models/product_dto.dart';

class FirebaseProductDao implements ProductDaoInterface {
  final FirebaseFirestore _firestore;
  final String _collection = 'products';

  FirebaseProductDao(this._firestore);

  @override
  Future<void> create(ProductDto product) async {
    await _firestore
      .collection(_collection)
      .doc(product.id)
      .set(product.toMap());
  }

  @override
  Future<void> update(ProductDto product) async {
    await _firestore
      .collection(_collection)
      .doc(product.id)
      .update(product.toMap());
  }

  @override
  Future<void> delete(String id) async {
    await _firestore
      .collection(_collection)
      .doc(id)
      .delete();
  }

  @override
  Future<List<ProductDto>> getAll() async {
    final query = await _firestore
      .collection(_collection)
      .get();
    return query.docs.map((doc) => ProductDto.fromMap(doc.data())).toList();
  }

  @override
  Future<List<ProductDto>> getByCompany(String companyId) async {
    final query = await _firestore
      .collection(_collection)
      .where('companyId', isEqualTo: companyId)
      .get();
    return query.docs.map((doc) => ProductDto.fromMap(doc.data())).toList();
  }

  @override
  Future<ProductDto?> getById(String id) async {
    final doc = await _firestore
      .collection(_collection)
      .doc(id)
      .get();
    if(doc.exists && doc.data() != null) {
      return ProductDto.fromMap(doc.data()!);
    }
    return null;
  }

  @override
  Future<List<ProductDto>> getByType(ProductType type) async {
    final typeString = _productTypeToString(type);
    final query = await _firestore
      .collection(_collection)
      .where('type', isEqualTo: typeString)
      .get();
    return query.docs.map((doc) => ProductDto.fromMap(doc.data())).toList();
  }

  String _productTypeToString(ProductType type) {
    switch (type) {
      case ProductType.fruit:
        return 'fruit';
      case ProductType.grain:
        return 'grain';
      case ProductType.tuber:
        return 'tuber';
      case ProductType.vegetable:
        return 'vegetable';
    }
  }
}