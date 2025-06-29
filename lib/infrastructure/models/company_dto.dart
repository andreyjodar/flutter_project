import 'package:flutter_project/data/dto/user_dto.dart';

class CompanyDto {
  String id;
  String? urlImage;
  String name;
  String? description;
  String cnpj;
  UserDto producer;
  String address;
  DateTime registerDate;

  CompanyDto({
    required this.id,
    this.urlImage,
    required this.name,
    this.description,
    required this.cnpj,
    required this.producer,
    required this.address,
    required this.registerDate,
  });
}
