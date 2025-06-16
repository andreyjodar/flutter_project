import 'package:flutter_project/domain/valueobjects/Password.dart';
import 'package:flutter_project/domain/valueobjects/address.dart';
import 'package:flutter_project/domain/valueobjects/email.dart';
import 'package:uuid/uuid.dart';

enum UserType { producer, buyer }

class User {
  final String id;
  String name;
  final Email email;
  Password password;
  UserType type;
  Address address;
  final DateTime registerDate;

  User({
    String? id,
    required this.name, 
    required this.email, 
    required this.password, 
    required this.type,
    required this.address,
    DateTime? registerDate
  }) : id = id ?? Uuid().v4(), 
       registerDate = registerDate ?? DateTime.now() 
  {
    if(name.trim().isEmpty) throw Exception('Nome do usuário não pode ser vazio');
  }

  void changePassword(Password password) {
    this.password = password;
  }

  void changeType(UserType type) {
    this.type = type;
  }

  void changeName(String name) {
    if(name.trim().isEmpty) throw Exception('Nome de usuário não pode ser vazio');
    this.name = name.trim();
  }

  void updateAddress(Address address) {
    this.address = address;
  }

  bool isProducer() => type == UserType.producer;

  bool isBuyer() => type == UserType.buyer;
}