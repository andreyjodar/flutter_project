import 'package:flutter_project/domain/valueobjects/Password.dart';
import 'package:flutter_project/domain/valueobjects/email.dart';
import 'package:uuid/uuid.dart';

enum UserType {
  produtor, 
  comprador
}

class User {
  String id;
  String name;
  Email email;
  Password password;
  UserType type;
  DateTime registerDate;

  User({
    String? id,
    required this.name, 
    required this.email, 
    required this.password, 
    required this.type,
    DateTime? registerDate
  }) : id = id ?? Uuid().v4(), 
       registerDate = registerDate ?? DateTime.now() 
  {
    if(name.trim().isEmpty) throw Exception('Nome do usuário não pode ser vazio');
  }

  bool isProducer() => type == UserType.produtor;
  bool isBuyer() => type == UserType.comprador;
}