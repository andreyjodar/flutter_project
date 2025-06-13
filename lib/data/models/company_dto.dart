import 'package:uuid/uuid.dart';

class CompanyDTO {
  String id;
  String? urlImage;
  String name;
  String cnpj;
  String producerId;
  String address;
  DateTime registerDate;

  CompanyDTO({
    String? id,
    this.urlImage,
    required this.name,
    required this.cnpj,
    required this.producerId,
    required this.address,
    DateTime? registerDate,
  })  : id = id ?? const Uuid().v4(),
        registerDate = registerDate ?? DateTime.now();
}
