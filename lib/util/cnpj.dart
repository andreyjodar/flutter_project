class CnpjValidator {
  const CnpjValidator();

  String? validate(String? cnpj) {
    if(cnpj == null || cnpj.isEmpty) {
      return 'CNPJ nulo ou vazio';
    }
    final cnpjRegex = RegExp(r'^\d{2}\.\d{3}\.\d{3}/\d{4}-\d{2}$');
    if(!cnpjRegex.hasMatch(cnpj)) {
      return 'Formato inválido';
    }
    return null;
  }
}