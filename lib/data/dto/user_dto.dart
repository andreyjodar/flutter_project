class UserDto {
  final String id;
  final String? name;
  final String email;
  final String password;
  final String type;
  final String? address;
  final String registerDate;

  UserDto({
    required this.id,
    this.name,
    required this.email,
    required this.password,
    required this.type,
    this.address,
    required this.registerDate,
  });
}