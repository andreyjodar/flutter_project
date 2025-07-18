import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_project/infrastructure/datasources/cart_dao_interface.dart';
import 'package:flutter_project/infrastructure/models/cart_dto.dart';

class FirebaseCartDao implements CartDaoInterface {
  final FirebaseFirestore _firestore;
  final String _collection = 'carts';

  FirebaseCartDao(this._firestore);

  @override
  Future<void> create(CartDto cartDto) async {
    await _firestore
      .collection(_collection)
      .doc(cartDto.id)
      .set(cartDto.toMap());
  }

  @override
  Future<void> delete(String id) async {
    await _firestore
      .collection(_collection)
      .doc(id)
      .delete();
  }

  @override
  Future<CartDto?> getActiveByBuyer(String buyerId) async {
    final query = await _firestore
      .collection(_collection)
      .where('buyerId', isEqualTo: buyerId)
      .where('isActive', isEqualTo: true)
      .limit(1)
      .get();
    if(query.docs.isNotEmpty) {
      return CartDto.fromMap(query.docs.first.data());
    }
    return null;
  }

  @override
  Future<CartDto?> getById(String id) async {
    final doc = await _firestore
      .collection(_collection)
      .doc(id)
      .get();
    if(doc.exists && doc.data() != null) {
      return CartDto.fromMap(doc.data()!);
    }
    return null;
  }

  @override
  Future<void> update(CartDto cartDto) async {
    await _firestore
      .collection(_collection)
      .doc(cartDto.id)
      .update(cartDto.toMap());
  }
}