class PasswordValidator {
  const PasswordValidator();

  bool isValid(String password) {
    if(password.length >= 8) {
      return true;
    }
    return false;
  }

  String? validate(String? password) {
    if (password == null || password.isEmpty) {
      return 'Senha nula ou vazia';
    }
    if (password.length < 8) {
      return 'Senha deve ter no mínimo 8 caracteres';
    }
    return null;
  }
}