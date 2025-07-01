// adapters/user_adapter.dart
import 'package:flutter_project/domain/entities/user.dart';
import 'package:flutter_project/infrastructure/models/user_dto.dart';
import 'package:flutter_project/domain/valueobjects/email.dart';
import 'package:flutter_project/domain/valueobjects/password.dart';
import 'package:flutter_project/domain/valueobjects/address.dart';

class UserAdapter {
  static User fromDto(UserDto dto) {
    return User(
      id: dto.id,
      name: dto.name,
      email: Email(dto.email),
      password: Password(dto.password),
      type: dto.type == 'producer' ? UserType.producer : UserType.buyer,
      address: dto.address != null ? Address(dto.address!) : null,
      registerDate: DateTime.parse(dto.registerDate),
    );
  }

  static UserDto toDto(User user) {
    return UserDto(
      id: user.id,
      name: user.name,
      email: user.email.toString(),
      password: user.password.toString(),
      type: user.type.name,
      address: user.address,
      registerDate: user.registerDate.toIso8601String(),
    );
  }
}
