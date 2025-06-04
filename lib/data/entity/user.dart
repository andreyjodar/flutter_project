class User {
  String name;
  String email;
  String password;
  String type;
  DateTime registerDate;

  User({
    required this.name,
    required this.email,
    required this.password,
    required this.type,
    DateTime? registerDate,
  }) : registerDate = registerDate ?? DateTime.now();
}