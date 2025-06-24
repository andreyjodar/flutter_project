import 'package:flutter_project/data/models/user_dto.dart';
import 'package:uuid/uuid.dart';

class CompanyDTO {
  String id;
  String? urlImage;
  String name;
  String description;
  String cnpj;
  UserDTO producer;
  String address;
  DateTime registerDate;

  CompanyDTO({
    String? id,
    this.urlImage,
    required this.name,
    required this.description,
    required this.cnpj,
    required this.producer,
    required this.address,
    DateTime? registerDate,
  })  : id = id ?? const Uuid().v4(),
        registerDate = registerDate ?? DateTime.now();
}
