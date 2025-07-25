class CardNumber {
  final String _value;

  CardNumber(String email)
    : _value = email {
      if(!RegExp(r'^\d{4} \d{4} \d{4} \d{4}$').hasMatch(_value)) {
        throw Exception('Cartão de crédito com número inválido');
      }
    }

  @override
  String toString() => _value;
}