import 'package:uuid/uuid.dart';

class User {
  String id;
  String name;
  String email;
  String password;
  String type;
  DateTime registerDate;

  User({
    String? id,
    required this.name,
    required this.email,
    required this.password,
    required this.type,
    DateTime? registerDate,
  }) : id = id ?? const Uuid().v4(), 
       registerDate = registerDate ?? DateTime.now();
}