class Decimal {
  static String? validate(String? value) {
    if(value == null || value.isEmpty) {
      return 'Valor nulo ou vazio';
    }
    final parsedValue = double.tryParse(value.replaceAll(',', '.'));
    if (parsedValue == null) {
      return 'Formato inválido';
    }
    if (parsedValue <= 0) {
      return 'Valor inválido';
    }
    return null;
  }
}