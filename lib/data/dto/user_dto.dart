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
  
  factory UserDto.fromMap(Map<String, dynamic> map) {
    return UserDto(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      password: map['password'],
      type: map['type'],
      address: map['address'],
      registerDate: map['registerDate'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'type': type,
      'address': address,
      'registerDate': registerDate,
    };
  }
}