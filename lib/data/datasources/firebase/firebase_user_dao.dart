// data/datasources/firebase_user_dao.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_project/data/datasources/user_dao.dart';
import 'package:flutter_project/data/dto/user_dto.dart';

class FirebaseUserDao implements UserDao {
  final FirebaseFirestore _firestore;

  FirebaseUserDao(this._firestore);

  @override
  Future<void> save(UserDto userDto) async {
    await _firestore.collection('users').doc(userDto.id).set(userDto.toMap());
  }

  @override
  Future<UserDto?> getById(String id) async {
    final doc = await _firestore.collection('users').doc(id).get();
    if (doc.exists) {
      return UserDto.fromMap(doc.data()!);
    } else {
      return null;
    }
  }
}
