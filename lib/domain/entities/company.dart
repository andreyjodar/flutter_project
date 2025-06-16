import 'package:flutter_project/domain/entities/user.dart';
import 'package:flutter_project/domain/valueobjects/Cnpj.dart';
import 'package:flutter_project/domain/valueobjects/address.dart';
import 'package:uuid/uuid.dart';

class Company {
  final String id;
  String? urlImage;
  String name;
  String description;
  final Cnpj cnpj;
  final User producer;
  Address address;
  final DateTime registerDate;

  Company({
    String? id,
    this.urlImage,
    required this.name,
    required this.description,
    required this.cnpj,
    required this.producer,
    required this.address,
    DateTime? registerDate
  })  : id = id ?? const Uuid().v4(),
        registerDate = registerDate ?? DateTime.now()
  {
    if(name.trim().isEmpty) throw Exception('Nome da empresa não pode ser vazio');
    if(description.trim().isEmpty) throw Exception('Descrição da empresa não pode ser vazia');
    if(producer.isBuyer()) throw Exception('Somente usuários do tipo produtor podem criar empresas');
  }

  void changeName(String name) {
    if(name.trim().isEmpty) throw Exception('Nome da empresa não pode ser vazio');
    this.name = name.trim();
  }

  void changeDescription(String description) {
    if(description.trim().isEmpty) throw Exception('Descrição da empresa não pode ser vazia');
    this.description = description.trim();
  }

  void updateAddress(Address address) {
    this.address = address;
  }
}