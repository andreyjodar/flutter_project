import 'package:flutter_project/domain/entities/user.dart';

class UserViewModel {
  final String name;
  final String email;
  final String type;

  UserViewModel({
    required this.name,
    required this.email,
    required this.type,
  });

  factory UserViewModel.fromEntity(User user) {
    return UserViewModel(
      name: user.name ?? 'Sem nome',
      email: user.email.value,
      type: user.isProducer() ? 'Produtor' : 'Comprador',
    );
  }
}