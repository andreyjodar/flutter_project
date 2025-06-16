class AddressValidator {
  const AddressValidator();
  
  String? validate(String? address) {
    if(address == null || address.isEmpty) {
      return 'Endereço nulo ou vazio';
    }
    final addressRegex = RegExp(r'^.+,\s*\d+$');
    if(!addressRegex.hasMatch(address)) {
      return 'Formato inválido';
    }
    return null;
  }
}