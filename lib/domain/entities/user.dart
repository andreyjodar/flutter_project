import 'package:flutter_project/core/utils/validators/email_validator.dart';
import 'package:flutter_project/core/utils/validators/password_validator.dart';

class User {
  String id;
  String name;
  String email;
  String password;
  String type;
  DateTime registerDate;

  static const validTypes = ['Produtor', 'Comprador'];

  User({
    required this.id,
    required this.name, 
    required this.email, 
    required this.password, 
    required this.type,
    required this.registerDate
  }) {
    _validate();
  }

  void _validate() {
    if(name.trim().isEmpty) throw Exception('Nome não poder estar vazio');
    if(!EmailValidator().isValid(email)) throw Exception('Email inválido');
    if(!PasswordValidator().isValid(password)) throw Exception('Senha com menos de 8 caracteres');
    if(!validTypes.contains(type)) throw Exception('Tipo deve ser "Produtor" ou "Comprador"');
  }

  bool isProducer() => type == "Produtor";
  bool isBuyer() => type == "Comprador";
}