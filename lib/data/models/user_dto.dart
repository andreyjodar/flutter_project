import 'package:uuid/uuid.dart';

class UserDTO {
  String id;
  String? urlImage;
  String name;
  String email;
  String password;
  String type;
  String address;
  DateTime registerDate;

  UserDTO({
    String? id,
    this.urlImage,
    required this.name,
    required this.email,
    required this.password,
    required this.type,
    required this.address,
    DateTime? registerDate,
  }) : id = id ?? const Uuid().v4(), 
       registerDate = registerDate ?? DateTime.now();
}