class CompanyDto {
  String id;
  String? urlImage;
  String name;
  String? description;
  String cnpj;
  String producerId;
  String address;
  String registerDate;

  CompanyDto({
    required this.id,
    this.urlImage,
    required this.name,
    this.description,
    required this.cnpj,
    required this.producerId,
    required this.address,
    required this.registerDate,
  });

    factory CompanyDto.fromMap(Map<String, dynamic> map) {
    return CompanyDto(
      id: map['id'],
      urlImage: map['urlImage'],
      name: map['name'],
      description: map['description'],
      cnpj: map['cnpj'],
      producerId: map['producerId'],
      address: map['address'],
      registerDate: map['registerDate'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'urlImage': urlImage,
      'name': name,
      'description': description,
      'cnpj': cnpj,
      'producerId': producerId,
      'address': address,
      'registerDate': registerDate,
    };
  }
}
