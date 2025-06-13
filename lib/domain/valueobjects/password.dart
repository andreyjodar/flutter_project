class Password {
  final String value;

  Password(this.value) {
    if (value.length < 8) {
      throw Exception('Senha tem menos de 8 caracteres');
    }
  }

  @override
  String toString() => value;
}