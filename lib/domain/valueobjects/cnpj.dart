class Cnpj {
  final String value;

  Cnpj(this.value) {
    if(!RegExp(r'^\d{2}\.\d{3}\.\d{3}/\d{4}-\d{2}$').hasMatch(value)) {
      throw Exception('CPF com formato inválido');
    }
  }

  @override
  String toString() => value;
}