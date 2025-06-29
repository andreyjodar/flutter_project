import 'package:flutter_project/domain/valueobjects/password.dart';
import 'package:flutter_project/domain/valueobjects/address.dart';
import 'package:flutter_project/domain/valueobjects/email.dart';

enum UserType { producer, buyer }

class User {
  final String _id;
  String _name;
  final Email _email;
  Password _password;
  UserType _type;
  Address? _address;
  final DateTime _registerDate;

  User({
    required String id,
    required String name, 
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
       _registerDate = registerDate ?? DateTime.now();

  String get id => _id;
  String get name => _name;
  String get email => _email.toString();
  String get password => _password.toString(); // Ainda quero mudar isso!
  UserType get type => _type;
  String? get address => _address.toString();
  DateTime get registerDate => _registerDate;

  void changePassword(Password password) {
    _password = password;
  }

  bool isValidPassword(String password) {
    if(_password.toString() == password.trim()) {
      return true;
    }
    return false;
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