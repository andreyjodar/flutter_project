import 'package:flutter_project/domain/entities/user.dart';
import 'package:flutter_project/infrastructure/models/company_dto.dart';
import 'package:flutter_project/domain/entities/company.dart';
import 'package:flutter_project/domain/valueobjects/Cnpj.dart';
import 'package:flutter_project/domain/valueobjects/address.dart';

class CompanyAdapter {
  static Company fromDto(CompanyDto dto, User producer) {
    return Company(
      id: dto.id,
      urlImage: dto.urlImage, 
      name: dto.name,
      description: dto.description, 
      cnpj: Cnpj(dto.cnpj), 
      producer: producer, 
      address: Address(dto.address)
    );
  }

  static CompanyDto toDto(Company company) {
    return CompanyDto(
      id: company.id, 
      urlImage: company.urlImage,
      name: company.name,
      description: company.description, 
      cnpj: company.cnpj, 
      producerId: company.producer.id, 
      address: company.address, 
      registerDate: company.registerDate.toIso8601String()
    );
  }
}