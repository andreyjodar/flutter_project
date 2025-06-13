import 'package:flutter_project/domain/entities/user.dart';
import 'package:flutter_project/domain/valueobjects/Cnpj.dart';
import 'package:uuid/uuid.dart';

class Company {
  String id;
  String? urlImage;
  String name;
  Cnpj cnpj;
  User producer;
  String address;
  DateTime registerDate;

  Company({
    String? id,
    this.urlImage,
    required this.name,
    required this.cnpj,
    required this.producer,
    required this.address,
    DateTime? registerDate,
  })  : id = id ?? const Uuid().v4(),
        registerDate = registerDate ?? DateTime.now();
}