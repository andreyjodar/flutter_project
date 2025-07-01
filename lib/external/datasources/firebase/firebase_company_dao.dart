import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_project/infrastructure/datasources/company_dao_interface.dart';
import 'package:flutter_project/infrastructure/models/company_dto.dart';

class FirebaseCompanyDao implements CompanyDaoInterface {
  final FirebaseFirestore _firestore;
  final String _collection = 'companies';

  FirebaseCompanyDao(this._firestore);

  @override
  Future<void> create(CompanyDto companyDto) async {
    await _firestore.collection(_collection).doc(companyDto.id).set(companyDto.toMap());
  }

  @override
  Future<void> delete(String companyId) async {
    await _firestore.collection(_collection).doc(companyId).delete();
  }

  @override
  Future<void> update(CompanyDto companyDto) async {
    await _firestore.collection(_collection).doc(companyDto.id).update(companyDto.toMap());
  }

  @override
  Future<CompanyDto?> getById(String id) async {
    final doc = await _firestore.collection(_collection).doc(id).get();
    if (!doc.exists) return null;
    return CompanyDto.fromMap(doc.data()!);
  }

@override
Future<CompanyDto?> getByCnpj(String cnpj) async {
  final querySnapshot = await _firestore
      .collection(_collection)
      .where('cnpj', isEqualTo: cnpj)
      .limit(1) 
      .get();

  if (querySnapshot.docs.isEmpty) return null;

  return CompanyDto.fromMap(querySnapshot.docs.first.data());
}

  @override
  Future<List<CompanyDto>> getAll() async {
    final querySnapshot = await _firestore.collection(_collection).get();
    return querySnapshot.docs
        .map((doc) => CompanyDto.fromMap(doc.data()))
        .toList();
  }

  @override
  Future<List<CompanyDto>> getByUser(String userId) async {
    final querySnapshot = await _firestore
        .collection(_collection)
        .where('producerId', isEqualTo: userId)
        .get();

    return querySnapshot.docs
        .map((doc) => CompanyDto.fromMap(doc.data()))
        .toList();
  }
}
