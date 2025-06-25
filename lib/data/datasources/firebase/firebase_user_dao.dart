// data/datasources/firebase/firebase_user_dao.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_project/data/datasources/user_dao.dart';
import 'package:flutter_project/data/dto/user_dto.dart';

class FirebaseUserDao implements UserDaoInterface {
  final FirebaseFirestore _firestore;
  final String _collectionPath = 'users';

  FirebaseUserDao(this._firestore);

  @override
  Future<void> create(UserDto userDto) async {
    await _firestore.collection(_collectionPath).doc(userDto.id).set(userDto.toMap());
  }

  @override
  Future<void> update(UserDto userDto) async {
    await _firestore.collection(_collectionPath).doc(userDto.id).update(userDto.toMap());
  }

  @override
  Future<void> delete(String userId) async {
    await _firestore.collection(_collectionPath).doc(userId).delete();
  }

  @override
  Future<UserDto?> getById(String id) async {
    final doc = await _firestore.collection(_collectionPath).doc(id).get();
    if (doc.exists && doc.data() != null) {
      return UserDto.fromMap(doc.data()!);
    }
    return null;
  }

  @override
  Future<UserDto?> getByEmail(String email) async {
    final query = await _firestore
        .collection(_collectionPath)
        .where('email', isEqualTo: email)
        .limit(1)
        .get();

    if (query.docs.isNotEmpty) {
      return UserDto.fromMap(query.docs.first.data());
    }
    return null;
  }

  @override
  Future<List<UserDto>> getAll() async {
    final query = await _firestore.collection(_collectionPath).get();
    return query.docs.map((doc) => UserDto.fromMap(doc.data())).toList();
  }
}