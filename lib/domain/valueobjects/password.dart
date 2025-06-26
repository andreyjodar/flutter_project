class Password {
  final String _value;

  Password(String password) 
    : _value = password {
    if (_value.length < 8) {
      throw Exception('Senha tem menos de 8 caracteres');
    }
  }

  bool isValid(String password) {
    if(_value == password) {
      return true;
    }
    return false;
  }

  @override
  String toString() => _value;
}