class SecurityCode {
  final String _value;

  SecurityCode(String code) 
    : _value = code {
      if(!RegExp(r'^\d{3}$').hasMatch(_value)) {
        throw Exception('Código de segurança inválido');
      }
    }

  @override
  String toString() => _value;
}