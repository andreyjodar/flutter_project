import 'package:flutter_project/domain/valueobjects/password.dart';
import 'package:flutter_project/domain/valueobjects/address.dart';
import 'package:flutter_project/domain/valueobjects/email.dart';

enum UserType { producer, buyer }

class User {
  final String _id;
  String? _name;
  final Email _email;
  Password _password;
  UserType _type;
  Address? _address;
  final DateTime _registerDate;

  User({
    required String id,
    String? name, 
    required Email email, 
    required Password password, 
    required UserType type,
    Address? address,
    DateTime? registerDate
  }) : _id = id, 
       _name = name,
       _email = email,
       _password = password,
       _type = type,
       _address = address,
       _registerDate = registerDate ?? DateTime.now() {
          if (_name != null && _name!.isEmpty) throw Exception('Nome do usuário não pode ser vazio');
       }

  String get id => _id;

  String? get name => _name;

  Email get email => _email;

  Password get password => _password;

  UserType get type => _type;

  Address? get address => _address;

  DateTime get registerDate => _registerDate;

  void changePassword(Password password) {
    _password = password;
  }

  void changeName(String name) {
    if(name.trim().isEmpty) throw Exception('Nome de usuário não pode ser vazio');
    _name = name.trim();
  }

  void updateAddress(Address address) {
    _address = address;
  }
  
  void changeToPuducer() {
    _type = UserType.producer;
  }

  void changeToBuyer() {
    _type = UserType.buyer;
  }

  bool isProducer() => _type == UserType.producer;

  bool isBuyer() => _type == UserType.buyer;
}