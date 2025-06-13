class Email {
  final String value;

  Email(this.value) {
    if (!RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$').hasMatch(value)) {
      throw Exception('Email com formato inválido');
    }
  }

  @override
  String toString() => value;
}