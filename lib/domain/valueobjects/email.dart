class Email {
  final String _value;

  Email(String email) 
    : _value = email {
    if (!RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$').hasMatch(_value)) {
      throw Exception('Email com formato inválido');
    }
  }

  @override
  String toString() => _value;
}