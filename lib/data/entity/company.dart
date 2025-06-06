import 'package:uuid/uuid.dart';

class Company {
  String id;
  String name;
  String cnpj;
  String userId;
  String address;
  DateTime registerDate;

  Company({
    String? id,
    required this.name,
    required this.cnpj,
    required this.userId,
    required this.address,
    DateTime? registerDate,
  })  : id = id ?? const Uuid().v4(),
        registerDate = registerDate ?? DateTime.now();
}
