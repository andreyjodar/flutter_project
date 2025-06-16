class Address {
  final String value;

  Address(this.value) {
    if(!RegExp(r'^.+,\s*\d+$').hasMatch(value)) {
      throw Exception('Endereço inválido (Formato válido: "logradouro, número")');
    }
  }

  @override
  String toString() => value;
}