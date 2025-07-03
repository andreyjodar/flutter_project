class ProductDto {
  String id;
  String? urlImage;
  String name;
  String? description;
  String type;
  String status;
  String unit;
  double price;
  String companyId;
  String registerDate;

  ProductDto({
    required this.id,
    this.urlImage,
    required this.name,
    this.description,
    required this.type,
    required this.status,
    required this.unit,
    required this.price,
    required this.companyId,
    required this.registerDate,
  });

  factory ProductDto.fromMap(Map<String, dynamic> map) {
    return ProductDto(
      id: map['id'],
      urlImage: map['urlImage'],
      name: map['name'],
      description: map['description'],
      type: map['type'],
      status: map['status'],
      unit: map['unit'],
      price: map['price'],
      companyId: map['companyId'],
      registerDate: map['registerDate'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'urlImage': urlImage,
      'name': name,
      'description': description,
      'type': type,
      'status': status,
      'unit': unit,
      'price': price,
      'companyId': companyId,
      'registerDate': registerDate,
    };
  }
}
