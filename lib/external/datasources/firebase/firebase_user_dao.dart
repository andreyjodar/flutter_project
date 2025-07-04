// data/datasources/firebase/firebase_user_dao.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_project/domain/entities/user.dart';
import 'package:flutter_project/infrastructure/datasources/user_dao_interface.dart';
import 'package:flutter_project/infrastructure/models/user_dto.dart';

class FirebaseUserDao implements UserDaoInterface {
  final FirebaseFirestore _firestore;
  final String _collection = 'users';

  FirebaseUserDao(this._firestore);

  @override
  Future<void> create(UserDto userDto) async {
    await _firestore
      .collection(_collection)
      .doc(userDto.id)
      .set(userDto.toMap());
  }

  @override
  Future<void> update(UserDto userDto) async {
    await _firestore
      .collection(_collection)
      .doc(userDto.id)
      .update(userDto.toMap());
  }

  @override
  Future<void> delete(String userId) async {
    await _firestore
      .collection(_collection)
      .doc(userId)
      .delete();
  }

  @override
  Future<UserDto?> getById(String id) async {
    final doc = await _firestore
      .collection(_collection)
      .doc(id)
      .get();
    if (doc.exists && doc.data() != null) {
      return UserDto.fromMap(doc.data()!);
    }
    return null;
  }

  @override
  Future<UserDto?> getByEmail(String email) async {
    final query = await _firestore
        .collection(_collection)
        .where('email', isEqualTo: email)
        .limit(1)
        .get();

    if (query.docs.isNotEmpty) {
      return UserDto.fromMap(query.docs.first.data());
    }
    return null;
  }

  @override
  Future<List<UserDto>> getByType(UserType type) async {
    String typeString = _userTypeToString(type);
    final query = await _firestore
        .collection(_collection)
        .where('type', isEqualTo: typeString)
        .get();
    return query.docs.map((doc) => UserDto.fromMap(doc.data())).toList();
  }

  @override
  Future<List<UserDto>> getAll() async {
    final query = await _firestore
      .collection(_collection)
      .get();
    return query.docs.map((doc) => UserDto.fromMap(doc.data())).toList();
  }

  String _userTypeToString(UserType type) {
    switch (type) {
      case UserType.buyer:
        return 'buyer';
      case UserType.producer:
        return 'producer';
    }
  }
}