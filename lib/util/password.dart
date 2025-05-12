class Password {
    static String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Senha nula ou vazia';
    }
    if (value.length < 8) {
      return 'Senha deve ter no mínimo 8 caracteres';
    }
    return null;
  }
}