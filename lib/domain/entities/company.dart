import 'package:flutter_project/domain/entities/user.dart';
import 'package:flutter_project/domain/valueobjects/cnpj.dart';
import 'package:flutter_project/domain/valueobjects/address.dart';

class Company {
  final String _id;
  String? _urlImage;
  String _name;
  String? _description;
  final Cnpj _cnpj;
  final User _producer;
  Address _address;
  final DateTime _registerDate;

  Company({
    required String id,
    String? urlImage,
    required String name,
    String? description,
    required Cnpj cnpj,
    required User producer,
    required Address address,
    DateTime? registerDate
  })  : _id = id,
        _urlImage = urlImage ?? 'https://cdn.pixabay.com/photo/2023/02/18/11/00/icon-7797704_1280.png',
        _name = name,
        _description = description,
        _cnpj = cnpj,
        _producer = producer,
        _address = address,
        _registerDate = registerDate ?? DateTime.now()
  {
    if(!_producer.isProducer()) throw Exception('Usuário não tem a permissão de Produtor');
  }

  String get id => _id;
  String? get urlImage => _urlImage;
  String get name => _name;
  String? get description => _description;
  String get cnpj => _cnpj.toString();
  String get address => _address.toString();
  User get producer => _producer;
  DateTime get registerDate => _registerDate;


  void changeName(String name) {
    if(name.trim().isEmpty) throw Exception('Nome da empresa não pode ser vazio');
    _name = name.trim();
  }

  void changeDescription(String description) {
    if(description.trim().isEmpty) throw Exception('Descrição da empresa não pode ser vazia');
    _description = description.trim();
  }

  void changePicture(String urlImage) {
    _urlImage = urlImage;
  }

  void updateAddress(Address address) {
    _address = address;
  }
}