import 'package:flutter_project/infrastructure/models/company_dto.dart';
import 'package:flutter_project/domain/entities/company.dart';
import 'package:flutter_project/domain/valueobjects/Cnpj.dart';
import 'package:flutter_project/domain/valueobjects/address.dart';

class CompanyAdapter {
  static Company fromDto(CompanyDto dto) {
    return Company(
      id: dto.id, 
      name: dto.name, 
      cnpj: Cnpj(dto.cnpj), 
      producer: producer, 
      address: Address(dto.address)
    );
  }

  static CompanyDto toDto(Company user) {
    return CompanyDto(
      id: id, 
      name: name, 
      cnpj: cnpj, 
      producer: producer, 
      address: address, 
      registerDate: registerDate
    );
  }
}