class CardHolderName {
  final String _value;

  CardHolderName(String name)
    : _value = name {
      if(!RegExp(r'^[A-Z ]{1,16}$').hasMatch(_value)) {
        throw Exception('Nome do titular inválido');
      }
    }

  @override
  String toString() => _value;
}